const std = @import("std");
const mem = std.mem;
const Allocator = std.mem.Allocator;

pub fn resolveSinglePath(allocator: *Allocator, path: []const u8) ![]u8 {
    const real_path = &[_][]const u8{path};
    return std.fs.path.resolve(allocator, real_path);
}

pub const PoolIdx = *opaque {};
const UNIQUE_SLOT_SHIFT = 16;
const MAX_POOL_SIZE = @shlExact(1, UNIQUE_SLOT_SHIFT);
const UNIQUE_MASK = MAX_POOL_SIZE - 1;

pub fn PoolMap(comptime V: type) type {
    return struct {
        const Self = @This();
        allocator: *Allocator,
        isInit: bool,
        freeQueue: []usize,
        queueTop: usize,
        size: usize,
        uniqueCounter: usize,
        data: []IV,

        const IV = struct {
            id: usize,
            value: V,
        };

        pub fn baseType(self: Self) type {
            return @TypeOf(V);
        }

        pub fn init(allocator: *Allocator, size: u16) Self {
            return Self{
                .allocator = allocator,
                .isInit = false,
                .freeQueue = &[_]usize{},
                .queueTop = 0,
                .size = @intCast(usize, size),
                .uniqueCounter = 5391,
                .data = &[_]IV{},
            };
        }

        pub fn putSingle(self: *Self, val: V) !PoolIdx {
            if (!self.isInit) try internalInit(self);
            if (self.queueTop == 0) return error.NoSpaceAvailable;
            self.queueTop -= 1;
            var slot = self.freeQueue[self.queueTop];
            var pool_idx = @shlExact(self.uniqueCounter, UNIQUE_SLOT_SHIFT) | slot;
            self.data[slot] = IV{
                .id = pool_idx,
                .value = val,
            };
            self.uniqueCounter += 1;
            return @intToPtr(PoolIdx, pool_idx);
        }

        pub fn putMultiple(self: *Self, allocator: *Allocator, values: []V) ![]PoolIdx {
            var id_list = try std.ArrayList(V).init(allocator);
            errdefer id_list.free();
            for (values) |v| {
                try id_list.append(try putSingle(self, v));
            }
            return id_list.toOwnedSlice();
        }

        pub fn get(self: *Self, idx: PoolIdx) !V {
            const slot = try decodeIdx(idx, self.size);
            const id = @ptrToInt(idx);
            if (id != self.data[slot].id) return error.DanglingPoolIdx;
            return self.data[slot].value;
        }

        pub fn release(self: *Self, idx: PoolIdx) !void {
            const slot = try decodeIdx(idx, self.size);
            const id = @ptrToInt(idx);
            if (id != self.data[slot].id) return error.DoubleFreeIdx;
            self.freeQueue[self.queueTop] = slot;
            self.data[slot].id = 0;
            self.queueTop += 1;
        }

        fn internalInit(self: *Self) !void {
            self.freeQueue = try self.allocator.alloc(usize, self.size);
            self.data = try self.allocator.alloc(IV, self.size + 1);
            self.isInit = true;
            var i = self.freeQueue.len - 1;
            var queue_top: usize = 0;
            while (i >= 1) : (i -= 1) {
                self.freeQueue[queue_top] = i;
                queue_top += 1;
            }
            self.queueTop = queue_top;
            mem.secureZero(IV, self.data);
        }

        fn decodeIdx(idx: PoolIdx, num_slots: usize) !usize {
            const slot = @ptrToInt(idx) & UNIQUE_MASK;
            if (slot == 0 or slot > num_slots) return error.InvalidPoolIdx;
            return slot;
        }
    };
}

