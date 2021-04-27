const std = @import("std");
const pdbg = std.debug.warn;
const Allocator = std.mem.Allocator;
const cimport = @import("cimport");
const glfw = cimport.glfw;
const vulkan = @import("cimport").vulkan;
const vma = cimport.vma;
const checkSuccess = @import("utils.zig").checkSuccess;

usingnamespace vma;
usingnamespace vulkan;

pub const Context = struct {
    allocator: *Allocator,
    mem_alloc: VmaAllocator,
    physical: VkPhysicalDevice,
    logical: VkDevice,
    queue_indices: struct {
        graphics: u32,
        compute: ?u32,
        transfer: ?u32,
    },
    depth_format: VkFormat,
    cmd_pool: VkCommandPool,
    timed_cmd_buffer: VkCommandBuffer,
    trans_fence: VkFence,
    gfx_queue: VkQueue,
    sampler: VkSampler,
};

const Instance = struct {
    need_validation: bool,
};

pub const Buffer = struct {
    handle: VkBuffer,
    memory: vma.VmaAllocation,
    usage: vma.VmaMemoryUsage,
    size: usize,
    ptr: ?*c_void = null,
};

const Image = struct {
    handle: VkImage,
    memory: vma.VmaAllocation,
    extent: VkExtent3D,
    layout: VkImageLayout,
};

pub const ImageRef = struct {
    image: Image,
    view: VkImageView,
};

fn cbVulkanpdbg(msgSeverityBits: VkDebugUtilsMessageSeverityFlagBitsEXT, msgTypeBits: VkDebugUtilsMessageTypeFlagsEXT, pCallbackData: *const VkDebugUtilsMessengerCallbackDataEXT, userData: ?*c_void) callconv(.C) VkBool32 {
    const msg: [*:0]const u8 = pCallbackData.pMessage;
    pdbg("[VALIDATION]: {s}\n", .{msg});
    return VK_FALSE;
}

fn defaultDebugMessengerCreateInfo() VkDebugUtilsMessengerCreateInfoEXT {
    return VkDebugUtilsMessengerCreateInfoEXT{
        .messageSeverity = VK_DEBUG_UTILS_MESSAGE_SEVERITY_VERBOSE_BIT_EXT |
            VK_DEBUG_UTILS_MESSAGE_SEVERITY_WARNING_BIT_EXT |
            VK_DEBUG_UTILS_MESSAGE_SEVERITY_ERROR_BIT_EXT,
        .messageType = VK_DEBUG_UTILS_MESSAGE_TYPE_GENERAL_BIT_EXT |
            VK_DEBUG_UTILS_MESSAGE_TYPE_VALIDATION_BIT_EXT |
            VK_DEBUG_UTILS_MESSAGE_TYPE_PERFORMANCE_BIT_EXT,
        .pfnUserCallback = cbVulkanpdbg,
    };
}

fn getRequiredExtensions(allocator: *Allocator, req_validation: bool) ![][*:0]const u8 {
    var num_extens: u32 = 0;
    var glfw_extens = glfw.glfwGetRequiredInstanceExtensions(&num_extens);

    var extens = std.ArrayList([*:0]const u8).init(allocator);
    errdefer extens.deinit();

    try extens.appendSlice(glfw_extens[0..num_extens]);
    if (req_validation) {
        try extens.append(vulkan.VK_EXT_DEBUG_UTILS_EXTENSION_NAME);
    }
    //pdbg("required instance extensions({}):\n", .{num_extens});
    //for (extens.toSlice()) |e| {
    //    pdbg("\t{s}\n", .{e});
    //}
    return extens.toOwnedSlice();
}

fn checkValidationLayerSupport(allocator: *Allocator, req_layers: []const [*:0]const u8) !bool {
    if (req_layers.len == 0) {
        return true;
    }
    var num_layers: u32 = 0;
    try checkSuccess(vkEnumerateInstanceLayerProperties(&num_layers, null));
    const avail_layers = try allocator.alloc(VkLayerProperties, num_layers);
    defer allocator.free(avail_layers);
    try checkSuccess(vkEnumerateInstanceLayerProperties(&num_layers, avail_layers.ptr));
    for (req_layers) |req_name| {
        var found = false;
        for (avail_layers) |props| {
            if (std.cstr.cmp(req_name, @ptrCast([*:0]const u8, &props.layerName)) == 0) {
                found = true;
                break;
            }
        }

        if (!found) {
            pdbg("[ERROR]: Validation layer '{s}' is not supported\n", .{req_name});
            return false;
        }
    }
    return true;
}
pub fn createInstance(allocator: *Allocator, app_name: [*:0]const u8, need_validation: bool) !VkInstance {
    const layers = &[_][*:0]const u8{"VK_LAYER_KHRONOS_validation"};
    if (need_validation and !(try checkValidationLayerSupport(allocator, layers))) {
        return error.ReqValidationLayerNotAvailable;
    }
    const appInfo = VkApplicationInfo{
        .sType = VK_STRUCTURE_TYPE_APPLICATION_INFO,
        .pApplicationName = app_name,
        .applicationVersion = VK_MAKE_VERSION(1, 0, 0),
        .pEngineName = "rsdimenus",
        .engineVersion = VK_MAKE_VERSION(1, 0, 0),
        .apiVersion = VK_API_VERSION_1_0,
        .pNext = null,
    };

    const extens = try getRequiredExtensions(allocator, need_validation);
    defer allocator.free(extens);

    const createInfo = VkInstanceCreateInfo{
        .sType = VK_STRUCTURE_TYPE_INSTANCE_CREATE_INFO,
        .pApplicationInfo = &appInfo,
        .enabledExtensionCount = @intCast(u32, extens.len),
        .ppEnabledExtensionNames = extens.ptr,
        .enabledLayerCount = if (need_validation) @intCast(u32, layers.len) else 0,
        .ppEnabledLayerNames = if (need_validation) layers else null,
        .pNext = if (need_validation) &defaultDebugMessengerCreateInfo() else null,
        .flags = 0,
    };

    var instance: VkInstance = undefined;
    try checkSuccess(vkCreateInstance(&createInfo, null, &instance));
    return instance;
}

