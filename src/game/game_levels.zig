pub const StandardTiles = &[_][]u8{
    &[_]u8{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 },
    &[_]u8{ 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5 },
    &[_]u8{ 4, 4, 4, 4, 4, 0, 0, 0, 0, 0, 4, 4, 4, 4, 4 },
    &[_]u8{ 4, 1, 4, 1, 4, 0, 0, 1, 0, 0, 4, 1, 4, 1, 4 },
    &[_]u8{ 3, 3, 3, 3, 3, 0, 0, 0, 0, 0, 3, 3, 3, 3, 3 },
    &[_]u8{ 3, 3, 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1, 3, 3 },
    &[_]u8{ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
    &[_]u8{ 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2 },
};

pub const SmallGapsTiles = &[_][]u8{
    &[_]u8{ 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 },
    &[_]u8{ 1, 0, 5, 5, 0, 5, 5, 0, 5, 5, 0, 5, 5, 0, 1 },
    &[_]u8{ 1, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 1 },
    &[_]u8{ 1, 0, 3, 3, 0, 3, 3, 0, 3, 3, 0, 3, 3, 0, 1 },
    &[_]u8{ 1, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 3, 1 },
    &[_]u8{ 1, 0, 2, 2, 0, 2, 2, 0, 2, 2, 0, 2, 2, 0, 1 },
    &[_]u8{ 1, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 2, 1 },
    &[_]u8{ 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1, 1, 0, 1 },
};

pub const SpaceInvadersTiles = &[_][]u8{
    &[_]u8{ 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 },
    &[_]u8{ 0, 0, 2, 0, 0, 0, 0, 0, 0, 0, 2, 0, 0 },
    &[_]u8{ 0, 0, 0, 2, 0, 0, 0, 0, 0, 2, 0, 0, 0 },
    &[_]u8{ 0, 0, 0, 5, 5, 5, 5, 5, 5, 5, 0, 0, 0 },
    &[_]u8{ 0, 0, 5, 5, 0, 5, 5, 5, 0, 5, 5, 0, 0 },
    &[_]u8{ 0, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 5, 0 },
    &[_]u8{ 0, 3, 0, 1, 1, 1, 1, 1, 1, 1, 0, 3, 0 },
    &[_]u8{ 0, 3, 0, 3, 0, 0, 0, 0, 0, 3, 0, 3, 0 },
    &[_]u8{ 0, 0, 0, 0, 4, 4, 0, 4, 4, 0, 0, 0, 0 },
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
