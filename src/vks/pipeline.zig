const std = @import("std");
const Allocator = std.mem.Allocator;
const cimport = @import("cimport");
const vulkan = cimport.vulkan;
const context = @import("context.zig");
const checkSuccess = @import("utils.zig").checkSuccess;

const file_scope = @This();

usingnamespace vulkan;
usingnamespace context;

pub const RenderPass = struct {
    allocator: *Allocator,
    pass: VkRenderPass,
    frame_buffers: []VkFramebuffer,
};

pub fn createShaderTargetMSAARenderPass(allocator: *Allocator, dev: Context, color_fmt: VkFormat, extent: VkExtent2D, num_samples: VkSampleCountFlagBits, msaa_ref: ImageRef, render_target_ref: ImageRef, swap_refs: []ImageRef) !RenderPass {
    const attach_descs = [_]VkAttachmentDescription{
        //MSAA
        .{
            .format = color_fmt,
            .samples = num_samples,
            .storeOp = VK_ATTACHMENT_STORE_OP_STORE,
            .finalLayout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL,
        },
        //Render target attachment
        .{
            .format = color_fmt,
            .storeOp = VK_ATTACHMENT_STORE_OP_STORE,
            .finalLayout = VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL,
        },
        //Swapchain color attachment
        .{
            .format = color_fmt,
            .storeOp = VK_ATTACHMENT_STORE_OP_STORE,
            .finalLayout = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR,
        },
    };

    const subpass_descs = [_]VkSubpassDescription{
        .{
            .pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS,
            .colorAttachmentCount = 1,
            .pColorAttachments = &VkAttachmentReference{
                .attachment = 0,
                .layout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL,
            },
            .pResolveAttachments = &VkAttachmentReference{
                .attachment = 1,
                .layout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL,
            },
        },
        .{
            .pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS,
            .inputAttachmentCount = 1,
            .pInputAttachments = &[_]VkAttachmentReference{
                .{
                    .attachment = 1,
                    .layout = VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL,
                },
            },
            .colorAttachmentCount = 1,
            .pColorAttachments = &[_]VkAttachmentReference{
                .{
                    .attachment = 2,
                    .layout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL,
                },
            },
        },
    };
    const subpass_deps = [_]VkSubpassDependency{
        .{
            .srcSubpass = VK_SUBPASS_EXTERNAL,
            .dstSubpass = 0,
            .srcStageMask = VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT,
            .dstStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
            .srcAccessMask = VK_ACCESS_MEMORY_READ_BIT,
            .dstAccessMask = VK_ACCESS_COLOR_ATTACHMENT_READ_BIT | VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
            .dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT,
        },
        .{
            .srcSubpass = 0,
            .dstSubpass = 1,
            .srcStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
            .dstStageMask = VK_PIPELINE_STAGE_FRAGMENT_SHADER_BIT,
            .srcAccessMask = VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
            .dstAccessMask = VK_ACCESS_INPUT_ATTACHMENT_READ_BIT,
            .dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT,
        },
        .{
            .srcSubpass = 0,
            .dstSubpass = VK_SUBPASS_EXTERNAL,
            .srcStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
            .dstStageMask = VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT,
            .srcAccessMask = VK_ACCESS_COLOR_ATTACHMENT_READ_BIT | VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
            .dstAccessMask = VK_ACCESS_MEMORY_READ_BIT,
            .dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT,
        },
    };
    const rp_info = VkRenderPassCreateInfo{
        .attachmentCount = attach_descs.len,
        .pAttachments = &attach_descs,
        .subpassCount = subpass_descs.len,
        .pSubpasses = &subpass_descs,
        .dependencyCount = subpass_deps.len,
        .pDependencies = &subpass_deps,
    };

    var rndr_pass: VkRenderPass = undefined;
    try checkSuccess(vkCreateRenderPass(dev.logical, &rp_info, null, &rndr_pass));

    const frame_buffers = try allocator.alloc(VkFramebuffer, swap_refs.len);
    for (frame_buffers) |*fb, i| {
        fb.* = try createFramebuffer(dev, rndr_pass, extent, &[_]VkImageView{ msaa_ref.view, render_target_ref.view, swap_refs[i].view });
    }

    return RenderPass{
        .allocator = allocator,
        .pass = rndr_pass,
        .frame_buffers = frame_buffers,
    };
}

