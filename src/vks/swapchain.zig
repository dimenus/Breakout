const std = @import("std");
const mem = std.mem;
const Allocator = std.mem.Allocator;

const cimport = @import("cimport");
const vulkan = cimport.vulkan;
const glfw = cimport.glfw;
const utils = @import("utils.zig");
const context = @import("context.zig");
const pipeline = @import("pipeline.zig");
const file_scope = @This();

usingnamespace vulkan;
usingnamespace context;

pub const SwapChainBuffer = struct {
    image: VkImage,
    view: VkImageView,
};

pub const SwapChain = struct {
    allocator: *Allocator,
    device: VkDevice,
    surface: VkSurfaceKHR,
    extent: VkExtent2D,
    color_format: VkFormat,
    color_space: VkColorSpaceKHR,
    handle: VkSwapchainKHR,
    num_swap_images: usize,
    num_max_frames: usize,
    render_ahead_idx: usize,
    swap_image_idx: u32,
    image_refs: []ImageRef,
    present_semaphores: []VkSemaphore,
    render_semaphores: []VkSemaphore,
    wait_fences: []VkFence,
    cmd_pool: VkCommandPool,
    cmd_buffers: []VkCommandBuffer,
    present_queue: VkQueue,
    use_vsync: bool,
    was_image_acquired: bool,

    const Self = @This();

    pub fn getFrameIdx(self: *Self) usize {
        return self.render_ahead_idx;
    }

    pub fn getSwapImageIdx(self: *Self) usize {
        return self.swap_image_idx;
    }

    pub fn waitOnNextCmdBuffer(self: *Self) !VkCommandBuffer {
        if (self.was_image_acquired) return error.UnsupportedCall;
        try utils.checkSuccess(vkAcquireNextImageKHR(self.device, self.handle, std.math.maxInt(u64), self.present_semaphores[self.render_ahead_idx], null, &self.swap_image_idx));
        try utils.checkSuccess(vkWaitForFences(self.device, 1, &self.wait_fences[self.render_ahead_idx], VK_TRUE, std.math.maxInt(u64)));
        try utils.checkSuccess(vkResetFences(self.device, 1, &self.wait_fences[self.render_ahead_idx]));
        const cbuf = self.cmd_buffers[self.render_ahead_idx];
        self.was_image_acquired = true;
        return cbuf;
    }

    pub fn submit(self: *Self, cbuf: VkCommandBuffer) !void {
        if (cbuf != self.cmd_buffers[self.render_ahead_idx]) return error.InvalidSubmit;
        const stage_flags = [_]VkPipelineStageFlags{VK_PIPELINE_STAGE_COLOR_ATTACHMENT_OUTPUT_BIT};
        const submit_info = VkSubmitInfo{
            .waitSemaphoreCount = 1,
            .pWaitSemaphores = &self.present_semaphores[self.render_ahead_idx],
            .pWaitDstStageMask = &stage_flags,
            .commandBufferCount = 1,
            .pCommandBuffers = &cbuf,
            .signalSemaphoreCount = if (self.use_vsync) 1 else 0,
            .pSignalSemaphores = if (self.use_vsync) &self.render_semaphores[self.swap_image_idx] else null,
        };
        try utils.checkSuccess(vkQueueSubmit(self.present_queue, 1, &submit_info, self.wait_fences[self.render_ahead_idx]));
        self.render_ahead_idx = (self.render_ahead_idx + 1) % self.num_max_frames;
        self.was_image_acquired = false;
    }

    pub fn swap(self: *Self) void {
        const present_info = VkPresentInfoKHR{
            .swapchainCount = 1,
            .pSwapchains = &self.handle,
            .pImageIndices = &@intCast(u32, self.swap_image_idx),
            .waitSemaphoreCount = if (self.use_vsync) 1 else 0,
            .pWaitSemaphores = if (self.use_vsync) &self.render_semaphores[self.swap_image_idx] else null,
        };
        utils.checkSuccess(vulkan.vkQueuePresentKHR(self.present_queue, &present_info)) catch unreachable;
    }
};