pub fn RingBufferSafe(comptime T: type) type {
    return struct {
        const Self = @This();
        allocator: *Allocator,
        read_idx: usize,
        one_past_write_idx: usize,
        num_filled_slots: usize,
        ring_slice: []T,
        array_list: std.ArrayList(T),

        const Iterator = struct {
            read_idx: usize,
            one_past_write_idx: usize,
            slots_to_read: usize,
            ring_slice: []T,

            const IterSelf = @This();

            pub fn next(self: *IterSelf) ?T {
                if (self.slots_to_read == 0) return null;
                const idx = self.read_idx;
                self.read_idx += 1;
                self.slots_to_read -= 1;
                if (self.read_idx == self.ring_slice.len) self.read_idx = 0;
                return self.ring_slice[idx];
            }

            pub fn nextAsPtr(self: *IterSelf) ?*T {
                if (self.slots_to_read == 0) return null;
                const idx = self.read_idx;
                self.read_idx += 1;
                self.slots_to_read -= 1;
                if (self.read_idx == self.ring_slice.len) self.read_idx = 0;
                return &self.ring_slice[idx];
            }
        };

        pub fn iterator(self: *Self) Iterator {
            return Iterator{
                .read_idx = self.read_idx,
                .one_past_write_idx = self.one_past_write_idx,
                .slots_to_read = self.num_filled_slots,
                .ring_slice = self.ring_slice[0..],
            };
        }

        pub fn initCapacity(allocator: *Allocator, size: usize) !Self {
            var buf = try allocator.alloc(T, size);
            return Self{
                .allocator = allocator,
                .read_idx = 0,
                .one_past_write_idx = 0,
                .num_filled_slots = 0,
                .ring_slice = buf,
                .array_list = try std.ArrayList(T).initCapacity(allocator, size),
            };
        }

        pub fn reset(self: *Self) void {
            self.read_idx = 0;
            self.one_past_write_idx = 0;
            self.num_filled_slots = 0;
        }

        pub fn append(self: *Self, value: T) !void {
            if (self.num_filled_slots == self.ring_slice.len) return error.RingIsFull;
            self.ring_slice[self.one_past_write_idx] = value;
            self.one_past_write_idx += 1;
            if (self.one_past_write_idx == self.ring_slice.len) {
                self.one_past_write_idx = 0;
            }
            self.num_filled_slots += 1;
        }

        pub fn appendSlice(self: *Self, values: []T) !void {
            for (values) |v| {
                try append(self, v);
            }
        }

        pub fn popItem(self: *Self) !T {
            if (self.num_filled_slots == 0) return error.RingIsEmpty;
            const ret = self.ring_slice[self.read_idx];
            self.read_idx += 1;
            self.num_filled_slots -= 1;
            if (self.read_idx == self.ring_slice.len) self.read_idx = 0;
            return ret;
        }

        pub fn removeCount(self: *Self, n: usize) !void {
            if (n > self.num_filled_slots) return error.RemoveCountTooLarge;
            self.num_filled_slots -= n;
            self.read_idx += n;
            if (self.read_idx >= self.ring_slice.len) {
                const new_read_idx = self.read_idx % self.ring_slice.len;
                if (new_read_idx > self.one_past_write_idx) unreachable;
                self.read_idx = new_read_idx;
            }
            return;
        }

        pub fn rawSlice(self: *Self) []const T {
            return self.ring_slice[0..];
        }

        pub fn toPackedSlice(self: *Self) []T {
            self.array_list.resize(0) catch unreachable;
            if (self.read_idx < self.one_past_write_idx) {
                return self.ring_slice[self.read_idx..self.one_past_write_idx];
            } else {
                self.array_list.appendSlice(self.ring_slice[self.read_idx..]) catch unreachable;
                self.array_list.appendSlice(self.ring_slice[0..self.one_past_write_idx]) catch unreachable;
            }
            return self.array_list.toSlice();
        }

        pub fn copyIntoSlice(self: *Self, dest: []T) ![]T {
            if (self.num_filled_slots > dest.len) return error.TargetTooSmall;
            if (self.read_idx < self.one_past_write_idx) {
                std.mem.copy(T, dest, self.ring_slice[self.read_idx..self.one_past_write_idx]);
                return dest[0..self.num_filled_slots];
            } else {
                const first = self.ring_slice[self.read_idx..];
                const offset = first.len;
                std.mem.copy(T, dest, first);
                const second = self.ring_slice[0..self.one_past_write_idx];
                std.mem.copy(T, dest[offset..], second);
                return dest[0..(offset + second.len)];
            }
        }
    };
}