pub fn createShaderTargetRenderPass(allocator: *Allocator, dev: Context, color_fmt: VkFormat, extent: VkExtent2D, render_target_ref: ImageRef, swap_refs: []ImageRef) !RenderPass {
    const attach_descs = [_]VkAttachmentDescription{
        //Render target attachment
        .{
            .format = color_fmt,
            .loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR,
            .storeOp = VK_ATTACHMENT_STORE_OP_STORE,
            .finalLayout = VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL,
        },
        //Swapchain color attachment
        .{
            .format = color_fmt,
            .loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR,
            .storeOp = VK_ATTACHMENT_STORE_OP_STORE,
            .finalLayout = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR,
        },
    };

    const subpass_descs = [_]VkSubpassDescription{
        .{
            .pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS,
            .colorAttachmentCount = 1,
            .pColorAttachments = &VkAttachmentReference{
                .attachment = 0,
                .layout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL,
            },
        },
        .{
            .pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS,
            .inputAttachmentCount = 1,
            .pInputAttachments = &[_]VkAttachmentReference{
                .{
                    .attachment = 0,
                    .layout = VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL,
                },
            },
            .colorAttachmentCount = 1,
            .pColorAttachments = &[_]VkAttachmentReference{
                .{
                    .attachment = 1,
                    .layout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL,
                },
            },
        },
    };
    const subpass_deps = [_]VkSubpassDependency{
        .{
            .srcSubpass = VK_SUBPASS_EXTERNAL,
            .dstSubpass = 0,
            .srcStageMask = VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT,
            .dstStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
            .srcAccessMask = VK_ACCESS_MEMORY_READ_BIT,
            .dstAccessMask = VK_ACCESS_COLOR_ATTACHMENT_READ_BIT | VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
            .dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT,
        },
        .{
            .srcSubpass = 0,
            .dstSubpass = 1,
            .srcStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
            .dstStageMask = VK_PIPELINE_STAGE_FRAGMENT_SHADER_BIT,
            .srcAccessMask = VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
            .dstAccessMask = VK_ACCESS_INPUT_ATTACHMENT_READ_BIT,
            .dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT,
        },
        .{
            .srcSubpass = 0,
            .dstSubpass = VK_SUBPASS_EXTERNAL,
            .srcStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
            .dstStageMask = VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT,
            .srcAccessMask = VK_ACCESS_COLOR_ATTACHMENT_READ_BIT | VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
            .dstAccessMask = VK_ACCESS_MEMORY_READ_BIT,
            .dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT,
        },
    };
    const rp_info = VkRenderPassCreateInfo{
        .attachmentCount = attach_descs.len,
        .pAttachments = &attach_descs,
        .subpassCount = subpass_descs.len,
        .pSubpasses = &subpass_descs,
        .dependencyCount = subpass_deps.len,
        .pDependencies = &subpass_deps,
    };

    var rndr_pass: VkRenderPass = undefined;
    try checkSuccess(vkCreateRenderPass(dev.logical, &rp_info, null, &rndr_pass));

    const frame_buffers = try allocator.alloc(VkFramebuffer, swap_refs.len);
    for (frame_buffers) |*fb, i| {
        fb.* = try createFramebuffer(dev, rndr_pass, extent, &[_]VkImageView{ render_target_ref.view, swap_refs[i].view });
    }

    return RenderPass{
        .allocator = allocator,
        .pass = rndr_pass,
        .frame_buffers = frame_buffers,
    };
}

