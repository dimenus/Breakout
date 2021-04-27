const Ball = struct {
    size: Vec2f,
    position: Vec2f,
    velocity: Vec2f,

    const Self = @This();

    pub fn update(self: Self, dt: f64) void {}
};

const PowerupType = enum {
    Speed,
    Sticky,
    PassThrough,
    PadSizeIncrease,
    Confuse,
    Chaos,
};

fn getPowerupTexID(t: PowerupType) u32 {
    switch (t) {
        .Speed => return SPEED_TEX_ID,
        .Sticky => return STICKY_TEX_ID,
        .PassThrough => return PASS_THROUGH_TEX_ID,
        .PadSizeIncrease => return INCREASE_TEX_ID,
        .Confuse => return CONFUSE_TEX_ID,
        .Chaos => return CHAOS_TEX_ID,
    }
}

const Powerups = struct {
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

    pub fn update(self: *Self, velo: Vec2f) void {
        var len = self.states.len;
        var i: usize = 0;
        while (i < len) : (i += 1) {
            var pos = self.states.items[i].pos;
            pos += velo;
            if (pos[1] > SCREEN_HEIGHT) {
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
        return self.states.toSlice();
    }

    pub fn clear(self: *Self) void {
        self.states.clear();
    }
};
