const vks = @import("vks.zig");
usingnamespace @import("math.zig");

usingnamespace vks;

pub const ShaderVars = extern struct {
    do_chaos: u32 = 0,
    do_confuse: u32 = 0,
    do_shake: u32 = 0,
    delta_time: f32 = 0.0,
};

pub const FragUniform = struct {
    offsets: [9]Vec2fA16,
    edge_kernel: [9]Vec1iA16,
    blur_kernel: [9]Vec1fA16,
};

const Descriptor = struct {
    set: VkDescriptorSet,
    layout: VkDescriptorSetLayout,
};

const offset: f32 = 1.0 / 300.0;
const divisor = 16.0;
pub const uniform = FragUniform{
    .offsets = .{
        .{ .value = .{ -offset, offset } },
        .{ .value = .{ 0.0, offset } },
        .{ .value = .{ offset, offset } },
        .{ .value = .{ -offset, 0.0 } },
        .{ .value = .{ 0.0, 0.0 } },
        .{ .value = .{ offset, 0.0 } },
        .{ .value = .{ -offset, -offset } },
        .{ .value = .{ 0.0, -offset } },
        .{ .value = .{ offset, -offset } },
    },
    .edge_kernel = .{
        .{ .value = -1 },
        .{ .value = -1 },
        .{ .value = -1 },
        .{ .value = -1 },
        .{ .value = 8 },
        .{ .value = -1 },
        .{ .value = -1 },
        .{ .value = -1 },
        .{ .value = -1 },
    },
    .blur_kernel = .{
        .{ .value = 1.0 / divisor },
        .{ .value = 2.0 / divisor },
        .{ .value = 1.0 / divisor },
        .{ .value = 2.0 / divisor },
        .{ .value = 4.0 / divisor },
        .{ .value = 2.0 / divisor },
        .{ .value = 1.0 / divisor },
        .{ .value = 2.0 / divisor },
        .{ .value = 1.0 / divisor },
    },
};

pub fn createDescriptor(dev: Context, descr_pool: VkDescriptorPool, buffer: Buffer, img_ref: ImageRef) !Descriptor {
    const bindings = [_]VkDescriptorSetLayoutBinding{
        .{
            .binding = 0,
            .descriptorType = VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER,
            .descriptorCount = 1,
            .pImmutableSamplers = null,
            .stageFlags = VK_SHADER_STAGE_FRAGMENT_BIT,
        },
        .{
            .binding = 1,
            .descriptorType = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
            .descriptorCount = 1,
            .stageFlags = VK_SHADER_STAGE_FRAGMENT_BIT,
        },
    };
    const layout_create_info = VkDescriptorSetLayoutCreateInfo{
        .bindingCount = bindings.len,
        .pBindings = &bindings,
    };
    var set_layout: VkDescriptorSetLayout = undefined;
    try vks.checkSuccess(vkCreateDescriptorSetLayout(dev.logical, &layout_create_info, null, &set_layout));

    const alloc_info = VkDescriptorSetAllocateInfo{
        .descriptorPool = descr_pool,
        .descriptorSetCount = 1,
        .pSetLayouts = &set_layout,
    };

    var descr_set: VkDescriptorSet = undefined;
    try vks.checkSuccess(vkAllocateDescriptorSets(dev.logical, &alloc_info, &descr_set));

    const write_sets = &[_]VkWriteDescriptorSet{
        .{
            .dstSet = descr_set,
            .dstBinding = 0,
            .dstArrayElement = 0,
            .descriptorType = VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER,
            .descriptorCount = 1,
            .pImageInfo = &VkDescriptorImageInfo{
                .imageLayout = VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL,
                .imageView = img_ref.view,
                .sampler = dev.sampler,
            },
        },
        .{
            .dstSet = descr_set,
            .dstBinding = 1,
            .dstArrayElement = 0,
            .descriptorType = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
            .descriptorCount = 1,
            .pBufferInfo = &VkDescriptorBufferInfo{
                .buffer = buffer.handle,
                .offset = 0,
                .range = buffer.size,
            },
        },
    };
    vkUpdateDescriptorSets(dev.logical, write_sets.len, write_sets, 0, null);
    return Descriptor{
        .set = descr_set,
        .layout = set_layout,
    };
}