pub fn createBasicRenderPass(allocator: *Allocator, dev: Context, color_fmt: VkFormat, extent: VkExtent2D, img_refs: []ImageRef) !RenderPass {
    const color_desc = VkAttachmentDescription{
        .format = color_fmt,
        .loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR,
        .storeOp = VK_ATTACHMENT_STORE_OP_STORE,
        .finalLayout = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR,
    };

    const subpass = VkSubpassDescription{
        .pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS,
        .colorAttachmentCount = 1,
        .pColorAttachments = &VkAttachmentReference{
            .attachment = 0,
            .layout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL,
        },
    };
    const attach_descs = [_]VkAttachmentDescription{color_desc};
    const subpass_descs = [_]VkSubpassDescription{subpass};
    const rp_info = VkRenderPassCreateInfo{
        .attachmentCount = attach_descs.len,
        .pAttachments = &attach_descs,
        .subpassCount = subpass_descs.len,
        .pSubpasses = &subpass_descs,
        .dependencyCount = 0,
        .pDependencies = null,
    };

    var rndr_pass: VkRenderPass = undefined;
    try checkSuccess(vkCreateRenderPass(dev.logical, &rp_info, null, &rndr_pass));

    const frame_buffers = try allocator.alloc(VkFramebuffer, img_refs.len);
    for (frame_buffers) |*fb, i| {
        fb.* = try createFramebuffer(dev, rndr_pass, extent, &[_]VkImageView{img_refs[i].view});
    }

    return RenderPass{
        .allocator = allocator,
        .pass = rndr_pass,
        .frame_buffers = frame_buffers,
    };
}

pub fn createBasicBasicPassWithDepth(allocator: *Allocator, dev: Context, extent: VkExtent2D, color_fmt: VkFormat, depth_image_ref: ImageRef, img_views: []VkImageView) !RenderPass {
    const color_desc = VkAttachmentDescription{
        .format = color_fmt,
        .samples = VK_SAMPLE_COUNT_1_BIT,
        .loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR,
        .storeOp = VK_ATTACHMENT_STORE_OP_STORE,
        .stencilLoadOp = VK_ATTACHMENT_LOAD_OP_DONT_CARE,
        .stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE,
        .initialLayout = VK_IMAGE_LAYOUT_UNDEFINED,
        .finalLayout = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR,
    };

    const color_ref = VkAttachmentReference{
        .attachment = 0,
        .layout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL,
    };

    const depth_desc = VkAttachmentDescription{
        .format = dev.depth_format,
        .samples = VK_SAMPLE_COUNT_1_BIT,
        .loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR,
        .storeOp = VK_ATTACHMENT_STORE_OP_DONT_CARE,
        .stencilLoadOp = VK_ATTACHMENT_LOAD_OP_DONT_CARE,
        .stencilStoreOp = VK_ATTACHMENT_STORE_OP_DONT_CARE,
        .initialLayout = VK_IMAGE_LAYOUT_UNDEFINED,
        .finalLayout = VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
    };

    const depth_ref = VkAttachmentReference{
        .attachment = 1,
        .layout = VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL,
    };

    const color_refs = [_]VkAttachmentReference{color_ref};
    const subpass = VkSubpassDescription{
        .pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS,
        .colorAttachmentCount = color_refs.len,
        .pColorAttachments = &color_refs,
        .pDepthStencilAttachment = &depth_ref,
    };

    const subpass_descs = [_]VkSubpassDescription{subpass};
    const subpass_deps = [_]VkSubpassDependency{
        .{
            .srcSubpass = VK_SUBPASS_EXTERNAL,
            .dstSubpass = 0,
            .srcStageMask = VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT,
            .dstStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
            .srcAccessMask = VK_ACCESS_MEMORY_READ_BIT,
            .dstAccessMask = VK_ACCESS_COLOR_ATTACHMENT_READ_BIT |
                VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
            .dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT,
        },
        .{
            .srcSubpass = 0,
            .dstSubpass = VK_SUBPASS_EXTERNAL,
            .srcStageMask = VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT,
            .dstStageMask = VK_PIPELINE_STAGE_BOTTOM_OF_PIPE_BIT,
            .srcAccessMask = VK_ACCESS_COLOR_ATTACHMENT_READ_BIT |
                VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
            .dstAccessMask = VK_ACCESS_MEMORY_READ_BIT,
            .dependencyFlags = VK_DEPENDENCY_BY_REGION_BIT,
        },
    };
    const attach_descs = [_]VkAttachmentDescription{ color_desc, depth_desc };
    const rp_info = VkRenderPassCreateInfo{
        .attachmentCount = attach_descs.len,
        .pAttachments = &attach_descs,
        .subpassCount = subpass_descs.len,
        .pSubpasses = &subpass_descs,
        .dependencyCount = subpass_deps.len,
        .pDependencies = &subpass_deps,
    };

    var rndr_pass: VkRenderPass = undefined;
    try checkSuccess(vkCreateRenderPass(dev.logical, &rp_info, null, &rndr_pass));

    const frame_buffers = try allocator.alloc(VkFramebuffer, img_views.len);
    for (frame_buffers) |*fb, i| {
        fb.* = try createFramebuffer(dev, rndr_pass, extent, &[_]VkImageView{ img_views[i], depth_image_ref.view });
    }

    return RenderPass{
        .allocator = allocator,
        .pass = rndr_pass,
        .frame_buffers = frame_buffers,
    };
}