fn cstrLen(cstr: [*:0]const u8) usize {
    var index: usize = 0;
    while (cstr[index] != 0) : (index += 1) {}
    return index;
}

fn checkContextExtensionSupport(allocator: *Allocator, phys: VkPhysicalDevice, req_extens: []const [*:0]const u8) !bool {
    var ext_count: u32 = 0;
    try checkSuccess(vkEnumerateDeviceExtensionProperties(phys, null, &ext_count, null));
    const available_extens = try allocator.alloc(VkExtensionProperties, ext_count);
    defer allocator.free(available_extens);

    try checkSuccess(vkEnumerateDeviceExtensionProperties(phys, null, &ext_count, available_extens.ptr));

    var extens_map = std.hash_map.StringHashMap(void).init(allocator);
    defer extens_map.deinit();
    for (req_extens) |exten| {
        _ = try extens_map.put(exten[0..cstrLen(exten)], {});
    }

    for (available_extens) |exten| {
        const ptr = @ptrCast([*:0]const u8, &exten.extensionName[0]);
        const len = cstrLen(ptr);
        _ = extens_map.remove(ptr[0..len]);
    }

    return extens_map.count() == 0;
}

fn getQueueFamilyIndex(props: []VkQueueFamilyProperties, flags: VkQueueFlagBits) !u32 {
    if (flags & VK_QUEUE_COMPUTE_BIT != 0) {
        for (props) |p, i| {
            if ((p.queueFlags & flags != 0) and (p.queueFlags & VK_QUEUE_GRAPHICS_BIT == 0)) {
                return @intCast(u32, i);
            }
        }
    }
    if (flags & VK_QUEUE_TRANSFER_BIT != 0) {
        for (props) |p, i| {
            if ((p.queueFlags & flags != 0) and (p.queueFlags & VK_QUEUE_GRAPHICS_BIT == 0) and
                (p.queueFlags & VK_QUEUE_COMPUTE_BIT == 0))
            {
                return @intCast(u32, i);
            }
        }
    }
    for (props) |p, i| {
        if (p.queueFlags & flags != 0) {
            return @intCast(u32, i);
        }
    }
    return error.QueueFamilyNotFound;
}

