const std = @import("std");
const mpg = @import("mpg.zig");
const soundio = @import("soundio.zig");

usingnamespace soundio;

var audioStorage = [_]u8{0} ** (65536);
extern fn write_callback(real_out_stream: [*c]SoundIoOutStream, min_frames: c_int, max_frames: c_int) callconv(.C) void {
    if (real_out_stream == null) std.debug.panic("[FATAL]: out_stream in write_callback was null.\n", .{});

    var fba = std.heap.FixedBufferAllocator.init(&audioStorage);
    var allocator = &fba.allocator;

    const out_stream = @ptrCast(*SoundIoOutStream, real_out_stream);
    const layout = out_stream.layout;
    const seconds_per_frame = 1.0 / @intToFloat(f32, out_stream.sample_rate);
    var real_areas: [*c]SoundIoChannelArea = undefined;

    const dec = @ptrCast(*mpg.mpg123_handle, out_stream.userdata.?);

    var frames_left = max_frames;
    var frame_count = frames_left;

    while (frames_left > 0) : (frames_left -= frame_count) {
        panicIfError(outstream_begin_write(out_stream, &real_areas, &frame_count));
        defer panicIfError(outstream_end_write(out_stream));
        if (frame_count == 0) return;

        fba.reset();
        const num_channels = 2;
        const sample_width = @sizeOf(i16);
        const req_len = @intCast(usize, frame_count * num_channels);
        var buf = allocator.alloc(i16, req_len) catch unreachable;

        var bytes_written: usize = undefined;
        const e = mpg.read_and_decode_source(dec, @ptrCast([*]u8, buf.ptr), @intCast(usize, req_len * sample_width), &bytes_written);
        switch (e) {
            .MPG123_OK => {},
            .MPG123_DONE => {
                std.debug.warn("restarting...\n", .{});
                _ = mpg.seek_frame(dec, 0, 0);
            },
            else => std.debug.panic("[FATAL]: libmpg error -> {}\n", .{@tagName(e)}),
        }
        const areas = @ptrCast([*]SoundIoChannelArea, real_areas)[0..@intCast(usize, layout.channel_count)];

        //NOTE: SoundIO uses interleaved layout internally, so we can just map to the base ptr of the first channel and copy in
        var targ_slice = @ptrCast([*]i16, @alignCast(sample_width, areas[0].ptr))[0..@intCast(usize, req_len)];
        if (bytes_written * num_channels == buf.len) {
            std.mem.copy(i16, targ_slice, buf[0..]);
        } else {
            std.mem.secureZero(i16, targ_slice);
            std.debug.assert(bytes_written % sample_width == 0);
            const end = bytes_written / sample_width;
            std.mem.copy(i16, targ_slice, buf[0..end]);
        }
    }
}

fn panicIfError(err: SoundIoError) void {
    if (err != .None) std.debug.panic("[FATAL]: soundio error -> {}\n", .{@tagName(err)});
}

fn checkError(err: SoundIoError) !void {
    if (err == .None) return;
    std.debug.warn("[FATAL]: soundio error -> {}\n", .{@tagName(err)});
    return error.SoundIoError;
}

pub fn main() !void {
    try checkIfError(mpg.init_lib());
    defer mpg.exit_lib();

    const sio = soundio.create();
    if (sio == null) return error.SoundIoCreateFailed;
    defer soundio.destroy(sio);

    try checkError(connect(sio));
    flush_events(sio);

    const dev_idx = default_output_device_index(sio);
    if (dev_idx < 0) return error.SoundIoNoOutputDevice;

    const device = get_output_device(sio, dev_idx).?;
    defer device_unref(device);

    var out_stream = outstream_create(device).?;
    defer outstream_destroy(out_stream);

    out_stream.format = .S16LE;
    out_stream.write_callback = write_callback;

    const names = mpg.get_supported_decoder_names();
    var idx: usize = 0;
    std.debug.warn("----supported decoders----\n", .{});
    while (names[idx] != null) : (idx += 1) {
        std.debug.warn("{s}\n", .{names[idx]});
    }
    std.debug.warn("--------------------------\n", .{});

    var dec = mpg.get_new_decoder_handle(null, null).?;
    defer mpg.free_decoder(dec);
    try checkIfError(mpg.set_decoder_format_none(dec));

    try checkIfError(mpg.set_decoder_format(dec, 48000, .MPG123_STEREO, .MPG123_ENC_SIGNED_16));
    std.debug.warn("decoder: {s}\n", .{mpg.get_active_decoder(dec)});

    try checkIfError(mpg.load_source_from_path(dec, "breakout.mp3"));

    var rate: c_long = undefined;
    var channels: mpg.mpg123_channelcount = undefined;
    var enc: mpg.mpg123_enc_enum = undefined;
    try checkIfError(mpg.get_source_format(dec, &rate, &channels, &enc));
    std.debug.warn("rate: {} channels: {} enc: {}\n", .{ rate, @tagName(channels), @tagName(enc) });

    out_stream.userdata = dec;
    try checkError(outstream_open(out_stream));
    try checkError(out_stream.layout_error);
    try checkError(outstream_start(out_stream));

    while (true) {
        wait_events(sio);
    }
}
fn checkIfError(e: mpg.mpg123_errors) !void {
    if (e != .MPG123_OK) return error.MPGFailed;
}