pub fn createMSAAPass(allocator: *Allocator, dev: Context, color_format: VkFormat, extent: VkExtent2D, num_samples: VkSampleCountFlagBits, color_img_views: []VkImageView, msaa_image_refs: []ImageRef) !RenderPass {
    const color_descs = [_]VkAttachmentDescription{
        //MSAA
        .{
            .format = color_format,
            .samples = num_samples,
            .loadOp = VK_ATTACHMENT_LOAD_OP_CLEAR,
            .storeOp = VK_ATTACHMENT_STORE_OP_STORE,
            .finalLayout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL,
        },
        //COLOR OUTPUT
        .{
            .format = color_format,
            .storeOp = VK_ATTACHMENT_STORE_OP_STORE,
            .finalLayout = VK_IMAGE_LAYOUT_PRESENT_SRC_KHR,
        },
    };

    const subpass = VkSubpassDescription{
        .pipelineBindPoint = VK_PIPELINE_BIND_POINT_GRAPHICS,
        .colorAttachmentCount = 1,
        .pColorAttachments = &VkAttachmentReference{
            .attachment = 0,
            .layout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL,
        },
        .pResolveAttachments = &VkAttachmentReference{
            .attachment = 1,
            .layout = VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL,
        },
    };

    const subpass_descs = [_]VkSubpassDescription{subpass};
    const rp_info = VkRenderPassCreateInfo{
        .attachmentCount = color_descs.len,
        .pAttachments = &color_descs,
        .subpassCount = subpass_descs.len,
        .pSubpasses = &subpass_descs,
        .dependencyCount = 0,
        .pDependencies = null,
    };

    var rndr_pass: VkRenderPass = undefined;
    try checkSuccess(vkCreateRenderPass(dev.logical, &rp_info, null, &rndr_pass));

    const frame_buffers = try allocator.alloc(VkFramebuffer, color_img_views.len);
    for (frame_buffers) |*fb, i| {
        fb.* = try createFramebuffer(dev, rndr_pass, extent, &[_]VkImageView{ msaa_image_refs[i].view, color_img_views[i] });
    }

    return RenderPass{
        .allocator = allocator,
        .pass = rndr_pass,
        .frame_buffers = frame_buffers,
    };
}