pub fn createContext(allocator: *Allocator, inst: VkInstance, req_queue_types: VkQueueFlagBits, use_swapchain: bool) !Context {
    const exten_names = if (use_swapchain)
        &[_][*:0]const u8{VK_KHR_SWAPCHAIN_EXTENSION_NAME}
    else
        &[_][*:0]const u8{};

    var num_phys_devices: u32 = 0;
    try checkSuccess(vkEnumeratePhysicalDevices(inst, &num_phys_devices, null));
    if (num_phys_devices == 0) return error.VulkanContextNotFound;

    const phys_device_list = try allocator.alloc(VkPhysicalDevice, num_phys_devices);
    defer allocator.free(phys_device_list);
    try checkSuccess(vkEnumeratePhysicalDevices(inst, &num_phys_devices, phys_device_list.ptr));

    var phys: VkPhysicalDevice = for (phys_device_list) |d| {
        if (try checkContextExtensionSupport(allocator, d, exten_names)) {
            break d;
        }
    } else return error.InvalidContext;

    var queue_count: u32 = 0;
    vkGetPhysicalDeviceQueueFamilyProperties(phys, &queue_count, null);
    if (queue_count == 0) return error.NoContextQueues;

    const queue_props = try allocator.alloc(VkQueueFamilyProperties, queue_count);
    defer allocator.free(queue_props);
    vkGetPhysicalDeviceQueueFamilyProperties(phys, &queue_count, queue_props.ptr);

    var gfx_queue_idx: ?u32 = null;
    var comp_queue_idx: ?u32 = null;
    var trans_queue_idx: ?u32 = null;

    var queue_create_infos = try std.ArrayList(VkDeviceQueueCreateInfo).initCapacity(allocator, 3);
    defer queue_create_infos.deinit();

    const def_priority: f32 = 0.0;
    if (req_queue_types & VK_QUEUE_GRAPHICS_BIT != 0) {
        gfx_queue_idx = try getQueueFamilyIndex(queue_props, VK_QUEUE_GRAPHICS_BIT);
        try queue_create_infos.append(VkDeviceQueueCreateInfo{
            .queueFamilyIndex = gfx_queue_idx.?,
            .queueCount = 1,
            .pQueuePriorities = &def_priority,
        });
    }
    if (req_queue_types & VK_QUEUE_COMPUTE_BIT != 0) {
        comp_queue_idx = try getQueueFamilyIndex(queue_props, VK_QUEUE_COMPUTE_BIT);
        try queue_create_infos.append(VkDeviceQueueCreateInfo{
            .queueFamilyIndex = comp_queue_idx.?,
            .queueCount = 1,
            .pQueuePriorities = &def_priority,
        });
    } else {
        comp_queue_idx = gfx_queue_idx;
    }
    if (req_queue_types & VK_QUEUE_TRANSFER_BIT != 0) {
        trans_queue_idx = try getQueueFamilyIndex(queue_props, VK_QUEUE_TRANSFER_BIT);
        try queue_create_infos.append(VkDeviceQueueCreateInfo{
            .queueFamilyIndex = trans_queue_idx.?,
            .queueCount = 1,
            .pQueuePriorities = &def_priority,
        });
    } else {
        trans_queue_idx = gfx_queue_idx;
    }

    const queue_infos_slice = queue_create_infos.items;
    const dev_create_info = VkDeviceCreateInfo{
        .queueCreateInfoCount = @intCast(u32, queue_infos_slice.len),
        .pQueueCreateInfos = queue_infos_slice.ptr,
        .pEnabledFeatures = &VkPhysicalDeviceFeatures{
            .samplerAnisotropy = VK_TRUE,
        },
        .enabledExtensionCount = @intCast(u32, exten_names.len),
        .ppEnabledExtensionNames = exten_names.ptr,
        .enabledLayerCount = 0,
        .ppEnabledLayerNames = null,
    };

    var dev: VkDevice = null;
    try checkSuccess(vkCreateDevice(phys, &dev_create_info, null, &dev));

    const vma_ci = VmaAllocatorCreateInfo{
        .physicalDevice = phys,
        .device = dev,
        .instance = inst,
    };

    var mem_alloc: VmaAllocator = undefined;
    try checkSuccess(vmaCreateAllocator(&vma_ci, &mem_alloc));

    var gfx_queue: VkQueue = undefined;
    vkGetDeviceQueue(dev, gfx_queue_idx.?, 0, &gfx_queue);

    const samp_info = VkSamplerCreateInfo{
        .magFilter = VK_FILTER_LINEAR,
        .minFilter = VK_FILTER_LINEAR,
        .addressModeU = VK_SAMPLER_ADDRESS_MODE_REPEAT,
        .addressModeV = VK_SAMPLER_ADDRESS_MODE_REPEAT,
        .addressModeW = VK_SAMPLER_ADDRESS_MODE_REPEAT,
        .anisotropyEnable = VK_TRUE,
        .maxAnisotropy = 16,
        .borderColor = VK_BORDER_COLOR_INT_OPAQUE_BLACK,
        .unnormalizedCoordinates = VK_FALSE,
        .compareEnable = VK_FALSE,
        .compareOp = VK_COMPARE_OP_ALWAYS,
        .mipmapMode = VK_SAMPLER_MIPMAP_MODE_LINEAR,
        .mipLodBias = 0.0,
        .minLod = 0.0,
        .maxLod = 0.0,
    };

    var sampler: VkSampler = undefined;
    try checkSuccess(vkCreateSampler(dev, &samp_info, null, &sampler));

    const cmd_pool = try createCommandPoolInternal(dev, gfx_queue_idx.?, null);
    const alloc_info = VkCommandBufferAllocateInfo{
        .commandPool = cmd_pool,
        .level = VK_COMMAND_BUFFER_LEVEL_PRIMARY,
        .commandBufferCount = 1,
    };
    var cmd_buf: VkCommandBuffer = undefined;
    checkSuccess(vkAllocateCommandBuffers(dev, &alloc_info, &cmd_buf)) catch unreachable;

    const fence_info = VkFenceCreateInfo{};
    var fence: VkFence = undefined;
    checkSuccess(vkCreateFence(dev, &fence_info, null, &fence)) catch unreachable;

    return Context{
        .allocator = allocator,
        .mem_alloc = mem_alloc,
        .physical = phys,
        .logical = dev,
        .queue_indices = .{
            .graphics = gfx_queue_idx.?,
            .compute = comp_queue_idx,
            .transfer = trans_queue_idx,
        },
        .depth_format = try getOptimalDepthFormat(phys),
        .cmd_pool = cmd_pool,
        .timed_cmd_buffer = cmd_buf,
        .trans_fence = fence,
        .gfx_queue = gfx_queue,
        .sampler = sampler,
    };
}

pub fn createCommandPool(dev: Context, queue_idx: u32, create_flags: ?VkCommandPoolCreateFlags) !VkCommandPool {
    return createCommandPoolInternal(dev.logical, queue_idx, create_flags);
}

fn createCommandPoolInternal(dev: VkDevice, queue_idx: u32, create_flags: ?VkCommandPoolCreateFlags) !VkCommandPool {
    const pool_create_info = VkCommandPoolCreateInfo{
        .queueFamilyIndex = queue_idx,
        .flags = create_flags orelse VK_COMMAND_POOL_CREATE_RESET_COMMAND_BUFFER_BIT,
    };
    var pool: VkCommandPool = undefined;
    try checkSuccess(vkCreateCommandPool(dev, &pool_create_info, null, &pool));
    return pool;
}

pub fn createCommandBuffers(allocator: *Allocator, pool: VkCommandPool, level: VkCommandBufferLevel, num_buffers: u32) []VkCommandBuffer {
    const cmd_buffers = try allocator.alloc(VkCommandBuffer, num_buffers);
    errdefer allocator.free(cmd_buffers);

    const alloc_info = VkCommandBufferAllocateInfo{
        .commandPool = pool,
        .level = level,
        .commandBufferCount = num_buffers,
    };
    try checkSuccess(vkAllocateCommandBuffers(dev, &alloc_info, cmd_buffers.ptr));
    return cmd_buffers.toOwnedSlice();
}

fn createSingleCommandBuffer(pool: VkCommandPool, level: VkCommandBufferLevel) VkCommandBuffer {
    const alloc_info = VkCommandBufferAllocateInfo{
        .commandPool = pool,
        .level = level,
        .commandBufferCount = 1,
    };
    var cmd_buf: VkCommandBuffer = undefined;
    try checkSuccess(vkAllocateCommandBuffers(dev, &alloc_info, &cmd_buf));
    return cmd_buf;
}

pub fn beginTimedCommand(dev: Context) VkCommandBuffer {
    checkSuccess(vkBeginCommandBuffer(dev.timed_cmd_buffer, &VkCommandBufferBeginInfo{})) catch unreachable;
    return dev.timed_cmd_buffer;
}

