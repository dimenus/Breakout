const std = @import("std");
const math = @import("math.zig");
const Allocator = std.mem.Allocator;

usingnamespace math;

pub const PowerupType = enum {
    Speed,
    Sticky,
    PassThrough,
    PadSizeIncrease,
    Confuse,
    Chaos,
};

pub const Powerups = struct {
    const State = struct {
        pos: Vec2f,
        mod: PowerupType,
    };
    const StateList = std.ArrayList(State);

    allocator: *Allocator,
    states: StateList,

    const Self = @This();

    pub fn init(allocator: *Allocator, size: usize) !Self {
        return Self{
            .allocator = allocator,
            .states = try StateList.initCapacity(allocator, size),
        };
    }

    pub fn update(self: *Self, velo: Vec2f, bound: f32) void {
        var len = self.states.items.len;
        var i: usize = 0;
        while (i < len) : (i += 1) {
            var pos = self.states.items[i].pos;
            pos += velo;
            if (pos[1] > bound) {
                _ = self.states.swapRemove(i);
                len -= 1;
            } else {
                self.states.items[i].pos = pos;
            }
        }
    }

    pub fn queue(self: *Self, pos: Vec2f, mod: PowerupType) void {
        self.states.append(.{ .pos = pos, .mod = mod }) catch unreachable;
    }

    pub fn toSlice(self: Self) []const State {
        return self.states.items;
    }

    pub fn clear(self: *Self) void {
        self.states.clear();
    }
};
