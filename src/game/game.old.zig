const std = @import("std");
const fmt = std.fmt;
const Buffer = std.Buffer;
const mem = std.mem;
const pdbg = std.debug.warn;
const Allocator = std.mem.Allocator;
const zigshared = @import("shared");
const Vec3f = zigshared.math.Vec3f;
const Vec2f = zigshared.math.Vec2f;

const utils = @import("utils.zig");

const BrickType = enum {
    Empty,
    Solid,
    Breakable,
};

const ImageType = enum {
    NotSupported,
    Jpg,
    Png,
};

const AvailTexture = struct {
    imgType: ImageType,
    path: []const u8,
};

const AvailTexHashMap = std.hash_map.StringHashMap(AvailTexture);

fn mapToImageType(basename: []const u8) ImageType {
    if (mem.endsWith(u8, basename, "JPG") or mem.endsWith(u8, basename, "jpg")) {
        return .Jpg;
    } else if (mem.endsWith(u8, basename, "PNG") or mem.endsWith(u8, basename, "png")) {
        return .Png;
    } else return .NotSupported;
}

fn getImageTypeExtLen(img_type: ImageType) usize {
    switch (img_type) {
        .Jpg => return 4,
        .Png => return 4,
        //this case should be caught in enumerateAvailTextures
        .NotSupported => unreachable,
    }
    return ret;
}
const AvailShader = struct {
    vertPath: ?[]const u8,
    fragPath: ?[]const u8,
};

const ShaderType = enum {
    NotSupported,
    Vertex,
    Fragment,
};

fn mapToShaderType(entry_no_ext: []const u8, basename: *?[]const u8) ShaderType {
    const base = entry_no_ext;
    const vert_name = "_vert";
    const frag_name = "_frag";
    if (mem.endsWith(u8, base, vert_name)) {
        const idx = mem.lastIndexOf(u8, entry_no_ext, vert_name).?;
        basename.* = entry_no_ext[0..idx];
        return .Vertex;
    } else if (mem.endsWith(u8, base, frag_name)) {
        const idx = mem.lastIndexOf(u8, entry_no_ext, frag_name).?;
        basename.* = entry_no_ext[0..idx];
        return .Fragment;
    } else {
        basename.* = null;
        return .NotSupported;
    }
}

const AvailShaderHashMap = std.hash_map.StringHashMap(AvailShader);

pub fn enumerateAvailShaders(allocator: *Allocator, dir_path: []const u8) !AvailShaderHashMap {
    var walker = try std.fs.walkPath(allocator, dir_path);
    defer walker.deinit();

    var hash_map = AvailShaderHashMap.init(allocator);
    errdefer {
        var it = hash_map.iterator();
        while (it.next()) |entry| {
            if (entry.value.vertPath) |vert| allocator.free(vert);
            if (entry.value.fragPath) |frag| allocator.free(frag);
        }
        hash_map.deinit();
    }

    const ext = ".spv";
    while (try walker.next()) |entry| {
        if (!mem.endsWith(u8, entry.basename, ext)) continue;
        const without_ext_len = entry.basename.len - ext.len;
        const entry_no_ext = entry.basename[0..without_ext_len];
        var basename: ?[]const u8 = null;
        const shader_type = mapToShaderType(entry_no_ext, &basename);
        if (shader_type == .NotSupported) continue;
        var path_buf = try std.Buffer.init(allocator, entry.path);
        errdefer path_buf.deinit();
        var path_slice = path_buf.toOwnedSlice();
        var base_buf = try std.Buffer.init(allocator, basename.?);
        errdefer base_buf.deinit();
        var base_slice = base_buf.toOwnedSlice();
        var item = try hash_map.getOrPut(base_slice);
        switch (shader_type) {
            .Vertex => {
                item.kv.value.vertPath = path_slice;
            },
            .Fragment => {
                item.kv.value.fragPath = path_slice;
            },
            .NotSupported => unreachable,
        }
    }
    return hash_map;
}

