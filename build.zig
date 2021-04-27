const std = @import("std");
const pdbg = std.debug.warn;
const path = std.fs.path;
const Builder = @import("std").build.Builder;
const allocator = std.testing.allocator;

pub fn build(b: *Builder) !void {
    const mode = b.standardReleaseOptions();
    var exe = b.addExecutable("breakout", "src/main.zig");
    var target = &exe.target;
    exe.setBuildMode(mode);
    exe.linkSystemLibrary("c");
    exe.addPackagePath("cimport", "src/cimport.zig");
    exe.addCSourceFile("deps/KTX/lib/texture.c", &[_][]const u8{ "-std=c99", "-ggdb3", "-Ideps/KTX/include" });
    exe.addCSourceFile("deps/KTX/lib/hashlist.c", &[_][]const u8{ "-std=c99", "-Ideps/KTX/include" });
    exe.addCSourceFile("deps/KTX/lib/filestream.c", &[_][]const u8{ "-std=c99", "-Ideps/KTX/include" });
    exe.addCSourceFile("deps/KTX/lib/memstream.c", &[_][]const u8{ "-std=c99", "-Ideps/KTX/include" });
    exe.addCSourceFile("deps/KTX/lib/swap.c", &[_][]const u8{ "-std=c99", "-Ideps/KTX/include" });
    exe.addCSourceFile("deps/KTX/lib/checkheader.c", &[_][]const u8{ "-std=c99", "-Ideps/KTX/include" });
    exe.addCSourceFile("deps/stb_image-2.22/stb_image_impl.c", &[_][]const u8{"-std=c99"});
    exe.linkSystemLibrary("mpg123");
    exe.linkSystemLibrary("soundio");
    exe.setLibCFile("libc-file");
    exe.addLibPath("libs");
    exe.addIncludeDir("deps/stb_image-2.22");
    b.default_step.dependOn(&exe.step);
    b.installArtifact(exe);

    const run_step = b.step("run", "Run the app");
    const run_cmd = exe.run();
    run_step.dependOn(&run_cmd.step);

    if (target.isWindows()) {
        const process = std.process;
        const vcPkgLibPath = try process.getEnvVarOwned(allocator, "VCPKG_LIBPATH_STATIC");
        defer b.allocator.free(vcPkgLibPath);
        const vulkan_sdk_path = try process.getEnvVarOwned(b.allocator, "VULKAN_SDK");
        defer b.allocator.free(vulkan_sdk_path);
        const full_path = try path.join(b.allocator, &[_][]const u8{ vulkan_sdk_path, "Bin", "glslc.exe" });
        const vulkan_lib_path = try path.join(b.allocator, &[_][]const u8{ vulkan_sdk_path, "Lib" });
        defer b.allocator.free(vulkan_lib_path);
        exe.linkSystemLibrary("gdi32");
        exe.linkSystemLibrary("user32");
        exe.linkSystemLibrary("shell32");
        //if (target.isMinGW()) {
        //    exe.addLibPath("C:\\msys64\\mingw64\\lib");
        //    exe.linkSystemLibrary("vulkan.dll");
        //} else {
        //    exe.addLibPath(vulkan_lib_path);
        //    exe.addLibPath(vcPkgLibPath);
        //    exe.linkSystemLibrary("vulkan-1");
        //}
        exe.linkSystemLibrary("deps/glfw/x64-x11/lib/libglfw3.a");
        exe.linkSystemLibrary("VkLayer_utils");
        const glslc_path = try path.join(b.allocator, &[_][]const u8{ vulkan_sdk_path, "Bin", "glslc.exe" });
        defer b.allocator.free(glslc_path);
        try addAndCopyShader(b, exe, glslc_path, "norotate.vert", "norotate.vert.spv");
        try addAndCopyShader(b, exe, glslc_path, "ortho.frag", "ortho.frag.spv");
    } else {
        exe.addIncludeDir("deps/KTX/other_include");
        exe.linkSystemLibrary("glfw");
        exe.linkSystemLibrary("vulkan");
        exe.linkSystemLibrary("deps/vma/libvma.so");
        try addAndCopyShader(b, exe, "glslc", "norotate.vert", "norotate.vert.spv");
        try addAndCopyShader(b, exe, "glslc", "instance.vert", "instance.vert.spv");
        try addAndCopyShader(b, exe, "glslc", "color_uniform.frag", "color_uniform.frag.spv");
        try addAndCopyShader(b, exe, "glslc", "postproc.vert", "postproc.vert.spv");
        try addAndCopyShader(b, exe, "glslc", "postproc.frag", "postproc.frag.spv");
    }
}

fn addAndCopyShader(b: *Builder, exe: anytype, glslc_path: []const u8, in_file: []const u8, out_file: []const u8) !void {
    const dirname = "shaders";
    const full_in = try path.join(b.allocator, &[_][]const u8{ dirname, in_file });
    const full_out = try path.join(b.allocator, &[_][]const u8{ dirname, out_file });
    const run_cmd = b.addSystemCommand(&[_][]const u8{
        glslc_path,
        "-I shaders",
        "-o",
        full_out,
        full_in,
    });
    const out_path = try path.join(b.allocator, &[_][]const u8{ "./", dirname, out_file });
    defer b.allocator.free(out_path);
    exe.step.dependOn(&run_cmd.step);
    b.getInstallStep().dependOn(&run_cmd.step);
    b.installBinFile(full_out, out_path);
}
