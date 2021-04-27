const std = @import("std");
const cimport = @import("cimport");
const mpg = cimport.mpg;
const soundio = cimport.soundio;

fn checkMpgError(err: mpg.mpg123_errors) !void {
    if (err == .MPG123_OK) return;
    std.debug.warn("[FATAL]: mpg error -> {s}\n", .{@tagName(err)});
    return error.MpgError;
}

fn panicMpgError(err: mpg.mpg123_errors) void {
    if (err != .None) std.debug.panic("[FATAL]: mpg error -> {s}\n", .{@tagName(err)});
}

fn checkSIOError(err: soundio.SoundIoError) !void {
    if (err == .None) return;
    std.debug.warn("[FATAL]: soundio error -> {s}\n", .{@tagName(err)});
    return error.SoundIoError;
}

fn panicSIOError(err: soundio.SoundIoError) void {
    if (err != .None) std.debug.panic("[FATAL]: soundio error -> {s}\n", .{@tagName(err)});
}

var audioStorage = [_]u8{0} ** (65536);
fn write_callback_mp3(real_out_stream: [*c]soundio.SoundIoOutStream, min_frames: c_int, max_frames: c_int) callconv(.C) void {
    if (real_out_stream == null) std.debug.panic("[FATAL]: out_stream in write_callback was null.\n", .{});

    var fba = std.heap.FixedBufferAllocator.init(&audioStorage);
    var allocator = &fba.allocator;

    const out_stream = @ptrCast(*soundio.SoundIoOutStream, real_out_stream);
    const layout = out_stream.layout;
    const seconds_per_frame = 1.0 / @intToFloat(f32, out_stream.sample_rate);
    var real_areas: [*c]soundio.SoundIoChannelArea = undefined;

    const dec = @ptrCast(*mpg.mpg123_handle, out_stream.userdata.?);

    var frames_left = max_frames;
    var frame_count = frames_left;

    while (frames_left > 0) : (frames_left -= frame_count) {
        panicSIOError(soundio.outstream_begin_write(out_stream, &real_areas, &frame_count));
        defer panicSIOError(soundio.outstream_end_write(out_stream));
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
            else => std.debug.panic("[FATAL]: libmpg error -> {s}\n", .{@tagName(e)}),
        }
        const areas = @ptrCast([*]soundio.SoundIoChannelArea, real_areas)[0..@intCast(usize, layout.channel_count)];

        //NOTE: SoundIO uses interleaved layout internally, so we can just map to the base ptr of the first channel and copy in
        var targ_slice = @ptrCast([*]i16, @alignCast(sample_width, areas[0].ptr))[0..@intCast(usize, req_len)];
        if (bytes_written * num_channels == buf.len) {
            std.mem.copy(i16, targ_slice, buf[0..]);
        } else {
            std.mem.set(i16, targ_slice, 0);
            std.debug.assert(bytes_written % sample_width == 0);
            const end = bytes_written / sample_width;
            std.mem.copy(i16, targ_slice, buf[0..end]);
        }
    }
}

const SoundManager = struct {
    const Stream = struct {
        decoder: ?*mpg.mpg123_handle,
        output: ?*soundio.SoundIoOutStream,
        loop: bool = false,
    };
    const StreamMap = PoolMap(Stream);
    soundio_instance: *soundio.SoundIo,
    soundio_device: *soundio.SoundIoDevice,
    background_stream: Stream,
    //effects_map: StreamMap,

    const Self = @This();

    pub fn deinit(self: Self) void {
        mpg.free_decoder(self.looped_stream.decoder);
        soundio.outstream_destroy(self.looped_stream.output);
        mpg.free_decoder(self.effect_stream.decoder);
        soundio.outstream_destroy(self.effect_stream.output);
        mpg.exit_lib();
        soundio.destroy(sio);
    }

    pub fn createStream(self: *Self, path: []const u8) !PoolIdx {
        var out_stream = outstream_create(device).?;
        out_stream.format = .S16LE;
        out_stream.write_callback = write_callback_mp3;
        try checkError(outstream_open(out_stream));
        try checkError(out_stream.layout_error);
        try checkError(outstream_start(out_stream));
        var decoder = mpg.get_new_decoder_handle(null, null).?;
        out_stream.userdata = decoder;
        return self.stream_map.putSingle(.{
            .decoder = mpg.get_new_decoder_handle(null, null).?,
            .output = out_stream,
        });
    }

    pub fn setBackgroundStream(self: *Self, path: [:0]const u8) !void {
        var dec = mpg.get_new_decoder_handle(null, null).?;
        errdefer mpg.free_decoder(dec);
        try checkMpgError(mpg.set_decoder_format_none(dec));
        try checkMpgError(mpg.set_decoder_format(dec, 48000, .MPG123_STEREO, .MPG123_ENC_SIGNED_16));
        try checkMpgError(mpg.load_source_from_path(dec, path));
        var out_stream = soundio.outstream_create(self.soundio_device).?;
        out_stream.userdata = dec;
        out_stream.format = .S16LE;
        out_stream.write_callback = write_callback_mp3;
        var rate: c_long = undefined;
        var channels: mpg.mpg123_channelcount = undefined;
        var enc: mpg.mpg123_enc_enum = undefined;
        try checkMpgError(mpg.get_source_format(dec, &rate, &channels, &enc));
        try checkMpgError(mpg.load_source_from_path(dec, path));
        try checkSIOError(soundio.outstream_open(out_stream));
        try checkSIOError(out_stream.layout_error);
        try checkSIOError(soundio.outstream_start(out_stream));
    }
};

pub fn createSoundManager(allocator: *std.mem.Allocator) !SoundManager {
    try checkMpgError(mpg.init_lib());

    const sio = soundio.create().?;

    try checkSIOError(soundio.connect(sio));
    soundio.flush_events(sio);

    const dev_idx = soundio.default_output_device_index(sio);
    if (dev_idx < 0) return error.SoundIoNoOutputDevice;

    const device = soundio.get_output_device(sio, dev_idx).?;

    return SoundManager{
        .soundio_instance = sio,
        .soundio_device = device,
        .background_stream = undefined,
    };
}