pub fn endTimedCommand(dev: Context) void {
    const submit_info = VkSubmitInfo{
        .waitSemaphoreCount = 0,
        .pWaitSemaphores = null,
        .pWaitDstStageMask = null,
        .commandBufferCount = 1,
        .pCommandBuffers = &dev.timed_cmd_buffer,
        .signalSemaphoreCount = 0,
        .pSignalSemaphores = null,
    };

    const fence_info = VkFenceCreateInfo{};
    var fence: VkFence = undefined;
    checkSuccess(vkEndCommandBuffer(dev.timed_cmd_buffer)) catch unreachable;
    checkSuccess(vkQueueSubmit(dev.gfx_queue, 1, &submit_info, dev.trans_fence)) catch unreachable;
    checkSuccess(vkWaitForFences(dev.logical, 1, &dev.trans_fence, VK_TRUE, std.math.maxInt(u32))) catch unreachable;
    checkSuccess(vkResetFences(dev.logical, 1, &dev.trans_fence)) catch unreachable;
}

fn findSupportedFormat(phys: VkPhysicalDevice, list: []const VkFormat, tiling: VkImageTiling, feats: VkFormatFeatureFlags) !VkFormat {
    for (list) |fmt| {
        var props: VkFormatProperties = undefined;
        vkGetPhysicalDeviceFormatProperties(phys, fmt, &props);
        if (tiling == VK_IMAGE_TILING_LINEAR and props.linearTilingFeatures & feats == feats) {
            return fmt;
        } else if (tiling == VK_IMAGE_TILING_OPTIMAL and props.optimalTilingFeatures & feats == feats) {
            return fmt;
        }
    }
    return error.NoSupportedContextFormat;
}

fn getOptimalDepthFormat(phys: VkPhysicalDevice) !VkFormat {
    const fmts = [_]VkFormat{ VK_FORMAT_D32_SFLOAT_S8_UINT, VK_FORMAT_D32_SFLOAT, VK_FORMAT_D24_UNORM_S8_UINT, VK_FORMAT_D16_UNORM_S8_UINT, VK_FORMAT_D16_UNORM };
    return findSupportedFormat(
        phys,
        fmts[0..],
        VK_IMAGE_TILING_OPTIMAL,
        VK_FORMAT_FEATURE_DEPTH_STENCIL_ATTACHMENT_BIT | VK_FORMAT_FEATURE_SAMPLED_IMAGE_BIT,
    );
}

fn findBufferUsageVMA(usage: VkBufferUsageFlags) vma.VmaMemoryUsage {
    if (usage & VK_BUFFER_USAGE_TRANSFER_SRC_BIT != 0) {
        return vma.VMA_MEMORY_USAGE_CPU_ONLY;
    } else if (usage & VK_BUFFER_USAGE_TRANSFER_DST_BIT != 0) {
        return vma.VMA_MEMORY_USAGE_GPU_ONLY;
    } else {
        return vma.VMA_MEMORY_USAGE_CPU_TO_GPU;
    }
}

fn findImageUsageVMA(usage: VkImageUsageFlags) vma.VmaMemoryUsage {
    if (usage & VK_IMAGE_USAGE_TRANSFER_SRC_BIT != 0) {
        return vma.VMA_MEMORY_USAGE_CPU_ONLY;
    } else if (usage & VK_IMAGE_USAGE_TRANSFER_DST_BIT != 0) {
        return vma.VMA_MEMORY_USAGE_GPU_ONLY;
    } else if (usage & VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT != 0) {
        return vma.VMA_MEMORY_USAGE_GPU_ONLY;
    } else if (usage & VK_IMAGE_USAGE_TRANSIENT_ATTACHMENT_BIT != 0) {
        return vma.VMA_MEMORY_USAGE_GPU_ONLY;
    } else if (usage & VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT != 0) {
        return vma.VMA_MEMORY_USAGE_GPU_ONLY;
    } else {
        return vma.VMA_MEMORY_USAGE_CPU_TO_GPU;
    }
}

fn isValidCPUBuffer(usage: vma.VmaMemoryUsage) bool {
    switch (usage) {
        VMA_MEMORY_USAGE_CPU_ONLY, VMA_MEMORY_USAGE_CPU_TO_GPU => return true,
        else => return false,
    }
}

pub const BufferUsage = enum {
    Vertex,
    Index,
    Uniform,
};

fn getVkBufferUsage(usage: BufferUsage) VkBufferUsageFlags {
    switch (usage) {
        .Vertex => return VK_BUFFER_USAGE_VERTEX_BUFFER_BIT,
        .Index => return VK_BUFFER_USAGE_INDEX_BUFFER_BIT,
        .Uniform => return VK_BUFFER_USAGE_UNIFORM_BUFFER_BIT,
    }
}

pub fn createStageBuffer(mem_alloc: VmaAllocator, comptime T: type, data: T) !Buffer {
    const size_of_type = @sizeOf(T);
    return createBufferInternal(mem_alloc, VK_BUFFER_USAGE_TRANSFER_SRC_BIT, @ptrCast([*]const u8, &data), size_of_type, false);
}

pub fn createStageBufferWithSize(mem_alloc: VmaAllocator, size: usize) !Buffer {
    return createBufferInternal(mem_alloc, VK_BUFFER_USAGE_TRANSFER_SRC_BIT, null, size, false);
}

pub fn createStageBufferWithSlice(mem_alloc: VmaAllocator, comptime T: type, data: []const T) !Buffer {
    const size_of_data = @sizeOf(T) * data.len;
    return createBufferInternal(mem_alloc, VK_BUFFER_USAGE_TRANSFER_SRC_BIT, @ptrCast([*]const u8, data.ptr), size_of_data, false);
}

pub fn createDestBufferWithType(mem_alloc: VmaAllocator, usage: BufferUsage, comptime T: type) !Buffer {
    const size_of_type = @sizeOf(T);
    return createBufferInternal(mem_alloc, getVkBufferUsage(usage) | VK_BUFFER_USAGE_TRANSFER_DST_BIT, null, size_of_type, false);
}