pub fn enumerateAvailTextures(allocator: *Allocator, dir_path: []const u8) !AvailTexHashMap {
    var walker = try std.fs.walkPath(allocator, dir_path);
    defer walker.deinit();

    var hash_map = AvailTexHashMap.init(allocator);
    errdefer {
        var it = hash_map.iterator();
        while (it.next()) |entry| {
            allocator.free(entry.value.path);
        }
        hash_map.deinit();
    }

    while (try walker.next()) |entry| {
        const img_type = mapToImageType(entry.basename);
        if (img_type == .NotSupported) {
            continue;
        }
        var path_buf = try std.Buffer.init(allocator, entry.path);
        errdefer path_buf.deinit();
        var base_buf = try std.Buffer.init(allocator, entry.basename);
        errdefer base_buf.deinit();
        const base_slice = base_buf.toOwnedSlice();
        const base_name_len = base_slice.len - getImageTypeExtLen(img_type);
        try hash_map.putNoClobber(base_slice[0..base_name_len], AvailTexture{
            .imgType = img_type,
            .path = path_buf.toOwnedSlice(),
        });
    }
    return hash_map;
}

const Level = struct {
    widthInBricks: u32,
    heightInBricks: u32,
    brickSize: Vec2f,
    brickPositions: []Vec2f,
    brickColors: []Vec3f,
    brickTypes: []BrickType,
};

const AvailLevelHashMap = std.hash_map.StringHashMap([]const u8);

const LevelMap = struct {
    vertTotalUnits: f32,
    horizTotalUnits: f32,
    hashMap: LevelHashMap,
};

pub fn enumerateAvailLevels(allocator: *Allocator, dir_path: []const u8) !AvailLevelHashMap {
    var walker = try std.fs.walkPath(allocator, dir_path);
    defer walker.deinit();

    var hash_map = AvailLevelHashMap.init(allocator);
    errdefer {
        var it = hash_map.iterator();
        while (it.next()) |entry| {
            allocator.free(entry.value);
        }
        hash_map.deinit();
    }
    const ext = ".lvl";

    while (try walker.next()) |entry| {
        if (!mem.endsWith(u8, entry.basename, ext)) continue;
        var path_buf = try std.Buffer.init(allocator, entry.path);
        errdefer path_buf.deinit();
        var base_buf = try std.Buffer.init(allocator, entry.basename);
        errdefer base_buf.deinit();
        const base_slice = base_buf.toOwnedSlice();
        const base_name_len = base_slice.len - ext.len;
        try hash_map.putNoClobber(base_slice[0..base_name_len], path_buf.toOwnedSlice());
    }
    return hash_map;
}