fn createFramebuffer(dev: Context, render_pass: VkRenderPass, extent: VkExtent2D, img_views: []VkImageView) !VkFramebuffer {
    const fb_info = VkFramebufferCreateInfo{
        .renderPass = render_pass,
        .attachmentCount = @intCast(u32, img_views.len),
        .pAttachments = img_views.ptr,
        .width = extent.width,
        .height = extent.height,
        .layers = 1,
    };
    var frame_buffer: VkFramebuffer = undefined;
    try checkSuccess(vkCreateFramebuffer(dev.logical, &fb_info, null, &frame_buffer));
    return frame_buffer;
}

pub const PipelineInfo = struct {
    shader_stages: []const VkPipelineShaderStageCreateInfo,
    vertex_input: *const VkPipelineVertexInputStateCreateInfo,
    viewport: *const VkPipelineViewportStateCreateInfo,
    assembly: *const VkPipelineInputAssemblyStateCreateInfo = &VkPipelineInputAssemblyStateCreateInfo{
        .topology = VK_PRIMITIVE_TOPOLOGY_TRIANGLE_LIST,
    },
    raster: *const VkPipelineRasterizationStateCreateInfo = &VkPipelineRasterizationStateCreateInfo{
        .cullMode = VK_CULL_MODE_NONE,
        .polygonMode = VK_POLYGON_MODE_FILL,
        .frontFace = VK_FRONT_FACE_CLOCKWISE,
    },
    multisample: *const VkPipelineMultisampleStateCreateInfo = &VkPipelineMultisampleStateCreateInfo{},
    blend: *const VkPipelineColorBlendStateCreateInfo = &VkPipelineColorBlendStateCreateInfo{
        .attachmentCount = 1,
        .pAttachments = &VkPipelineColorBlendAttachmentState{},
        .blendConstants = [_]f32{ 1.0, 1.0, 1.0, 1.0 },
    },
    depth_stencil: *const VkPipelineDepthStencilStateCreateInfo = &VkPipelineDepthStencilStateCreateInfo{},
    layout: VkPipelineLayout,
    render_pass: VkRenderPass,
    subpass_idx: u32 = 0,
};

pub const ShaderVertexInfo = struct {
    stages: []VkPipelineShaderStageCreateInfo,
    vertex: VkPipelineVertexInputStateCreateInfo,
};

pub fn createShaderVertexInfo(allocator: *Allocator, dev: Context, vs_path: []const u8, fs_path: []const u8, vertex_info: VkPipelineVertexInputStateCreateInfo) !ShaderVertexInfo {
    const cwd = std.fs.cwd();
    const vs_code = @alignCast(4, try cwd.readFileAlloc(allocator, vs_path, 1024 * 1024));
    const fs_code = @alignCast(4, try cwd.readFileAlloc(allocator, fs_path, 1024 * 1024));
    defer allocator.free(vs_code);
    defer allocator.free(fs_code);
    const vs_mod = try createShaderModule(dev.logical, vs_code);
    const fs_mod = try createShaderModule(dev.logical, fs_code);
    var stages_info = try allocator.alloc(VkPipelineShaderStageCreateInfo, 2);
    stages_info[0] = .{ .module = vs_mod, .stage = VK_SHADER_STAGE_VERTEX_BIT };
    stages_info[1] = .{ .module = fs_mod, .stage = VK_SHADER_STAGE_FRAGMENT_BIT };
    return ShaderVertexInfo{
        .stages = stages_info[0..],
        .vertex = vertex_info,
    };
}

pub fn createPipeline(dev: Context, shader_info: ShaderVertexInfo, vp_info: VkPipelineViewportStateCreateInfo, layout: VkPipelineLayout, rendr_pass: VkRenderPass, subpass_idx: ?u32) !VkPipeline {
    return createPipelineBase(dev, PipelineInfo{
        .shader_stages = shader_info.stages,
        .vertex_input = &shader_info.vertex,
        .viewport = &vp_info,
        .layout = layout,
        .render_pass = rendr_pass,
        .subpass_idx = if (subpass_idx) |s| s else 0,
    });
}