pub fn createDestBufferWithLength(mem_alloc: VmaAllocator, usage: BufferUsage, comptime T: type, length: usize) !Buffer {
    return createBufferInternal(mem_alloc, getVkBufferUsage(usage) | VK_BUFFER_USAGE_TRANSFER_DST_BIT, null, @sizeOf(T) * length, false);
}

pub fn createDirectBuffer(mem_alloc: VmaAllocator, usage: BufferUsage, comptime T: type, data: T) !Buffer {
    const size_of_type = @sizeOf(T);
    return createBufferInternal(mem_alloc, getVkBufferUsage(usage), @ptrCast([*]const u8, &data), size_of_type, true);
}

pub fn createDirectBufferWithType(mem_alloc: VmaAllocator, usage: BufferUsage, comptime T: type) !Buffer {
    const size_of_type = @sizeOf(T);
    return createBufferInternal(mem_alloc, getVkBufferUsage(usage), null, size_of_type, true);
}

pub fn createDirectBufferWithSlice(mem_alloc: VmaAllocator, usage: BufferUsage, comptime T: type, data: []const T) !Buffer {
    const size_of_data = @sizeOf(T) * data.len;
    return createBufferInternal(mem_alloc, getVkBufferUsage(usage), @ptrCast([*]const u8, data.ptr), size_of_data, true);
}

pub fn createDirectBufferWithLength(mem_alloc: VmaAllocator, usage: BufferUsage, comptime T: type, length: usize) !Buffer {
    return createBufferInternal(mem_alloc, getVkBufferUsage(usage), null, @sizeOf(T) * length, true);
}

pub fn createDirectBufferSliceWithLength(allocator: *Allocator, mem_alloc: VmaAllocator, usage: BufferUsage, comptime T: type, length: usize, num_buffers: usize) ![]Buffer {
    var bufs = try allocator.alloc(Buffer, num_buffers);
    for (bufs) |*b| b.* = try createBufferInternal(mem_alloc, getVkBufferUsage(usage), null, @sizeOf(T) * length, true);
    return bufs;
}

fn createBufferInternal(mem_alloc: VmaAllocator, usage: VkBufferUsageFlags, data: ?[*]const u8, size: usize, keep_mapped: bool) !Buffer {
    var buf_info = VkBufferCreateInfo{
        .size = size,
        .usage = usage,
        .sharingMode = VK_SHARING_MODE_EXCLUSIVE,
    };
    const vma_usage = findBufferUsageVMA(usage);
    const vma_aci = vma.VmaAllocationCreateInfo{
        .usage = vma_usage,
    };

    var buf_hndl: VkBuffer = undefined;
    var vma_alcn: vma.VmaAllocation = undefined;
    try checkSuccess(vma.vmaCreateBuffer(mem_alloc, &buf_info, &vma_aci, &buf_hndl, &vma_alcn, null));
    errdefer vma.vmaDestroyBuffer(mem_alloc, buf_hndl, vma_alcn);

    var ptr: ?*c_void = null;
    if (!isValidCPUBuffer(vma_usage) and keep_mapped) unreachable;
    if (keep_mapped) {
        try checkSuccess(vma.vmaMapMemory(mem_alloc, vma_alcn, &ptr));
    }
    if (data) |d| {
        if (ptr == null) {
            try checkSuccess(vma.vmaMapMemory(mem_alloc, vma_alcn, &ptr));
        }
        @memcpy(@ptrCast([*]u8, ptr), d, size);
        if (!keep_mapped) {
            vma.vmaUnmapMemory(mem_alloc, vma_alcn);
            ptr = null;
        }
    }
    return Buffer{
        .handle = buf_hndl,
        .memory = vma_alcn,
        .usage = vma_usage,
        .size = size,
        .ptr = ptr,
    };
}

pub fn updateBuffer(dev: Context, buf: Buffer, comptime T: type, data: T) !void {
    const size = @sizeOf(T);
    if (buf.size < size) unreachable;
    if (buf.usage == VMA_MEMORY_USAGE_GPU_ONLY) unreachable;
    if (buf.ptr) |ptr| {
        @memcpy(@ptrCast([*]u8, ptr), @ptrCast([*]const u8, &data), size);
    } else {
        var ptr: ?*c_void = null;
        try checkSuccess(vma.vmaMapMemory(dev.mem_alloc, buf.memory, &ptr));
        @memcpy(@ptrCast([*]u8, ptr), @ptrCast([*]const u8, &data), size);
        vma.vmaUnmapMemory(dev.mem_alloc, buf.memory);
    }
}

pub fn updateBufferWithSlice(dev: Context, buf: Buffer, comptime T: type, data: []const T) !void {
    const size = @sizeOf(T) * data.len;
    if (buf.size < size) unreachable;
    if (buf.usage == VMA_MEMORY_USAGE_GPU_ONLY) unreachable;
    if (buf.ptr) |ptr| {
        @memcpy(@ptrCast([*]u8, ptr), @ptrCast([*]const u8, data.ptr), size);
    } else {
        var ptr: ?*c_void = null;
        try checkSuccess(vma.vmaMapMemory(dev.mem_alloc, buf.memory, &ptr));
        @memcpy(@ptrCast([*]u8, ptr), @ptrCast([*]const u8, data.ptr), size);
        vma.vmaUnmapMemory(dev.mem_alloc, buf.memory);
    }
}

