const std = @import("std");
const Allocator = std.mem.Allocator;
const math = @import("math.zig");
const pdbg = std.debug.warn;
const powerup = @import("powerups.zig");

const BrickType = enum {
    Empty,
    Solid,
    Breakable,
};

pub const BrickStatus = enum(u32) {
    Destroyed = 0,
    Normal = 1,
};

pub const BrickWorldState = struct {
    color: math.Vec4f,
    position: math.Vec2f,
    _padding: [2]f32 = [_]f32{ 0, 0 }, //this already exists, this struct is align(8)
};

pub const GameLevel = struct {
    num_bricks: usize,
    width_in_bricks: usize,
    height_in_bricks: usize,
    half_extents: math.Vec2f,
    world_states: []BrickWorldState,
    types: []BrickType,
    statuses: []BrickStatus,
};

const BoxCollision = struct {
    penetration_vec: math.Vec2f,
    side: BoxSide,
};

const BrickCollision = struct {
    base_box: BoxCollision,
    index: usize,
};

const PowerupCollision = struct {
    index: usize,
};

const BoxSide = enum {
    Top,
    Bottom,
    Left,
    Right,
};

inline fn checkBoxBoxCollision(pos_one: math.Vec2f, size_one: math.Vec2f, pos_two: math.Vec2f, size_two: math.Vec2f) bool {
    const collide_x = pos_one[0] + size_one[0] >= pos_two[0] and
        pos_two[0] + size_two[0] >= pos_one[0];
    const collide_y = pos_one[1] + size_one[1] >= pos_two[1] and
        pos_two[1] + size_two[1] >= pos_one[1];
    return collide_x and collide_y;
}

fn maybeGetBallBoxCollision(ball_pos: math.Vec2f, radius: f32, box_pos: math.Vec2f, box_half_extents: math.Vec2f) ?BoxCollision {
    const axes = [_]math.Vec2f{
        .{ 0.0, 1.0 }, //up
        .{ 0.0, -1.0 }, //down
        .{ -1.0, 0.0 }, //left
        .{ 1.0, 0.0 }, //right
    };
    const sides = [_]BoxSide{
        .Top,
        .Bottom,
        .Left,
        .Right,
    };

    const center_rela_vec = ball_pos - box_pos;
    const clamped_extents: math.Vec2f = [_]f32{
        std.math.clamp(center_rela_vec[0], -box_half_extents[0], box_half_extents[0]),
        std.math.clamp(center_rela_vec[1], -box_half_extents[1], box_half_extents[1]),
    };
    const collis_pos = box_pos + clamped_extents;
    const collis_vec = collis_pos - ball_pos;
    const distance = math.magVec2f(collis_vec);
    const collis_dir = math.normVec2f(collis_vec);
    if (distance < radius) {
        var max_angle: f32 = 0.0;
        var best_side: ?BoxSide = null;
        for (axes) |a, i| {
            const dot_prdct = math.dotVec2f(collis_dir, a);
            if (dot_prdct >= max_angle) {
                max_angle = dot_prdct;
                best_side = sides[i];
            }
        }
        return BoxCollision{
            .penetration_vec = collis_vec,
            .side = if (best_side) |s| s else .Bottom,
        };
    } else return null;
}

const PaddleCollision = struct {
    base_box: BoxCollision,
    percent_from_center: f32,
};

pub fn maybeGetBallPaddleCollision(ball_pos: math.Vec2f, radius: f32, paddle_pos: math.Vec2f, paddle_size: math.Vec2f) ?PaddleCollision {
    const paddle_half_extents: math.Vec2f = [_]f32{ paddle_size[0] / 2, paddle_size[1] / 2 };
    if (maybeGetBallBoxCollision(ball_pos, radius, paddle_pos, paddle_half_extents)) |collis| {
        const paddle_center_x = paddle_pos[0];
        const distance = ball_pos[0] - paddle_center_x;
        const percentage: f32 = distance / paddle_half_extents[0];
        return PaddleCollision{
            .base_box = collis,
            .percent_from_center = percentage,
        };
    } else return null;
}

pub fn resetLevelStatus(s: []BrickStatus) void {
    @memset(@ptrCast([*]u8, s.ptr), @enumToInt(BrickStatus.Normal), @sizeOf(BrickStatus) * s.len);
}

pub fn maybeGetPaddlePowerupCollision(paddle_pos: math.Vec2f, paddle_size: math.Vec2f, ps: powerup.Powerups, powerup_size: math.Vec2f) ?PowerupCollision {
    const extents = [_]f32{ 30, 10 };
    for (ps.toSlice()) |p, i| {
        if (checkBoxBoxCollision(paddle_pos, paddle_size, p.pos, powerup_size)) {
            return PowerupCollision{ .index = i };
        }
    }
    return null;
}