//pub fn loadLevels(allocator: *Allocator, num_vert_units: u32, vert_usage: u32,
//        aspect_ratio: f32) !AvaileLevelMap {
//    if (vert_usage == 0 or vert_usage > num_vert_units) {
//        return error.InvalidLevelUnits;
//    }
//    const dir_path = try utils.resolveSinglePath(allocator, "./levels");
//    defer allocator.free(dir_path);
//    var walker = try std.fs.walkPath(allocator, dir_path);
//    defer walker.deinit();
//    var file_list = std.ArrayList([]const u8).init(allocator);
//    defer {
//        for(file_list.toSlice()) |file| {
//            allocator.free(file);
//        }
//        file_list.deinit();
//    }
//
//
//    const map_width = @intToFloat(f32, num_vert_units) * aspect_ratio;
//    const map_height = @intToFloat(f32, num_vert_units);
//
//    var lvls = std.ArrayList(GameLevel).init(allocator);
//    errdefer lvls.deinit();
//    next_file: for(file_list.toSlice()) |file| {
//        const file_slice = try std.io.readFileAlloc(allocator, file);
//        defer allocator.free(file_slice);
//        var lines = mem.tokenize(file_slice, "\r\n");
//        var level_data = std.ArrayList([]u8).init(allocator);
//        errdefer level_data.deinit();
//        var max_bricks_x: u32 = 0;
//        while (lines.next()) |line| {
//            var items = mem.separate(line, " ");
//            var level_row = std.ArrayList(u8).init(allocator);
//            errdefer level_row.deinit();
//            var num_bricks: u32 = 0;
//            while (items.next()) |i| {
//                try level_row.append(try fmt.parseInt(u8, i, 10));
//                num_bricks += 1;
//            }
//            if (max_bricks_x != 0 and max_bricks_x != num_bricks) {
//                pdbg("warning: Level '{s}' is not valid.", file);
//                continue :next_file;
//            } else if (max_bricks_x < num_bricks) {
//                max_bricks_x = @intCast(u32, num_bricks);
//            }
//            try level_data.append(level_row.toOwnedSlice());
//        }
//        const level_slice = level_data.toSlice();
//        const num_bricks_y: u32 = @intCast(u32, level_slice.len);
//        const brick_size_x = map_width / @intToFloat(f32, max_bricks_x);
//        const brick_size_y = map_height / @intToFloat(f32, num_bricks_y);
//        try lvls.append(try loadLevelTiles(allocator, brick_size_x, brick_size_y, level_slice));
//    }
//    return GameLevelMap{
//        .vertTotalUnits = map_width,
//        .horizTotalUnits = map_height,
//        .levels = lvls.toOwnedSlice(),
//    };
//}

fn loadLevelTiles(allocator: *Allocator, brick_size_x: f32, brick_size_y: f32, tiles: [][]u8) !GameLevel {
    const map_height = tiles.len;
    const map_width = tiles[0].len;
    if (map_height < 1 or map_width < 1) {
        return error.InvalidMap;
    }
    var bpos = std.ArrayList(Vec2f).init(allocator);
    errdefer bpos.deinit();
    var bcols = std.ArrayList(Vec3f).init(allocator);
    errdefer bcols.deinit();
    var btypes = std.ArrayList(BrickType).init(allocator);
    errdefer btypes.deinit();
    for (tiles) |row, y| {
        for (row) |i, x| {
            try bpos.append([_]f32{
                brick_size_x * @intToFloat(f32, x) + brick_size_x / 2,
                brick_size_y * @intToFloat(f32, y) + brick_size_y / 2,
            });
            switch (i) {
                0 => {
                    try bcols.append([_]f32{ 0.0, 0.0, 0.0 });
                    try btypes.append(.Empty);
                },
                1 => {
                    try bcols.append([_]f32{ 0.8, 0.8, 0.7 });
                    try btypes.append(.Solid);
                },
                2 => {
                    try bcols.append([_]f32{ 0.2, 0.5, 1.0 });
                    try btypes.append(.Breakable);
                },
                3 => {
                    try bcols.append([_]f32{ 0.0, 0.7, 0.0 });
                    try btypes.append(.Breakable);
                },
                4 => {
                    try bcols.append([_]f32{ 0.8, 0.8, 0.4 });
                    try btypes.append(.Breakable);
                },
                5 => {
                    try bcols.append([_]f32{ 1.0, 0.5, 0.0 });
                    try btypes.append(.Breakable);
                },
                else => {
                    try bcols.append([_]f32{ 1.0, 1.0, 1.0 });
                    try btypes.append(.Breakable);
                },
            }
        }
    }

    if (bpos.len != bcols.len or bcols.len != btypes.len) {
        unreachable;
    }

    var size: Vec2f = [_]f32{ brick_size_x, brick_size_y };
    return GameLevel{
        .widthInBricks = @intCast(u32, map_width),
        .heightInBricks = @intCast(u32, map_height),
        .brickSize = size,
        .brickPositions = bpos.toOwnedSlice(),
        .brickColors = bcols.toOwnedSlice(),
        .brickTypes = btypes.toOwnedSlice(),
    };
}