pub fn copyBufferToBuffer(dev: Context, src_buf: Buffer, dst_buf: Buffer, buf_copy: ?VkBufferCopy) !void {
    var copy_region: VkBufferCopy = undefined;
    if (buf_copy) |bc| {
        if (bc.srcOffset + bc.size > src_buf.size) return error.InvalidBufferCopy;
        if (bc.dstOffset + bc.size > dst_buf.size) return error.InvalidBufferCopy;
        copy_region = bc;
    } else {
        if (src_buf.size > dst_buf.size) return error.DstBufferTooSmall;
        copy_region = .{
            .srcOffset = 0,
            .dstOffset = 0,
            .size = src_buf.size,
        };
    }
    const cbuf = beginTimedCommand(dev);
    vkCmdCopyBuffer(cbuf, src_buf.handle, dst_buf.handle, 1, &copy_region);
    endTimedCommand(dev);
}

fn copyBufferToImageNoMIPS(cmd_buf: VkCommandBuffer, src_buf: Buffer, img: Image, aspect_flags: VkImageAspectFlags, layout: VkImageLayout, buf_copy: ?VkBufferImageCopy) !void {
    var copy_region: VkBufferImageCopy = undefined;
    const total_size = @intCast(usize, img.extent.width * img.extent.height * img.extent.depth) * 4;
    if (buf_copy) |bc| {
        const req_size = @intCast(usize, bc.imageExtent.width * bc.imageExtent.height * bc.imageExtent.depth);
        if (bc.bufferOffset + req_size > total_size) return error.InvalidBufferToImageCopy;
        if (bc.bufferOffset + req_size > src_buf.size) return error.InvalidBufferToImageCopy;
        copy_region = bc;
    } else {
        if (src_buf.size > total_size) return error.ImageTooSmall;
        copy_region = .{
            .imageSubresource = .{
                .aspectMask = aspect_flags,
                .mipLevel = 0,
                .baseArrayLayer = 0,
                .layerCount = 1,
            },
            .imageExtent = img.extent,
            .bufferOffset = 0,
            .imageOffset = .{},
        };
    }
    vkCmdCopyBufferToImage(cmd_buf, src_buf.handle, img.handle, layout, 1, &copy_region);
}

pub fn destroyBuffer(mem_alloc: VmaAllocator, buf: Buffer) void {
    vma.vmaDestroyBuffer(mem_alloc, buf.handle, buf.memory);
}

pub fn createMSAAImageRef(dev: Context, format: VkFormat, extent: VkExtent2D, num_samples: VkSampleCountFlagBits) !ImageRef {
    const img_info = VkImageCreateInfo{
        .imageType = VK_IMAGE_TYPE_2D,
        .format = format,
        .extent = .{ .width = extent.width, .height = extent.height, .depth = 1 },
        .mipLevels = 1,
        .arrayLayers = 1,
        .samples = num_samples,
        .tiling = VK_IMAGE_TILING_OPTIMAL,
        .usage = VK_IMAGE_USAGE_TRANSIENT_ATTACHMENT_BIT | VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT,
    };

    var img = try createImageBase(dev, img_info);
    const view = try createImageViewBase(dev.logical, img.handle, VK_IMAGE_VIEW_TYPE_2D, format, VK_IMAGE_ASPECT_COLOR_BIT);
    return ImageRef{ .image = img, .view = view };
}

pub fn createDestColorAttachImageRefsSlice(allocator: *Allocator, dev: Context, format: VkFormat, extent: VkExtent2D, num_refs: usize) ![]ImageRef {
    var refs = try allocator.alloc(ImageRef, num_refs);
    const start_layout = VK_IMAGE_LAYOUT_UNDEFINED;
    const final_layout = VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL;
    const aspect_flags = VK_IMAGE_ASPECT_COLOR_BIT;

    var trans_barrier = VkImageMemoryBarrier{
        .oldLayout = start_layout,
        .newLayout = final_layout,
        .image = undefined,
        .subresourceRange = defImageSubresRange(aspect_flags),
        .srcAccessMask = getSrcAccessFlags(start_layout),
        .dstAccessMask = getDstAccessFlags(final_layout),
    };

    const cmd_buf = beginTimedCommand(dev);
    defer endTimedCommand(dev);

    for (refs) |*r| {
        r.* = try createDestColorAttachImageRef(dev, format, extent);
        trans_barrier.image = r.image.handle;
        vkCmdPipelineBarrier(cmd_buf, VK_PIPELINE_STAGE_TOP_OF_PIPE_BIT, VK_PIPELINE_STAGE_FRAGMENT_SHADER_BIT, 0, 0, null, 0, null, 1, &trans_barrier);
    }
    return refs;
}

pub fn createDestColorAttachImageRef(dev: Context, format: VkFormat, extent: VkExtent2D) !ImageRef {
    const img_info = VkImageCreateInfo{
        .imageType = VK_IMAGE_TYPE_2D,
        .format = format,
        .extent = .{ .width = extent.width, .height = extent.height, .depth = 1 },
        .mipLevels = 1,
        .arrayLayers = 1,
        .samples = VK_SAMPLE_COUNT_1_BIT,
        .tiling = VK_IMAGE_TILING_OPTIMAL,
        .usage = VK_IMAGE_USAGE_SAMPLED_BIT | VK_IMAGE_USAGE_INPUT_ATTACHMENT_BIT | VK_IMAGE_USAGE_COLOR_ATTACHMENT_BIT,
    };

    var img = try createImageBase(dev, img_info);
    const view = try createImageViewBase(dev.logical, img.handle, VK_IMAGE_VIEW_TYPE_2D, format, VK_IMAGE_ASPECT_COLOR_BIT);
    return ImageRef{ .image = img, .view = view };
}

