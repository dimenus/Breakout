const std = @import("std");
const Allocator = std.mem.Allocator;
const quad_vert_stride = @intCast(u32, @sizeOf(f32) * 4);
const inst_colorpos_stride = @intCast(u32, @sizeOf(f32) * 8);
const inst_flags_stride = @intCast(u32, @sizeOf(u32));
const context = @import("vks/context.zig");
const pipeline = @import("vks/pipeline.zig");
const vulkan = @import("cimport/vulkan.zig");

usingnamespace vulkan;

const attr_desc_norotate = [_]VkVertexInputAttributeDescription{
    .{ .binding = 0, .location = 0, .format = VK_FORMAT_R32G32_SFLOAT, .offset = 0 },
    .{ .binding = 0, .location = 1, .format = VK_FORMAT_R32G32_SFLOAT, .offset = @sizeOf(f32) * 2 },
};

const vib_particles = [_]VkVertexInputBindingDescription{
    .{ .binding = 0, .stride = quad_vert_stride, .inputRate = VK_VERTEX_INPUT_RATE_VERTEX },
    //Color + Pos
    .{ .binding = 1, .stride = inst_colorpos_stride, .inputRate = VK_VERTEX_INPUT_RATE_INSTANCE },
};

const vib_quad_norotate = [_]VkVertexInputBindingDescription{
    .{ .binding = 0, .stride = quad_vert_stride, .inputRate = VK_VERTEX_INPUT_RATE_VERTEX },
};

const attr_desc_particles = [_]VkVertexInputAttributeDescription{
    .{ .binding = 0, .location = 0, .format = VK_FORMAT_R32G32_SFLOAT, .offset = 0 },
    .{ .binding = 0, .location = 1, .format = VK_FORMAT_R32G32_SFLOAT, .offset = @sizeOf(f32) * 2 },
    .{ .binding = 1, .location = 2, .format = VK_FORMAT_R32G32B32A32_SFLOAT, .offset = 0 },
    .{ .binding = 1, .location = 3, .format = VK_FORMAT_R32G32_SFLOAT, .offset = @sizeOf(f32) * 4 },
};
pub fn getShaderInfoNoRotate(allocator: *Allocator, dev: context.Context) !pipeline.ShaderVertexInfo {
    return pipeline.createShaderVertexInfo(allocator, dev, "shaders/norotate.vert.spv", "shaders/color_uniform.frag.spv", VkPipelineVertexInputStateCreateInfo{
        .vertexBindingDescriptionCount = vib_quad_norotate.len,
        .pVertexBindingDescriptions = &vib_quad_norotate,
        .vertexAttributeDescriptionCount = @intCast(u32, attr_desc_norotate.len),
        .pVertexAttributeDescriptions = &attr_desc_norotate,
    });
}

pub fn getShaderInfoPostProcess(allocator: *Allocator, dev: context.Context) !pipeline.ShaderVertexInfo {
    return pipeline.createShaderVertexInfo(allocator, dev, "shaders/postproc.vert.spv", "shaders/postproc.frag.spv", VkPipelineVertexInputStateCreateInfo{
        .vertexBindingDescriptionCount = 0,
        .pVertexBindingDescriptions = null,
        .vertexAttributeDescriptionCount = 0,
        .pVertexAttributeDescriptions = null,
    });
}

pub fn getShaderInfoInstance(allocator: *Allocator, dev: context.Context) !pipeline.ShaderVertexInfo {
    return pipeline.createShaderVertexInfo(allocator, dev, "shaders/instance.vert.spv", "shaders/color_uniform.frag.spv", VkPipelineVertexInputStateCreateInfo{
        .vertexBindingDescriptionCount = vib_particles.len,
        .pVertexBindingDescriptions = &vib_particles,
        .vertexAttributeDescriptionCount = @intCast(u32, attr_desc_particles.len),
        .pVertexAttributeDescriptions = &attr_desc_particles,
    });
}

const GeometryBuffers = struct {
    vertex: context.Buffer,
    stride_in_bytes: usize,
    num_vertices: usize,
};

pub fn createQuadGeometryBuffers(dev: context.Context, use_stage: bool) !GeometryBuffers {
    const vertices = &[_][4]f32{
        .{ -0.5, -0.5, 0.0, 0.0 },
        .{ 0.5, -0.5, 1.0, 0.0 },
        .{ 0.5, 0.5, 1.0, 1.0 },
        .{ 0.5, 0.5, 1.0, 1.0 },
        .{ -0.5, 0.5, 0.0, 1.0 },
        .{ -0.5, -0.5, 0.0, 0.0 },
    };
    const stride = 4 * @sizeOf(f32);
    const vert_type = [4]f32;

    if (use_stage) {
        //note(ryan): on integrated contexts, there's probably no win for staging buffers (other than async transfers)
        const stage_buf = try context.createStageBufferWithSlice(dev.mem_alloc, vert_type, vertices);
        defer context.destroyBuffer(dev.mem_alloc, stage_buf);

        const vert_dst_buf = try context.createDestBufferWithLength(dev.mem_alloc, .Vertex, vert_type, vertices.len);
        try context.copyBufferToBuffer(dev, stage_buf, vert_dst_buf, null);
        return GeometryBuffers{
            .vertex = vert_dst_buf,
            .stride_in_bytes = stride,
            .num_vertices = vertices.len,
        };
    } else {
        const vert_dst_buf = try context.createDirectBufferWithSlice(dev.mem_alloc, .Vertex, vert_type, vertices);
        return GeometryBuffers{
            .vertex = vert_dst_buf,
            .stride_in_bytes = stride,
            .num_vertices = vertices.len,
        };
    }
}
