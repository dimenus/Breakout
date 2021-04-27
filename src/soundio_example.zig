const std = @import("std");
const soundio = @import("soundio.zig");

var secondsOffset: f32 = 0.0;

usingnamespace soundio;

extern fn write_callback(real_out_stream: [*c]SoundIoOutStream, min_frames: c_int, max_frames: c_int) callconv(.C) void {
    if (real_out_stream == null) std.debug.panic("[FATAL]: out_stream in write_callback was null.\n", .{});

    const out_stream = @ptrCast(*SoundIoOutStream, real_out_stream);
    const layout = out_stream.layout;
    const seconds_per_frame = 1.0 / @intToFloat(f32, out_stream.sample_rate);
    var real_areas: [*c]SoundIoChannelArea = undefined;

    var frames_left = max_frames;
    var frame_count = frames_left;
    while (frames_left > 0) : (frames_left -= frame_count) {
        panicIfError(outstream_begin_write(out_stream, &real_areas, &frame_count));
        if (frame_count == 0) return;

        const real_time_freq = 440.0;
        const ang_freq = real_time_freq * 2.0 * std.math.pi;
        var i: c_int = 0;
        const areas = @ptrCast([*]SoundIoChannelArea, real_areas)[0..@intCast(usize, layout.channel_count)];
        while (i < frame_count) : (i += 1) {
            const sample = std.math.sin((secondsOffset + @intToFloat(f32, i) * seconds_per_frame) * ang_freq);
            for (areas) |a| {
                var ptr = @ptrCast(*f32, @alignCast(4, a.ptr + @intCast(usize, a.step) * @intCast(usize, i)));
                ptr.* = sample;
            }
        }
        secondsOffset += seconds_per_frame * @intToFloat(f32, frame_count);
        panicIfError(outstream_end_write(out_stream));
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

    out_stream.format = .Float32LE;
    out_stream.write_callback = write_callback;

    try checkError(outstream_open(out_stream));
    try checkError(out_stream.layout_error);
    try checkError(outstream_start(out_stream));

    while (true) {
        wait_events(sio);
    }
}