pub fn createDirectColorImageRefNoMIPS(dev: Context, width: u32, height: u32, format: VkFormat, comptime T: type, data: []T) !ImageRef {
    const stage_buf = try createStageBufferWithSlice(dev.mem_alloc, T, data);
    defer destroyBuffer(dev.mem_alloc, stage_buf);
    const img_info = VkImageCreateInfo{
        .imageType = VK_IMAGE_TYPE_2D,
        .format = format,
        .extent = .{ .width = width, .height = height, .depth = 1 },
        .mipLevels = 1,
        .arrayLayers = 1,
        .samples = VK_SAMPLE_COUNT_1_BIT,
        .tiling = VK_IMAGE_TILING_OPTIMAL,
        .usage = VK_IMAGE_USAGE_SAMPLED_BIT | VK_IMAGE_USAGE_TRANSFER_DST_BIT,
    };
    var img = try createImageBase(dev, img_info);
    const view = try createImageViewBase(dev.logical, img.handle, VK_IMAGE_VIEW_TYPE_2D, format, VK_IMAGE_ASPECT_COLOR_BIT);

    const start_layout = VK_IMAGE_LAYOUT_UNDEFINED;
    const trans_layout = VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL;
    const aspect_flags = VK_IMAGE_ASPECT_COLOR_BIT;

    const trans_barrier = VkImageMemoryBarrier{
        .oldLayout = start_layout,
        .newLayout = trans_layout,
        .image = img.handle,
        .subresourceRange = defImageSubresRange(aspect_flags),
        .srcAccessMask = getSrcAccessFlags(start_layout),
        .dstAccessMask = getDstAccessFlags(trans_layout),
    };

    const cmd_buf = beginTimedCommand(dev);
    defer endTimedCommand(dev);

    vkCmdPipelineBarrier(cmd_buf, VK_PIPELINE_STAGE_HOST_BIT, VK_PIPELINE_STAGE_TRANSFER_BIT, 0, 0, null, 0, null, 1, &trans_barrier);
    try copyBufferToImageNoMIPS(cmd_buf, stage_buf, img, aspect_flags, VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL, null);

    const final_layout = VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL;
    const read_barrier = VkImageMemoryBarrier{
        .oldLayout = trans_layout,
        .newLayout = final_layout,
        .image = img.handle,
        .subresourceRange = defImageSubresRange(aspect_flags),
        .srcAccessMask = getSrcAccessFlags(trans_layout),
        .dstAccessMask = getDstAccessFlags(final_layout),
    };
    vkCmdPipelineBarrier(cmd_buf, VK_PIPELINE_STAGE_TRANSFER_BIT, VK_PIPELINE_STAGE_FRAGMENT_SHADER_BIT, 0, 0, null, 0, null, 1, &read_barrier);
    img.layout = final_layout;
    return ImageRef{
        .image = img,
        .view = view,
    };
}

fn getSrcAccessFlags(layout: VkImageLayout) VkAccessFlags {
    switch (layout) {
        // Image layout is undefined (or does not matter)
        // Only valid as initial layout
        // No flags required, listed only for completeness
        VK_IMAGE_LAYOUT_UNDEFINED => return 0,
        // Image is preinitialized
        // Only valid as initial layout for linear images, preserves memory contents
        // Make sure host writes have been finished
        VK_IMAGE_LAYOUT_PREINITIALIZED => return VK_ACCESS_HOST_WRITE_BIT,
        // Image is a color attachment
        // Make sure any writes to the color buffer have been finished
        VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL => return VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,
        // Image is a depth/stencil attachment
        // Make sure any writes to the depth/stencil buffer have been finished
        VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL => return VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT,
        // Image is a transfer source
        // Make sure any reads from the image have been finished
        VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL => return VK_ACCESS_TRANSFER_READ_BIT,
        // Image is a transfer destination
        // Make sure any writes to the image have been finished
        VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL => return VK_ACCESS_TRANSFER_WRITE_BIT,
        // Image is read by a shader
        // Make sure any shader reads from the image have been finished
        VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL => return VK_ACCESS_SHADER_READ_BIT,
        else => @panic("Unexpected VkImageLayout in getSrcAccessFlags"),
    }
}

fn getDstAccessFlags(layout: VkImageLayout) VkAccessFlags {
    switch (layout) {
        // Image will be used as a transfer destination
        // Make sure any writes to the image have been finished
        VK_IMAGE_LAYOUT_TRANSFER_DST_OPTIMAL => return VK_ACCESS_TRANSFER_WRITE_BIT,

        // Image will be used as a transfer source
        // Make sure any reads from the image have been finished
        VK_IMAGE_LAYOUT_TRANSFER_SRC_OPTIMAL => return VK_ACCESS_TRANSFER_READ_BIT,

        // Image will be used as a color attachment
        // Make sure any writes to the color buffer have been finished
        VK_IMAGE_LAYOUT_COLOR_ATTACHMENT_OPTIMAL => return VK_ACCESS_COLOR_ATTACHMENT_WRITE_BIT,

        // Image layout will be used as a depth/stencil attachment
        // Make sure any writes to depth/stencil buffer have been finished
        VK_IMAGE_LAYOUT_DEPTH_STENCIL_ATTACHMENT_OPTIMAL => return VK_ACCESS_DEPTH_STENCIL_ATTACHMENT_WRITE_BIT,

        // Image will be read in a shader (sampler, input attachment)
        // Make sure any writes to the image have been finished
        VK_IMAGE_LAYOUT_SHADER_READ_ONLY_OPTIMAL => return VK_ACCESS_SHADER_READ_BIT,
        else => @panic("Unexpected VkImageLayout in getDstAccessFlags"),
    }
}

fn hasStencilComponent(fmt: VkFormat) bool {
    return fmt == VK_FORMAT_D32_SFLOAT_S8_UINT or fmt == VK_FORMAT_D24_UNORM_S8_UINT;
}

fn defImageSubresRange(aspect: VkImageAspectFlags) VkImageSubresourceRange {
    return VkImageSubresourceRange{
        .aspectMask = aspect,
        .baseMipLevel = 0,
        .baseArrayLayer = 0,
        .levelCount = 1,
        .layerCount = 1,
    };
}

