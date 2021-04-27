const cimport = @import("cimport");
const vulkan = cimport.vulkan;

pub fn checkSuccess(result: vulkan.VkResult) !void {
    switch (result) {
        vulkan.VK_SUCCESS => {},
        else => return error.VkCheckFailed,
    }
}