pub fn RingBufferSafe(comptime T: type) type {
    return struct {
        const Self = @This();
        allocator: *Allocator,
        read_idx: usize,
        one_past_write_idx: usize,
        num_filled_slots: usize,
        ring_slice: []T,
        array_list: std.ArrayList(T),

        const Iterator = struct {
            read_idx: usize,
            one_past_write_idx: usize,
            slots_to_read: usize,
            ring_slice: []T,

            const IterSelf = @This();

            pub fn next(self: *IterSelf) ?T {
                if (self.slots_to_read == 0) return null;
                const idx = self.read_idx;
                self.read_idx += 1;
                self.slots_to_read -= 1;
                if (self.read_idx == self.ring_slice.len) self.read_idx = 0;
                return self.ring_slice[idx];
            }

            pub fn nextAsPtr(self: *IterSelf) ?*T {
                if (self.slots_to_read == 0) return null;
                const idx = self.read_idx;
                self.read_idx += 1;
                self.slots_to_read -= 1;
                if (self.read_idx == self.ring_slice.len) self.read_idx = 0;
                return &self.ring_slice[idx];
            }
        };

        pub fn iterator(self: *Self) Iterator {
            return Iterator{
                .read_idx = self.read_idx,
                .one_past_write_idx = self.one_past_write_idx,
                .slots_to_read = self.num_filled_slots,
                .ring_slice = self.ring_slice[0..],
            };
        }

        pub fn initCapacity(allocator: *Allocator, size: usize) !Self {
            var buf = try allocator.alloc(T, size);
            return Self{
                .allocator = allocator,
                .read_idx = 0,
                .one_past_write_idx = 0,
                .num_filled_slots = 0,
                .ring_slice = buf,
                .array_list = try std.ArrayList(T).initCapacity(allocator, size),
            };
        }

        pub fn reset(self: *Self) void {
            self.read_idx = 0;
            self.one_past_write_idx = 0;
            self.num_filled_slots = 0;
        }

        pub fn append(self: *Self, value: T) !void {
            if (self.num_filled_slots == self.ring_slice.len) return error.RingIsFull;
            self.ring_slice[self.one_past_write_idx] = value;
            self.one_past_write_idx += 1;
            if (self.one_past_write_idx == self.ring_slice.len) {
                self.one_past_write_idx = 0;
            }
            self.num_filled_slots += 1;
        }

        pub fn appendSlice(self: *Self, values: []T) !void {
            for (values) |v| {
                try append(self, v);
            }
        }

        pub fn popItem(self: *Self) !T {
            if (self.num_filled_slots == 0) return error.RingIsEmpty;
            const ret = self.ring_slice[self.read_idx];
            self.read_idx += 1;
            self.num_filled_slots -= 1;
            if (self.read_idx == self.ring_slice.len) self.read_idx = 0;
            return ret;
        }

        pub fn removeCount(self: *Self, n: usize) !void {
            if (n > self.num_filled_slots) return error.RemoveCountTooLarge;
            self.num_filled_slots -= n;
            self.read_idx += n;
            if (self.read_idx >= self.ring_slice.len) {
                const new_read_idx = self.read_idx % self.ring_slice.len;
                if (new_read_idx > self.one_past_write_idx) unreachable;
                self.read_idx = new_read_idx;
            }
            return;
        }

        pub fn rawSlice(self: *Self) []const T {
            return self.ring_slice[0..];
        }

        pub fn toPackedSlice(self: *Self) []T {
            self.array_list.resize(0) catch unreachable;
            if (self.read_idx < self.one_past_write_idx) {
                return self.ring_slice[self.read_idx..self.one_past_write_idx];
            } else {
                self.array_list.appendSlice(self.ring_slice[self.read_idx..]) catch unreachable;
                self.array_list.appendSlice(self.ring_slice[0..self.one_past_write_idx]) catch unreachable;
            }
            return self.array_list.toSlice();
        }

        pub fn copyIntoSlice(self: *Self, dest: []T) ![]T {
            if (self.num_filled_slots > dest.len) return error.TargetTooSmall;
            if (self.read_idx < self.one_past_write_idx) {
                std.mem.copy(T, dest, self.ring_slice[self.read_idx..self.one_past_write_idx]);
                return dest[0..self.num_filled_slots];
            } else {
                const first = self.ring_slice[self.read_idx..];
                const offset = first.len;
                std.mem.copy(T, dest, first);
                const second = self.ring_slice[0..self.one_past_write_idx];
                std.mem.copy(T, dest[offset..], second);
                return dest[0..(offset + second.len)];
            }
        }
    };
}