pub fn queueImageLayoutNoMIPS(dev: Context, img: Image, aspect_flags: VkImageAspectFlags, old_layout: VkImageLayout, new_layout: VkImageLayout, src_flags: VkPipelineStageFlags, dst_flags: VkPipelineStageFlags) void {
    const range = VkImageSubresourceRange{
        .aspectMask = aspect_flags,
        .baseMipLevel = 0,
        .levelCount = 1,
        .layerCount = 1,
    };

    return setImageLayoutInternal(dev.gfx_queue, img.image.handle, old_layout, new_layout, src_flags, dst_flags);
}

fn queueImageLayoutInternal(cmd_buf: VkCommandBuffer, handle: VkImage, old_layout: VkImageLayout, new_layout: VkImageLayout, sub_range: VkImageSubresourceRange, src_flags: VkPipelineStageFlags, dst_flags: VkPipelineStageFlags) void {
    const barrier = VkImageMemoryBarrier{
        .oldLayout = old_layout,
        .newLayout = new_layout,
        .image = handle,
        .subresourceRange = sub_res,
        .subAccessMask = getSrcAccessFlags(old_layout),
        .dstAccessMask = getDstAccessFlags(new_layout),
    };

    vkCmdPipelineBarrier(cmd_buf, src_flags, dst_flags, 0, 0, null, 0, null, 1, &barrier);
}

pub fn createDepthImageRef(dev: Context, extent: VkExtent2D) !ImageRef {
    const img_info = VkImageCreateInfo{
        .imageType = VK_IMAGE_TYPE_2D,
        .format = dev.depth_format,
        .extent = .{ .width = extent.width, .height = extent.height, .depth = 1 },
        .mipLevels = 1,
        .arrayLayers = 1,
        .samples = VK_SAMPLE_COUNT_1_BIT,
        .tiling = VK_IMAGE_TILING_OPTIMAL,
        .usage = VK_IMAGE_USAGE_DEPTH_STENCIL_ATTACHMENT_BIT,
    };
    const img = try createImageBase(dev, img_info);

    const view = try createImageViewBase(dev.logical, img.handle, VK_IMAGE_VIEW_TYPE_2D, dev.depth_format, VK_IMAGE_ASPECT_DEPTH_BIT);

    return ImageRef{
        .image = img,
        .view = view,
    };
}

fn createImageBase(dev: Context, img_info: VkImageCreateInfo) !Image {
    const vma_aci = vma.VmaAllocationCreateInfo{
        .usage = vma.VMA_MEMORY_USAGE_GPU_ONLY,
    };

    var vma_alcn: vma.VmaAllocation = undefined;
    var img: VkImage = undefined;
    try checkSuccess(vma.vmaCreateImage(dev.mem_alloc, &img_info, &vma_aci, &img, &vma_alcn, null));

    return Image{
        .handle = img,
        .memory = vma_alcn,
        .extent = img_info.extent,
        .layout = VK_IMAGE_LAYOUT_UNDEFINED,
    };
}

fn createImageViewBase(dev: VkDevice, img: VkImage, view_type: VkImageViewType, format: VkFormat, aspect_flags: VkImageAspectFlags) !VkImageView {
    const create_info = VkImageViewCreateInfo{
        .image = img,
        .viewType = view_type,
        .format = format,
        .components = VkComponentMapping{},
        .subresourceRange = VkImageSubresourceRange{
            .aspectMask = aspect_flags,
            .baseMipLevel = 0,
            .levelCount = 1,
            .baseArrayLayer = 0,
            .layerCount = 1,
        },
    };
    var image_view: VkImageView = undefined;
    try checkSuccess(vkCreateImageView(dev, &create_info, null, &image_view));

    return image_view;
}

pub fn createPushConstantRange(comptime T: type) VkPushConstantRange {
    return VkPushConstantRange{
        .offset = 0,
        .size = @sizeOf(T),
        .stageFlags = VK_SHADER_STAGE_VERTEX_BIT | VK_SHADER_STAGE_FRAGMENT_BIT,
    };
}

pub fn createShaderModule(dev: VkDevice, code: []align(@alignOf(u32)) const u8) !VkShaderModule {
    const create_info = VkShaderModuleCreateInfo{
        .codeSize = code.len,
        .pCode = std.mem.bytesAsSlice(u32, code).ptr,
    };
    var module: VkShaderModule = undefined;
    try checkSuccess(vkCreateShaderModule(dev, &create_info, null, &module));
    return module;
}

pub fn destroyBasicShader(dev: Context, shader: BasicShader) void {
    vkDestroyShader(dev.logical, shader.vertex);
    vkDestroyShader(dev.logical, shader.fragment);
}

pub fn createSemaphore(dev: Context) !VkSemaphore {
    const sema_info = VkSemaphoreCreateInfo{};
    var sema: VkSemaphore = undefined;
    try checkSuccess(vkCreateSemaphore(dev.logical, &sema_info, null, &sema));
    return sema;
}

//note(ryan): caller is responsible for returned memory
pub fn createSemaphoreSlice(allocator: *Allocator, dev: Context, req_len: usize) ![]VkSemaphore {
    const sema_list = try allocator.alloc(VkSemaphore, req_len);
    errdefer allocator.free(sema_list);
    const sema_info = VkSemaphoreCreateInfo{};
    var i: usize = 0;
    while (i < req_len) : (i += 1) {
        try checkSuccess(vkCreateSemaphore(dev.logical, &sema_info, null, &sema_list[i]));
    }
    return sema_list;
}

pub fn deinitContext(d: Context) void {
    if (d.cmd_pool) |cp| vkDestroyCommandPool(d.logical, cp, null);
}

pub fn waitUntilIdle(d: Context) !void {
    return checkSuccess(vkDeviceWaitIdle(d.logical));
}