pub fn createPipelineWithBlendFactor(dev: Context, shader_info: ShaderVertexInfo, vp_info: VkPipelineViewportStateCreateInfo, layout: VkPipelineLayout, rendr_pass: VkRenderPass, src: VkBlendFactor, dst: VkBlendFactor) !VkPipeline {
    return createPipelineBase(dev, PipelineInfo{
        .shader_stages = shader_info.stages,
        .vertex_input = &shader_info.vertex,
        .viewport = &vp_info,
        .blend = &VkPipelineColorBlendStateCreateInfo{
            .attachmentCount = 1,
            .pAttachments = &VkPipelineColorBlendAttachmentState{
                .blendEnable = VK_TRUE,
                .srcColorBlendFactor = src,
                .dstColorBlendFactor = dst,
            },
            .blendConstants = [_]f32{ 1.0, 1.0, 1.0, 1.0 },
        },
        .layout = layout,
        .render_pass = rendr_pass,
    });
}

pub fn createPipelineMultiSampledWithBlendFactor(dev: Context, shader_info: ShaderVertexInfo, vp_info: VkPipelineViewportStateCreateInfo, layout: VkPipelineLayout, rendr_pass: VkRenderPass, samples: VkSampleCountFlagBits, src: VkBlendFactor, dst: VkBlendFactor) !VkPipeline {
    return createPipelineBase(dev, PipelineInfo{
        .shader_stages = shader_info.stages,
        .vertex_input = &shader_info.vertex,
        .viewport = &vp_info,
        .multisample = &VkPipelineMultisampleStateCreateInfo{
            .rasterizationSamples = samples,
        },
        .blend = &VkPipelineColorBlendStateCreateInfo{
            .attachmentCount = 1,
            .pAttachments = &VkPipelineColorBlendAttachmentState{
                .blendEnable = VK_TRUE,
                .srcColorBlendFactor = src,
                .dstColorBlendFactor = dst,
            },
            .blendConstants = [_]f32{ 1.0, 1.0, 1.0, 1.0 },
        },
        .layout = layout,
        .render_pass = rendr_pass,
    });
}

fn createPipelineBase(dev: Context, info: PipelineInfo) !VkPipeline {
    const pipeline_info = [_]VkGraphicsPipelineCreateInfo{VkGraphicsPipelineCreateInfo{
        .stageCount = @intCast(u32, info.shader_stages.len),
        .pStages = info.shader_stages.ptr,
        .pVertexInputState = info.vertex_input,
        .pInputAssemblyState = info.assembly,
        .pViewportState = info.viewport,
        .pRasterizationState = info.raster,
        .pMultisampleState = info.multisample,
        .pColorBlendState = info.blend,
        .pDepthStencilState = info.depth_stencil,
        .pTessellationState = null,
        .pDynamicState = null,
        .layout = info.layout,
        .renderPass = info.render_pass,
        .subpass = info.subpass_idx,
    }};

    var pipeline: VkPipeline = undefined;
    try checkSuccess(vkCreateGraphicsPipelines(dev.logical, null, 1, &pipeline_info, null, &pipeline));

    return pipeline;
}

pub fn createPipelineLayout(dev: Context, set_layouts: []VkDescriptorSetLayout, range: ?VkPushConstantRange) !VkPipelineLayout {
    const num_ranges: u32 = if (range) |_| 1 else 0;
    const pipe_create_info = VkPipelineLayoutCreateInfo{
        .setLayoutCount = @intCast(u32, set_layouts.len),
        .pSetLayouts = set_layouts.ptr,
        .pushConstantRangeCount = num_ranges,
        .pPushConstantRanges = if (num_ranges > 0) &range.? else null,
    };

    var pipe_layout: VkPipelineLayout = undefined;
    try checkSuccess(vkCreatePipelineLayout(dev.logical, &pipe_create_info, null, &pipe_layout));
    return pipe_layout;
}