pub fn createSwapChain(allocator: *Allocator, window: *glfw.GLFWwindow, inst: VkInstance, dev: Context, max_frames: usize, use_vsync: bool) !SwapChain {
    var surface: VkSurfaceKHR = null;
    if (glfw.glfwCreateWindowSurface(inst, window, null, &surface) != VK_SUCCESS) {
        return error.FailedToCreateWindowSurface;
    }

    var queue_count: u32 = 0;
    vkGetPhysicalDeviceQueueFamilyProperties(dev.physical, &queue_count, null);
    if (queue_count == 0) return error.NoUsableDeviceQueues;

    const queue_families = try allocator.alloc(VkQueueFamilyProperties, queue_count);
    defer allocator.free(queue_families);
    vkGetPhysicalDeviceQueueFamilyProperties(dev.physical, &queue_count, queue_families.ptr);

    var supp_present_list = try std.ArrayList(VkBool32).initCapacity(allocator, queue_count);
    defer supp_present_list.deinit();
    {
        var i: u32 = 0;
        while (i < queue_count) : (i += 1) {
            var can_present: VkBool32 = 0;
            try utils.checkSuccess(vkGetPhysicalDeviceSurfaceSupportKHR(dev.physical, i, surface, &can_present));
            try supp_present_list.append(can_present);
        }
    }

    const supp_present_slice = supp_present_list.items;
    var queue_idx: ?u32 = null;
    for (queue_families) |f, i| {
        if (f.queueFlags & VK_QUEUE_GRAPHICS_BIT == 0) {
            continue;
        }
        if (supp_present_slice[i] == VK_TRUE) {
            queue_idx = @intCast(u32, i);
            break;
        }
    }

    if (queue_idx == null) {
        return error.PresentQueueNotFound;
    }

    var color_fmt: VkFormat = undefined;
    var color_space: VkColorSpaceKHR = undefined;

    var fmt_count: u32 = undefined;
    try utils.checkSuccess(vkGetPhysicalDeviceSurfaceFormatsKHR(dev.physical, surface, &fmt_count, null));
    if (fmt_count == 0) return error.NoUsableSurfaceFormatsFound;

    var surf_fmt_list = try std.ArrayList(VkSurfaceFormatKHR).initCapacity(allocator, fmt_count);
    try utils.checkSuccess(vkGetPhysicalDeviceSurfaceFormatsKHR(dev.physical, surface, &fmt_count, surf_fmt_list.items.ptr));
    try surf_fmt_list.resize(fmt_count);
    defer surf_fmt_list.deinit();

    var present_count: u32 = undefined;
    try utils.checkSuccess(vkGetPhysicalDeviceSurfacePresentModesKHR(dev.physical, surface, &present_count, null));
    if (present_count == 0) return error.NoUsableSurfacePresentModes;

    var pres_mode_list = try std.ArrayList(VkPresentModeKHR).initCapacity(allocator, present_count);
    try utils.checkSuccess(vkGetPhysicalDeviceSurfacePresentModesKHR(dev.physical, surface, &present_count, pres_mode_list.items.ptr));
    try pres_mode_list.resize(present_count);
    defer pres_mode_list.deinit();

    const surf_fmts = surf_fmt_list.items;

    if (fmt_count == 1) {
        color_fmt = VK_FORMAT_B8G8R8A8_UNORM;
        color_space = surf_fmts[0].colorSpace;
    } else {
        var found_unorm = false;
        for (surf_fmts) |s| {
            if (s.format == VK_FORMAT_B8G8R8A8_UNORM) {
                color_fmt = s.format;
                color_space = s.colorSpace;
                found_unorm = true;
            }
        }
        if (!found_unorm) {
            color_fmt = surf_fmts[0].format;
            color_space = surf_fmts[0].colorSpace;
        }
    }

    var surf_caps: VkSurfaceCapabilitiesKHR = undefined;
    try utils.checkSuccess(vkGetPhysicalDeviceSurfaceCapabilitiesKHR(dev.physical, surface, &surf_caps));

    var swap_extent = chooseSwapExtent(window, surf_caps);

    var num_swap_images = surf_caps.minImageCount;
    if (num_swap_images < max_frames) num_swap_images = @intCast(u32, max_frames);
    //std.debug.warn("num swap images: {}\n", .{num_swap_images});
    var pre_trans = if (surf_caps.supportedTransforms & VK_SURFACE_TRANSFORM_IDENTITY_BIT_KHR != 0)
        VK_SURFACE_TRANSFORM_IDENTITY_BIT_KHR
    else
        surf_caps.currentTransform;

    const avail_comp_alpha = &[_]VkCompositeAlphaFlagBitsKHR{
        VK_COMPOSITE_ALPHA_OPAQUE_BIT_KHR,
        VK_COMPOSITE_ALPHA_PRE_MULTIPLIED_BIT_KHR,
        VK_COMPOSITE_ALPHA_POST_MULTIPLIED_BIT_KHR,
        VK_COMPOSITE_ALPHA_INHERIT_BIT_KHR,
    };

    const comp_alpha = for (avail_comp_alpha) |a| {
        if (surf_caps.supportedCompositeAlpha & a != 0) break a;
    } else return error.NoCompositeAlphaSupported;

    const present_mode = chooseSwapPresentMode(pres_mode_list.items, use_vsync);

    var create_info = VkSwapchainCreateInfoKHR{
        .surface = surface,
        .minImageCount = num_swap_images,
        .imageFormat = color_fmt,
        .imageColorSpace = color_space,
        .imageExtent = swap_extent,
        .imageArrayLayers = 1,
        .imageUsage = VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT,
        .imageSharingMode = VK_SHARING_MODE_EXCLUSIVE,
        .queueFamilyIndexCount = @as(u32, 0),
        .pQueueFamilyIndices = null,
        .preTransform = pre_trans,
        .compositeAlpha = comp_alpha,
        .presentMode = present_mode,
        .clipped = VK_TRUE,
    };

    const img_usage_trans_src = VK_IMAGE_USAGE_TRANSFER_SRC_BIT;
    const img_usage_trans_dst = VK_IMAGE_USAGE_TRANSFER_DST_BIT;
    if (surf_caps.supportedUsageFlags & img_usage_trans_src != 0) {
        create_info.imageUsage |= img_usage_trans_src;
    }
    if (surf_caps.supportedUsageFlags & img_usage_trans_dst != 0) {
        create_info.imageUsage |= img_usage_trans_dst;
    }

    var swap_chain: VkSwapchainKHR = undefined;
    try utils.checkSuccess(vkCreateSwapchainKHR(dev.logical, &create_info, null, &swap_chain));
    try utils.checkSuccess(vkGetSwapchainImagesKHR(dev.logical, swap_chain, &num_swap_images, null));

    var imgs_slice = try allocator.alloc(VkImage, num_swap_images);
    try utils.checkSuccess(vkGetSwapchainImagesKHR(dev.logical, swap_chain, &num_swap_images, imgs_slice.ptr));
    defer allocator.free(imgs_slice);

    var refs_slice = try allocator.alloc(ImageRef, num_swap_images);
    for (refs_slice) |*ref, i| {
        ref.* = ImageRef{
            .image = .{
                .handle = imgs_slice[i],
                .memory = null,
                .extent = VkExtent3D{
                    .width = swap_extent.width,
                    .height = swap_extent.height,
                    .depth = 1,
                },
                .layout = VK_IMAGE_LAYOUT_UNDEFINED,
            },
            .view = try createSwapChainImageView(dev.logical, imgs_slice[i], color_fmt),
        };
    }

    var present_queue: VkQueue = undefined;
    vkGetDeviceQueue(dev.logical, queue_idx.?, 0, &present_queue);
    var pres_semas = try allocator.alloc(VkSemaphore, max_frames);
    for (pres_semas) |*p| {
        p.* = try createSemaphore(dev);
    }
    var rndr_semas = try allocator.alloc(VkSemaphore, num_swap_images);
    for (rndr_semas) |*p| {
        p.* = try createSemaphore(dev);
    }

    var fence_list = try allocator.alloc(VkFence, max_frames);
    errdefer allocator.free(fence_list);
    const fence_info = VkFenceCreateInfo{ .flags = VK_FENCE_CREATE_SIGNALED_BIT };
    for (fence_list) |*f| {
        try utils.checkSuccess(vkCreateFence(dev.logical, &fence_info, null, f));
    }

    const cmd_pool = try createCommandPool(dev, dev.queue_indices.graphics, null);

    const cmd_buffers = try allocator.alloc(VkCommandBuffer, max_frames);
    errdefer allocator.free(cmd_buffers);
    const alloc_info = VkCommandBufferAllocateInfo{
        .commandPool = cmd_pool,
        .level = VK_COMMAND_BUFFER_LEVEL_PRIMARY,
        .commandBufferCount = @intCast(u32, cmd_buffers.len),
    };
    try utils.checkSuccess(vkAllocateCommandBuffers(dev.logical, &alloc_info, cmd_buffers.ptr));

    return SwapChain{
        .allocator = allocator,
        .device = dev.logical,
        .surface = surface,
        .extent = swap_extent,
        .color_format = color_fmt,
        .color_space = color_space,
        .handle = swap_chain,
        .num_swap_images = num_swap_images,
        .num_max_frames = max_frames,
        .swap_image_idx = 0,
        .render_ahead_idx = 0,
        .image_refs = refs_slice,
        .present_semaphores = pres_semas,
        .render_semaphores = rndr_semas,
        .wait_fences = fence_list,
        .cmd_pool = cmd_pool,
        .cmd_buffers = cmd_buffers,
        .present_queue = present_queue,
        .use_vsync = use_vsync,
        .was_image_acquired = false,
    };
}

