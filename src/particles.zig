const std = @import("std");
const math = @import("math.zig");
const Allocator = std.mem.Allocator;

usingnamespace math;

pub const ParticleWorldState = struct {
    color: Vec4f,
    position: Vec2fA16,
};

pub const Particles = struct {
    const ParticleWorldStateList = std.ArrayList(ParticleWorldState);
    const VeloList = std.ArrayList(Vec2f);
    const LifeList = std.ArrayList(f32);
    const Self = @This();

    allocator: *Allocator,
    life_timers: LifeList,
    world_states: ParticleWorldStateList,
    velocities: VeloList,
    max_particles: usize,

    pub fn init(allocator: *Allocator, size: usize) !Self {
        return Self{
            .allocator = allocator,
            .max_particles = size,
            .world_states = try ParticleWorldStateList.initCapacity(allocator, size),
            .velocities = try VeloList.initCapacity(allocator, size),
            .life_timers = try LifeList.initCapacity(allocator, size),
        };
    }

    pub fn update(self: *Self, real_dt: f64) void {
        const dt = @floatCast(f32, real_dt);
        var life_slice = self.life_timers.items;
        var velo_slice = self.velocities.items;
        var state_slice = self.world_states.items;
        var len = life_slice.len;
        var i: usize = 0;
        while (i < len) : (i += 1) {
            life_slice[i] -= dt;
            if (life_slice[i] < 0.0) {
                _ = self.life_timers.swapRemove(i);
                _ = self.velocities.swapRemove(i);
                _ = self.world_states.swapRemove(i);
                len -= 1;
            } else {
                state_slice[i].color[3] -= dt * 2.5;
                state_slice[i].position.value += @splat(2, dt) * velo_slice[i];
            }
        }
    }

    pub fn clear(self: *Self) void {
        self.world_states.items.len = 0;
        self.velocities.items.len = 0;
        self.life_timers.items.len = 0;
    }

    pub fn getWorldStatePackedSlice(self: *Self) []ParticleWorldState {
        return self.world_states.items;
    }

    pub fn queueNewParticle(self: *Self, rgen: *std.rand.Random, base_pos: Vec2f, velocity: Vec2f) !void {
        if (self.world_states.items.len == self.max_particles) return error.TooManyParticles;
        const random_x = (rgen.float(f32) - 0.5) * 10.0; //-5 to 5
        const random_y = (rgen.float(f32) - 0.5) * 10.0; //-5 to 5
        const color = 0.5 + (rgen.float(f32) / 2.0); //0.5 to 1.0
        const pos = base_pos + @as(Vec2f, [_]f32{ random_x, random_y });
        const velo = velocity * @splat(2, @floatCast(f32, 0.1));
        self.world_states.append(.{
            .position = .{ .value = .{ pos[0], pos[1] } },
            .color = [_]f32{ color, color, color, 1.0 },
        }) catch unreachable;

        self.velocities.append([_]f32{ velo[0], velo[1] }) catch unreachable;
        self.life_timers.append(1.0) catch unreachable;
    }
};