//NOTE: 0,0 is top left not bottom left
pub fn maybeGetBallBrickCollision(ball_pos: math.Vec2f, radius: f32, game_level: GameLevel) ?BrickCollision {
    const bot_row_offset = (game_level.height_in_bricks - 1) * game_level.width_in_bricks;
    const ball_pos_y = ball_pos[1];
    const ball_pos_x = ball_pos[0];
    const ball_top = ball_pos_y - radius;
    const ball_bot = ball_pos_y + radius;
    const brick_extent_x = game_level.half_extents[0];
    const brick_extent_y = game_level.half_extents[1];

    //early out if we're below the bottom row
    if (ball_top > game_level.world_states[bot_row_offset].position[1] + brick_extent_y) {
        return null;
    }
    var temp_bytes: [@sizeOf(usize) * 64]u8 = undefined;
    var allocator = &std.heap.FixedBufferAllocator.init(temp_bytes[0..]).allocator;
    var row_list = std.ArrayList(usize).initCapacity(allocator, 32) catch unreachable;
    {
        var i: usize = 0;
        while (i < game_level.height_in_bricks) : (i += 1) {
            const offset = i * game_level.width_in_bricks;
            const brick_top = game_level.world_states[offset].position[1] - brick_extent_y;
            const brick_bot = game_level.world_states[offset].position[1] + brick_extent_y;
            if (ball_top <= brick_bot and ball_bot >= brick_top or ball_top > brick_top and ball_bot < brick_bot) {
                row_list.append(i) catch unreachable;
            }
        }
    }
    const brick_collision: ?BrickCollision = blk: for (row_list.toSlice()) |r| {
        var c: usize = 0;
        while (c < game_level.width_in_bricks) : (c += 1) {
            const offset = r * game_level.width_in_bricks + c;
            if (game_level.types[offset] == .Empty or game_level.statuses[offset] == .Destroyed) continue;
            const brick_pos = game_level.world_states[offset].position;
            if (maybeGetBallBoxCollision(ball_pos, radius, game_level.world_states[offset].position, game_level.half_extents)) |collis| break :blk BrickCollision{ .index = offset, .base_box = collis };
        }
    } else null;

    return brick_collision;
}

pub fn createLevel(allocator: *Allocator, brick_size_x: f32, brick_size_y: f32, tiles: [][]u8) !GameLevel {
    const map_height = tiles.len;
    const map_width = tiles[0].len;
    if (map_height < 1 or map_width < 1) {
        return error.InvalidMap;
    }
    var world_states_list = try std.ArrayList(BrickWorldState).initCapacity(allocator, tiles.len * 12);
    errdefer world_states_list.deinit();
    var btypes = try std.ArrayList(BrickType).initCapacity(allocator, tiles.len * 12);
    errdefer btypes.deinit();
    for (tiles) |row, y| {
        if (row.len != map_width) return error.InvalidMap;
        for (row) |i, x| {
            const pos: math.Vec2f = [_]f32{
                brick_size_x * @intToFloat(f32, x) + brick_size_x / 2,
                brick_size_y * @intToFloat(f32, y) + brick_size_y / 2,
            };
            switch (i) {
                0 => {
                    try world_states_list.append(.{
                        .position = pos,
                        .color = [_]f32{ 0.0, 0.0, 0.0, 0.0 },
                    });
                    try btypes.append(.Empty);
                },
                1 => {
                    try world_states_list.append(.{
                        .position = pos,
                        .color = [_]f32{ 0.8, 0.8, 0.7, 1.0 },
                    });
                    try btypes.append(.Solid);
                },
                2 => {
                    try world_states_list.append(.{
                        .position = pos,
                        .color = [_]f32{ 0.2, 0.5, 1.0, 1.0 },
                    });
                    try btypes.append(.Breakable);
                },
                3 => {
                    try world_states_list.append(.{
                        .position = pos,
                        .color = [_]f32{ 0.0, 0.7, 0.0, 1.0 },
                    });
                    try btypes.append(.Breakable);
                },
                4 => {
                    try world_states_list.append(.{
                        .position = pos,
                        .color = [_]f32{ 0.8, 0.8, 0.4, 1.0 },
                    });
                    try btypes.append(.Breakable);
                },
                5 => {
                    try world_states_list.append(.{
                        .position = pos,
                        .color = [_]f32{ 1.0, 0.5, 0.0, 1.0 },
                    });
                    try btypes.append(.Breakable);
                },
                else => {
                    try world_states_list.append(.{
                        .position = pos,
                        .color = [_]f32{ 1.0, 1.0, 1.0, 1.0 },
                    });
                    try btypes.append(.Breakable);
                },
            }
        }
    }

    var status_list = try allocator.alloc(BrickStatus, map_width * map_height);
    resetLevelStatus(status_list);
    return GameLevel{
        .num_bricks = map_width * map_height,
        .width_in_bricks = map_width,
        .height_in_bricks = map_height,
        .types = btypes.toOwnedSlice(),
        .half_extents = [_]f32{ brick_size_x / 2.0, brick_size_y / 2.0 },
        .world_states = world_states_list.toOwnedSlice(),
        .statuses = status_list,
    };
}