fn chooseSwapExtent(window: *glfw.GLFWwindow, surf_caps: VkSurfaceCapabilitiesKHR) VkExtent2D {
    if (surf_caps.currentExtent.width != std.math.maxInt(u32)) {
        return surf_caps.currentExtent;
    } else {
        var width: c_int = 0;
        var height: c_int = 0;
        glfw.glfwGetFramebufferSize(window, &width, &height);
        var actual_extent = VkExtent2D{
            .width = @intCast(u32, width),
            .height = @intCast(u32, height),
        };
        actual_extent.width = std.math.max(surf_caps.minImageExtent.width, std.math.min(surf_caps.maxImageExtent.width, actual_extent.width));
        actual_extent.height = std.math.max(surf_caps.minImageExtent.height, std.math.min(surf_caps.maxImageExtent.height, actual_extent.height));
        return actual_extent;
    }
}

fn chooseSwapPresentMode(modes: []VkPresentModeKHR, use_vsync: bool) VkPresentModeKHR {
    var best_mode: VkPresentModeKHR = VK_PRESENT_MODE_FIFO_KHR;
    if (use_vsync) return best_mode;

    for (modes) |m| {
        if (m == VK_PRESENT_MODE_MAILBOX_KHR) {
            return m;
        } else if (m == VK_PRESENT_MODE_IMMEDIATE_KHR) {
            best_mode = m;
        }
    }
    return best_mode;
}

fn createSwapChainImageView(logical: VkDevice, img: VkImage, format: VkFormat) !VkImageView {
    const create_info = VkImageViewCreateInfo{
        .image = img,
        .viewType = VK_IMAGE_VIEW_TYPE_2D,
        .format = format,
        .components = VkComponentMapping{},
        .subresourceRange = VkImageSubresourceRange{
            .aspectMask = VK_IMAGE_ASPECT_COLOR_BIT,
            .baseMipLevel = 0,
            .levelCount = 1,
            .baseArrayLayer = 0,
            .layerCount = 1,
        },
    };
    var image_view: VkImageView = undefined;
    try utils.checkSuccess(vkCreateImageView(logical, &create_info, null, &image_view));
    return image_view;
}
