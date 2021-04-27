const std = @import("std");
const cimport = @import("cimport");
const vulkan = cimport.vulkan;
const ktx = cimport.ktx;
const Allocator = std.mem.Allocator;
const context = @import("context.zig");
const utils = @import("utils.zig");

usingnamespace ktx;
usingnamespace vulkan;

pub fn createDirectFromKTXFile(allocator: *Allocator, dev: context.Context, path: []const u8) !context.ImageRef {
    //TODO: pull the format from the KTX file
    const format = VK_FORMAT_BC3_UNORM_BLOCK;
    const cwd = std.fs.cwd();
    const img_bytes = try cwd.readFileAlloc(allocator, path, 16 * 1024 * 1024);
    defer allocator.free(img_bytes);

    var raw_tex: ?*ktxTexture = undefined;
    try checkSuccess(ktxTexture_CreateFromMemory(img_bytes.ptr, img_bytes.len, KTX_TEXTURE_CREATE_LOAD_IMAGE_DATA_BIT, &raw_tex));
    const tex = raw_tex.?;
    defer ktxTexture_Destroy(tex);

    const data = ktxTexture_GetData(tex);
    const size = ktxTexture_GetSize(tex);

    var fmt_props: VkFormatProperties = undefined;
    vkGetPhysicalDeviceFormatProperties(dev.physical, format, &fmt_props);

    return try context.createDirectColorImageRefNoMIPS(dev, tex.baseWidth, tex.baseHeight, format, u8, data[0..size]);
}

pub fn createFromFile(allocator: *Allocator, dev: Context, path: []const u8) !void {
    const tex_bytes = try cwd.readFileAlloc(allocator, path, 16 * 1024 * 1024);
    defer allocator.free(tex_bytes);
    return createFromBytes(dev, tex_bytes);
}

fn checkSuccess(code: ktx.KTX_error_code) !void {
    switch (code) {
        .KTX_SUCCESS => {},
        else => |e| return error.KTXCheckFailed,
    }
}
