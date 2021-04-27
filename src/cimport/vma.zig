const vulkan = @import("vulkan.zig");
usingnamespace vulkan;
pub const VmaAllocator = ?*struct_VmaAllocator_T;
pub const VmaDeviceMemoryCallbacks = struct_VmaDeviceMemoryCallbacks;
pub const VMA_ALLOCATOR_CREATE_EXTERNALLY_SYNCHRONIZED_BIT = enum_VmaAllocatorCreateFlagBits.VMA_ALLOCATOR_CREATE_EXTERNALLY_SYNCHRONIZED_BIT;
pub const VMA_ALLOCATOR_CREATE_KHR_DEDICATED_ALLOCATION_BIT = enum_VmaAllocatorCreateFlagBits.VMA_ALLOCATOR_CREATE_KHR_DEDICATED_ALLOCATION_BIT;
pub const VMA_ALLOCATOR_CREATE_KHR_BIND_MEMORY2_BIT = enum_VmaAllocatorCreateFlagBits.VMA_ALLOCATOR_CREATE_KHR_BIND_MEMORY2_BIT;
pub const VMA_ALLOCATOR_CREATE_EXT_MEMORY_BUDGET_BIT = enum_VmaAllocatorCreateFlagBits.VMA_ALLOCATOR_CREATE_EXT_MEMORY_BUDGET_BIT;
pub const VMA_ALLOCATOR_CREATE_FLAG_BITS_MAX_ENUM = enum_VmaAllocatorCreateFlagBits.VMA_ALLOCATOR_CREATE_FLAG_BITS_MAX_ENUM;
pub const VmaAllocatorCreateFlagBits = enum_VmaAllocatorCreateFlagBits;
pub const VmaAllocatorCreateFlags = VkFlags;
pub const VmaVulkanFunctions = struct_VmaVulkanFunctions;
pub const VMA_RECORD_FLUSH_AFTER_CALL_BIT = enum_VmaRecordFlagBits.VMA_RECORD_FLUSH_AFTER_CALL_BIT;
pub const VMA_RECORD_FLAG_BITS_MAX_ENUM = enum_VmaRecordFlagBits.VMA_RECORD_FLAG_BITS_MAX_ENUM;
pub const VmaRecordFlagBits = enum_VmaRecordFlagBits;
pub const VmaRecordFlags = VkFlags;
pub const VmaRecordSettings = struct_VmaRecordSettings;
pub const VmaAllocatorCreateInfo = struct_VmaAllocatorCreateInfo;
pub const VmaStatInfo = struct_VmaStatInfo;
pub const VmaStats = struct_VmaStats;
pub const VmaBudget = struct_VmaBudget;
pub const VmaPool = ?*struct_VmaPool_T;
pub const VMA_MEMORY_USAGE_UNKNOWN = enum_VmaMemoryUsage.VMA_MEMORY_USAGE_UNKNOWN;
pub const VMA_MEMORY_USAGE_GPU_ONLY = enum_VmaMemoryUsage.VMA_MEMORY_USAGE_GPU_ONLY;
pub const VMA_MEMORY_USAGE_CPU_ONLY = enum_VmaMemoryUsage.VMA_MEMORY_USAGE_CPU_ONLY;
pub const VMA_MEMORY_USAGE_CPU_TO_GPU = enum_VmaMemoryUsage.VMA_MEMORY_USAGE_CPU_TO_GPU;
pub const VMA_MEMORY_USAGE_GPU_TO_CPU = enum_VmaMemoryUsage.VMA_MEMORY_USAGE_GPU_TO_CPU;
pub const VMA_MEMORY_USAGE_CPU_COPY = enum_VmaMemoryUsage.VMA_MEMORY_USAGE_CPU_COPY;
pub const VMA_MEMORY_USAGE_GPU_LAZILY_ALLOCATED = enum_VmaMemoryUsage.VMA_MEMORY_USAGE_GPU_LAZILY_ALLOCATED;
pub const VMA_MEMORY_USAGE_MAX_ENUM = enum_VmaMemoryUsage.VMA_MEMORY_USAGE_MAX_ENUM;
pub const VmaMemoryUsage = enum_VmaMemoryUsage;
pub const VMA_ALLOCATION_CREATE_DEDICATED_MEMORY_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_DEDICATED_MEMORY_BIT;
pub const VMA_ALLOCATION_CREATE_NEVER_ALLOCATE_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_NEVER_ALLOCATE_BIT;
pub const VMA_ALLOCATION_CREATE_MAPPED_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_MAPPED_BIT;
pub const VMA_ALLOCATION_CREATE_CAN_BECOME_LOST_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_CAN_BECOME_LOST_BIT;
pub const VMA_ALLOCATION_CREATE_CAN_MAKE_OTHER_LOST_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_CAN_MAKE_OTHER_LOST_BIT;
pub const VMA_ALLOCATION_CREATE_USER_DATA_COPY_STRING_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_USER_DATA_COPY_STRING_BIT;
pub const VMA_ALLOCATION_CREATE_UPPER_ADDRESS_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_UPPER_ADDRESS_BIT;
pub const VMA_ALLOCATION_CREATE_DONT_BIND_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_DONT_BIND_BIT;
pub const VMA_ALLOCATION_CREATE_WITHIN_BUDGET_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_WITHIN_BUDGET_BIT;
pub const VMA_ALLOCATION_CREATE_STRATEGY_BEST_FIT_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_STRATEGY_BEST_FIT_BIT;
pub const VMA_ALLOCATION_CREATE_STRATEGY_WORST_FIT_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_STRATEGY_WORST_FIT_BIT;
pub const VMA_ALLOCATION_CREATE_STRATEGY_FIRST_FIT_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_STRATEGY_FIRST_FIT_BIT;
pub const VMA_ALLOCATION_CREATE_STRATEGY_MIN_MEMORY_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_STRATEGY_MIN_MEMORY_BIT;
pub const VMA_ALLOCATION_CREATE_STRATEGY_MIN_TIME_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_STRATEGY_MIN_TIME_BIT;
pub const VMA_ALLOCATION_CREATE_STRATEGY_MIN_FRAGMENTATION_BIT = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_STRATEGY_MIN_FRAGMENTATION_BIT;
pub const VMA_ALLOCATION_CREATE_STRATEGY_MASK = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_STRATEGY_MASK;
pub const VMA_ALLOCATION_CREATE_FLAG_BITS_MAX_ENUM = enum_VmaAllocationCreateFlagBits.VMA_ALLOCATION_CREATE_FLAG_BITS_MAX_ENUM;
pub const VmaAllocationCreateFlagBits = enum_VmaAllocationCreateFlagBits;
pub const VmaAllocationCreateFlags = VkFlags;
pub const VmaAllocationCreateInfo = struct_VmaAllocationCreateInfo;
pub const VMA_POOL_CREATE_IGNORE_BUFFER_IMAGE_GRANULARITY_BIT = enum_VmaPoolCreateFlagBits.VMA_POOL_CREATE_IGNORE_BUFFER_IMAGE_GRANULARITY_BIT;
pub const VMA_POOL_CREATE_LINEAR_ALGORITHM_BIT = enum_VmaPoolCreateFlagBits.VMA_POOL_CREATE_LINEAR_ALGORITHM_BIT;
pub const VMA_POOL_CREATE_BUDDY_ALGORITHM_BIT = enum_VmaPoolCreateFlagBits.VMA_POOL_CREATE_BUDDY_ALGORITHM_BIT;
pub const VMA_POOL_CREATE_ALGORITHM_MASK = enum_VmaPoolCreateFlagBits.VMA_POOL_CREATE_ALGORITHM_MASK;
pub const VMA_POOL_CREATE_FLAG_BITS_MAX_ENUM = enum_VmaPoolCreateFlagBits.VMA_POOL_CREATE_FLAG_BITS_MAX_ENUM;
pub const VmaPoolCreateFlagBits = enum_VmaPoolCreateFlagBits;
pub const VmaPoolCreateFlags = VkFlags;
pub const VmaPoolCreateInfo = struct_VmaPoolCreateInfo;
pub const VmaPoolStats = struct_VmaPoolStats;
pub const VmaAllocation = ?*struct_VmaAllocation_T;
pub const VmaAllocationInfo = struct_VmaAllocationInfo;
pub const VmaDefragmentationContext = ?*struct_VmaDefragmentationContext_T;
pub const VMA_DEFRAGMENTATION_FLAG_BITS_MAX_ENUM = enum_VmaDefragmentationFlagBits.VMA_DEFRAGMENTATION_FLAG_BITS_MAX_ENUM;
pub const VmaDefragmentationFlagBits = enum_VmaDefragmentationFlagBits;
pub const VmaDefragmentationFlags = VkFlags;
pub const VmaDefragmentationInfo2 = struct_VmaDefragmentationInfo2;
pub const VmaDefragmentationInfo = struct_VmaDefragmentationInfo;
pub const VmaDefragmentationStats = struct_VmaDefragmentationStats;
pub const VMA_STATS_STRING_ENABLED = 1;
pub const VMA_VULKAN_VERSION = 1001000;
pub const VMA_DEDICATED_ALLOCATION = 1;
pub const VMA_MEMORY_BUDGET = 1;
pub const VMA_BIND_MEMORY2 = 1;
pub const VMA_RECORDING_ENABLED = 0;
pub const VmaAllocator_T = struct_VmaAllocator_T;
pub const VmaPool_T = struct_VmaPool_T;
pub const VmaAllocation_T = struct_VmaAllocation_T;
pub const VmaDefragmentationContext_T = struct_VmaDefragmentationContext_T;
pub const struct_VmaAllocator_T = opaque {};
pub const PFN_vmaAllocateDeviceMemoryFunction = ?fn (VmaAllocator, u32, VkDeviceMemory, VkDeviceSize) callconv(.C) void;
pub const PFN_vmaFreeDeviceMemoryFunction = ?fn (VmaAllocator, u32, VkDeviceMemory, VkDeviceSize) callconv(.C) void;
pub const struct_VmaDeviceMemoryCallbacks = extern struct {
    pfnAllocate: PFN_vmaAllocateDeviceMemoryFunction,
    pfnFree: PFN_vmaFreeDeviceMemoryFunction,
};
pub const enum_VmaAllocatorCreateFlagBits = extern enum {
    VMA_ALLOCATOR_CREATE_EXTERNALLY_SYNCHRONIZED_BIT = 1,
    VMA_ALLOCATOR_CREATE_KHR_DEDICATED_ALLOCATION_BIT = 2,
    VMA_ALLOCATOR_CREATE_KHR_BIND_MEMORY2_BIT = 4,
    VMA_ALLOCATOR_CREATE_EXT_MEMORY_BUDGET_BIT = 8,
    VMA_ALLOCATOR_CREATE_FLAG_BITS_MAX_ENUM = 2147483647,
};
pub const struct_VmaVulkanFunctions = extern struct {
    vkGetPhysicalDeviceProperties: PFN_vkGetPhysicalDeviceProperties,
    vkGetPhysicalDeviceMemoryProperties: PFN_vkGetPhysicalDeviceMemoryProperties,
    vkAllocateMemory: PFN_vkAllocateMemory,
    vkFreeMemory: PFN_vkFreeMemory,
    vkMapMemory: PFN_vkMapMemory,
    vkUnmapMemory: PFN_vkUnmapMemory,
    vkFlushMappedMemoryRanges: PFN_vkFlushMappedMemoryRanges,
    vkInvalidateMappedMemoryRanges: PFN_vkInvalidateMappedMemoryRanges,
    vkBindBufferMemory: PFN_vkBindBufferMemory,
    vkBindImageMemory: PFN_vkBindImageMemory,
    vkGetBufferMemoryRequirements: PFN_vkGetBufferMemoryRequirements,
    vkGetImageMemoryRequirements: PFN_vkGetImageMemoryRequirements,
    vkCreateBuffer: PFN_vkCreateBuffer,
    vkDestroyBuffer: PFN_vkDestroyBuffer,
    vkCreateImage: PFN_vkCreateImage,
    vkDestroyImage: PFN_vkDestroyImage,
    vkCmdCopyBuffer: PFN_vkCmdCopyBuffer,
    vkGetBufferMemoryRequirements2KHR: PFN_vkGetBufferMemoryRequirements2KHR,
    vkGetImageMemoryRequirements2KHR: PFN_vkGetImageMemoryRequirements2KHR,
    vkBindBufferMemory2KHR: PFN_vkBindBufferMemory2KHR,
    vkBindImageMemory2KHR: PFN_vkBindImageMemory2KHR,
    vkGetPhysicalDeviceMemoryProperties2KHR: PFN_vkGetPhysicalDeviceMemoryProperties2KHR,
};
pub const enum_VmaRecordFlagBits = extern enum {
    VMA_RECORD_FLUSH_AFTER_CALL_BIT = 1,
    VMA_RECORD_FLAG_BITS_MAX_ENUM = 2147483647,
};
pub const struct_VmaRecordSettings = extern struct {
    flags: VmaRecordFlags,
    pFilePath: [*c]const u8,
};
pub const struct_VmaAllocatorCreateInfo = extern struct {
    flags: VmaAllocatorCreateFlags = 0,
    physicalDevice: VkPhysicalDevice,
    device: VkDevice,
    preferredLargeHeapBlockSize: VkDeviceSize = 0,
    pAllocationCallbacks: [*c]const VkAllocationCallbacks = null,
    pDeviceMemoryCallbacks: [*c]const VmaDeviceMemoryCallbacks = null,
    frameInUseCount: u32 = 0,
    pHeapSizeLimit: [*c]const VkDeviceSize = null,
    pVulkanFunctions: [*c]const VmaVulkanFunctions = null,
    pRecordSettings: [*c]const VmaRecordSettings = null,
    instance: VkInstance,
    vulkanApiVersion: u32 = 0,
};
pub extern fn vmaCreateAllocator(pCreateInfo: [*c]const VmaAllocatorCreateInfo, pAllocator: [*c]VmaAllocator) VkResult;
pub extern fn vmaDestroyAllocator(allocator: VmaAllocator) void;
pub extern fn vmaGetPhysicalDeviceProperties(allocator: VmaAllocator, ppPhysicalDeviceProperties: [*c]([*c]const VkPhysicalDeviceProperties)) void;
pub extern fn vmaGetMemoryProperties(allocator: VmaAllocator, ppPhysicalDeviceMemoryProperties: [*c]([*c]const VkPhysicalDeviceMemoryProperties)) void;
pub extern fn vmaGetMemoryTypeProperties(allocator: VmaAllocator, memoryTypeIndex: u32, pFlags: [*c]VkMemoryPropertyFlags) void;
pub extern fn vmaSetCurrentFrameIndex(allocator: VmaAllocator, frameIndex: u32) void;
pub const struct_VmaStatInfo = extern struct {
    blockCount: u32,
    allocationCount: u32,
    unusedRangeCount: u32,
    usedBytes: VkDeviceSize,
    unusedBytes: VkDeviceSize,
    allocationSizeMin: VkDeviceSize,
    allocationSizeAvg: VkDeviceSize,
    allocationSizeMax: VkDeviceSize,
    unusedRangeSizeMin: VkDeviceSize,
    unusedRangeSizeAvg: VkDeviceSize,
    unusedRangeSizeMax: VkDeviceSize,
};
pub const struct_VmaStats = extern struct {
    memoryType: [32]VmaStatInfo,
    memoryHeap: [16]VmaStatInfo,
    total: VmaStatInfo,
};
pub extern fn vmaCalculateStats(allocator: VmaAllocator, pStats: [*c]VmaStats) void;
pub const struct_VmaBudget = extern struct {
    blockBytes: VkDeviceSize,
    allocationBytes: VkDeviceSize,
    usage: VkDeviceSize,
    budget: VkDeviceSize,
};
pub extern fn vmaGetBudget(allocator: VmaAllocator, pBudget: [*c]VmaBudget) void;
pub extern fn vmaBuildStatsString(allocator: VmaAllocator, ppStatsString: [*c]([*c]u8), detailedMap: VkBool32) void;
pub extern fn vmaFreeStatsString(allocator: VmaAllocator, pStatsString: [*c]u8) void;
pub const struct_VmaPool_T = opaque {};
pub const enum_VmaMemoryUsage = extern enum {
    VMA_MEMORY_USAGE_UNKNOWN = 0,
    VMA_MEMORY_USAGE_GPU_ONLY = 1,
    VMA_MEMORY_USAGE_CPU_ONLY = 2,
    VMA_MEMORY_USAGE_CPU_TO_GPU = 3,
    VMA_MEMORY_USAGE_GPU_TO_CPU = 4,
    VMA_MEMORY_USAGE_CPU_COPY = 5,
    VMA_MEMORY_USAGE_GPU_LAZILY_ALLOCATED = 6,
};
pub const enum_VmaAllocationCreateFlagBits = extern enum {
    VMA_ALLOCATION_CREATE_DEDICATED_MEMORY_BIT = 1,
    VMA_ALLOCATION_CREATE_NEVER_ALLOCATE_BIT = 2,
    VMA_ALLOCATION_CREATE_MAPPED_BIT = 4,
    VMA_ALLOCATION_CREATE_CAN_BECOME_LOST_BIT = 8,
    VMA_ALLOCATION_CREATE_CAN_MAKE_OTHER_LOST_BIT = 16,
    VMA_ALLOCATION_CREATE_USER_DATA_COPY_STRING_BIT = 32,
    VMA_ALLOCATION_CREATE_UPPER_ADDRESS_BIT = 64,
    VMA_ALLOCATION_CREATE_DONT_BIND_BIT = 128,
    VMA_ALLOCATION_CREATE_WITHIN_BUDGET_BIT = 256,
    VMA_ALLOCATION_CREATE_STRATEGY_BEST_FIT_BIT = 65536,
    VMA_ALLOCATION_CREATE_STRATEGY_WORST_FIT_BIT = 131072,
    VMA_ALLOCATION_CREATE_STRATEGY_FIRST_FIT_BIT = 262144,
    VMA_ALLOCATION_CREATE_STRATEGY_MIN_MEMORY_BIT = 65536,
    VMA_ALLOCATION_CREATE_STRATEGY_MIN_TIME_BIT = 262144,
    VMA_ALLOCATION_CREATE_STRATEGY_MIN_FRAGMENTATION_BIT = 131072,
    VMA_ALLOCATION_CREATE_STRATEGY_MASK = 458752,
    VMA_ALLOCATION_CREATE_FLAG_BITS_MAX_ENUM = 2147483647,
};
pub const struct_VmaAllocationCreateInfo = extern struct {
    flags: VmaAllocationCreateFlags = 0,
    usage: VmaMemoryUsage,
    requiredFlags: VkMemoryPropertyFlags = 0,
    preferredFlags: VkMemoryPropertyFlags = 0,
    memoryTypeBits: u32 = 0,
    pool: VmaPool = null,
    pUserData: ?*c_void = null,
};
pub extern fn vmaFindMemoryTypeIndex(allocator: VmaAllocator, memoryTypeBits: u32, pAllocationCreateInfo: [*c]const VmaAllocationCreateInfo, pMemoryTypeIndex: [*c]u32) VkResult;
pub extern fn vmaFindMemoryTypeIndexForBufferInfo(allocator: VmaAllocator, pBufferCreateInfo: [*c]const VkBufferCreateInfo, pAllocationCreateInfo: [*c]const VmaAllocationCreateInfo, pMemoryTypeIndex: [*c]u32) VkResult;
pub extern fn vmaFindMemoryTypeIndexForImageInfo(allocator: VmaAllocator, pImageCreateInfo: [*c]const VkImageCreateInfo, pAllocationCreateInfo: [*c]const VmaAllocationCreateInfo, pMemoryTypeIndex: [*c]u32) VkResult;
pub const enum_VmaPoolCreateFlagBits = extern enum {
    VMA_POOL_CREATE_IGNORE_BUFFER_IMAGE_GRANULARITY_BIT = 2,
    VMA_POOL_CREATE_LINEAR_ALGORITHM_BIT = 4,
    VMA_POOL_CREATE_BUDDY_ALGORITHM_BIT = 8,
    VMA_POOL_CREATE_ALGORITHM_MASK = 12,
    VMA_POOL_CREATE_FLAG_BITS_MAX_ENUM = 2147483647,
};
pub const struct_VmaPoolCreateInfo = extern struct {
    memoryTypeIndex: u32,
    flags: VmaPoolCreateFlags,
    blockSize: VkDeviceSize,
    minBlockCount: usize,
    maxBlockCount: usize,
    frameInUseCount: u32,
};
pub const struct_VmaPoolStats = extern struct {
    size: VkDeviceSize,
    unusedSize: VkDeviceSize,
    allocationCount: usize,
    unusedRangeCount: usize,
    unusedRangeSizeMax: VkDeviceSize,
    blockCount: usize,
};
pub extern fn vmaCreatePool(allocator: VmaAllocator, pCreateInfo: [*c]const VmaPoolCreateInfo, pPool: [*c]VmaPool) VkResult;
pub extern fn vmaDestroyPool(allocator: VmaAllocator, pool: VmaPool) void;
pub extern fn vmaGetPoolStats(allocator: VmaAllocator, pool: VmaPool, pPoolStats: [*c]VmaPoolStats) void;
pub extern fn vmaMakePoolAllocationsLost(allocator: VmaAllocator, pool: VmaPool, pLostAllocationCount: [*c]usize) void;
pub extern fn vmaCheckPoolCorruption(allocator: VmaAllocator, pool: VmaPool) VkResult;
pub extern fn vmaGetPoolName(allocator: VmaAllocator, pool: VmaPool, ppName: [*c]([*c]const u8)) void;
pub extern fn vmaSetPoolName(allocator: VmaAllocator, pool: VmaPool, pName: [*c]const u8) void;
pub const struct_VmaAllocation_T = opaque {};
pub const struct_VmaAllocationInfo = extern struct {
    memoryType: u32,
    deviceMemory: VkDeviceMemory,
    offset: VkDeviceSize,
    size: VkDeviceSize,
    pMappedData: ?*c_void,
    pUserData: ?*c_void,
};
pub extern fn vmaAllocateMemory(allocator: VmaAllocator, pVkMemoryRequirements: [*c]const VkMemoryRequirements, pCreateInfo: [*c]const VmaAllocationCreateInfo, pAllocation: [*c]VmaAllocation, pAllocationInfo: [*c]VmaAllocationInfo) VkResult;
pub extern fn vmaAllocateMemoryPages(allocator: VmaAllocator, pVkMemoryRequirements: [*c]const VkMemoryRequirements, pCreateInfo: [*c]const VmaAllocationCreateInfo, allocationCount: usize, pAllocations: [*c]VmaAllocation, pAllocationInfo: [*c]VmaAllocationInfo) VkResult;
pub extern fn vmaAllocateMemoryForBuffer(allocator: VmaAllocator, buffer: VkBuffer, pCreateInfo: [*c]const VmaAllocationCreateInfo, pAllocation: [*c]VmaAllocation, pAllocationInfo: [*c]VmaAllocationInfo) VkResult;
pub extern fn vmaAllocateMemoryForImage(allocator: VmaAllocator, image: VkImage, pCreateInfo: [*c]const VmaAllocationCreateInfo, pAllocation: [*c]VmaAllocation, pAllocationInfo: [*c]VmaAllocationInfo) VkResult;
pub extern fn vmaFreeMemory(allocator: VmaAllocator, allocation: VmaAllocation) void;
pub extern fn vmaFreeMemoryPages(allocator: VmaAllocator, allocationCount: usize, pAllocations: [*c]VmaAllocation) void;
pub extern fn vmaResizeAllocation(allocator: VmaAllocator, allocation: VmaAllocation, newSize: VkDeviceSize) VkResult;
pub extern fn vmaGetAllocationInfo(allocator: VmaAllocator, allocation: VmaAllocation, pAllocationInfo: [*c]VmaAllocationInfo) void;
pub extern fn vmaTouchAllocation(allocator: VmaAllocator, allocation: VmaAllocation) VkBool32;
pub extern fn vmaSetAllocationUserData(allocator: VmaAllocator, allocation: VmaAllocation, pUserData: ?*c_void) void;
pub extern fn vmaCreateLostAllocation(allocator: VmaAllocator, pAllocation: [*c]VmaAllocation) void;
pub extern fn vmaMapMemory(allocator: VmaAllocator, allocation: VmaAllocation, ppData: [*c](?*c_void)) VkResult;
pub extern fn vmaUnmapMemory(allocator: VmaAllocator, allocation: VmaAllocation) void;
pub extern fn vmaFlushAllocation(allocator: VmaAllocator, allocation: VmaAllocation, offset: VkDeviceSize, size: VkDeviceSize) void;
pub extern fn vmaInvalidateAllocation(allocator: VmaAllocator, allocation: VmaAllocation, offset: VkDeviceSize, size: VkDeviceSize) void;
pub extern fn vmaCheckCorruption(allocator: VmaAllocator, memoryTypeBits: u32) VkResult;
pub const struct_VmaDefragmentationContext_T = opaque {};
pub const enum_VmaDefragmentationFlagBits = extern enum {
    VMA_DEFRAGMENTATION_FLAG_BITS_MAX_ENUM = 2147483647,
};
pub const struct_VmaDefragmentationInfo2 = extern struct {
    flags: VmaDefragmentationFlags,
    allocationCount: u32,
    pAllocations: [*c]VmaAllocation,
    pAllocationsChanged: [*c]VkBool32,
    poolCount: u32,
    pPools: [*c]VmaPool,
    maxCpuBytesToMove: VkDeviceSize,
    maxCpuAllocationsToMove: u32,
    maxGpuBytesToMove: VkDeviceSize,
    maxGpuAllocationsToMove: u32,
    commandBuffer: VkCommandBuffer,
};
pub const struct_VmaDefragmentationInfo = extern struct {
    maxBytesToMove: VkDeviceSize,
    maxAllocationsToMove: u32,
};
pub const struct_VmaDefragmentationStats = extern struct {
    bytesMoved: VkDeviceSize,
    bytesFreed: VkDeviceSize,
    allocationsMoved: u32,
    deviceMemoryBlocksFreed: u32,
};
pub extern fn vmaDefragmentationBegin(allocator: VmaAllocator, pInfo: [*c]const VmaDefragmentationInfo2, pStats: [*c]VmaDefragmentationStats, pContext: [*c]VmaDefragmentationContext) VkResult;
pub extern fn vmaDefragmentationEnd(allocator: VmaAllocator, context: VmaDefragmentationContext) VkResult;
pub extern fn vmaDefragment(allocator: VmaAllocator, pAllocations: [*c]VmaAllocation, allocationCount: usize, pAllocationsChanged: [*c]VkBool32, pDefragmentationInfo: [*c]const VmaDefragmentationInfo, pDefragmentationStats: [*c]VmaDefragmentationStats) VkResult;
pub extern fn vmaBindBufferMemory(allocator: VmaAllocator, allocation: VmaAllocation, buffer: VkBuffer) VkResult;
pub extern fn vmaBindBufferMemory2(allocator: VmaAllocator, allocation: VmaAllocation, allocationLocalOffset: VkDeviceSize, buffer: VkBuffer, pNext: ?*const c_void) VkResult;
pub extern fn vmaBindImageMemory(allocator: VmaAllocator, allocation: VmaAllocation, image: VkImage) VkResult;
pub extern fn vmaBindImageMemory2(allocator: VmaAllocator, allocation: VmaAllocation, allocationLocalOffset: VkDeviceSize, image: VkImage, pNext: ?*const c_void) VkResult;
pub extern fn vmaCreateBuffer(allocator: VmaAllocator, pBufferCreateInfo: [*c]const VkBufferCreateInfo, pAllocationCreateInfo: [*c]const VmaAllocationCreateInfo, pBuffer: [*c]VkBuffer, pAllocation: [*c]VmaAllocation, pAllocationInfo: [*c]VmaAllocationInfo) VkResult;
pub extern fn vmaDestroyBuffer(allocator: VmaAllocator, buffer: VkBuffer, allocation: VmaAllocation) void;
pub extern fn vmaCreateImage(allocator: VmaAllocator, pImageCreateInfo: [*c]const VkImageCreateInfo, pAllocationCreateInfo: [*c]const VmaAllocationCreateInfo, pImage: [*c]VkImage, pAllocation: [*c]VmaAllocation, pAllocationInfo: [*c]VmaAllocationInfo) VkResult;
pub extern fn vmaDestroyImage(allocator: VmaAllocator, image: VkImage, allocation: VmaAllocation) void;
