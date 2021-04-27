const Ball = struct {
    size: Vec2f,
    position: Vec2f,
    velocity: Vec2f,
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

const Paddle = struct {
    size: Vec2d,
    position: Vec2d,

    pub inline fn halfExtentX(self: Self) f64 {
        return self.size[0] / 2;
    }
    pub inline fn halfExtentY(self: Self) f64 {
        return self.size[1] / 2;
    }
};

const Ball = struct {
    radius: f64,
    position: Vec2d,
    velocity: Vec2d,
};

const GameStatus = enum {
    AtMenu,
    Start,
    BallEscaped,
    InPlay,
    Reset,
};

const LevelEffects = enum {
    Chaos,
    Shake,
    Confuse,
};

const Game = struct {
    ball: Ball,
    player: Paddle,
    is_ball_stuck: bool,
    levels: []GameLevel,

    const Self = @This();
    const MAP_WIDTH = 800;
    const MAP_CENTER_X = MAP_WIDTH / 2;
    const MAP_HEIGHT = 600;
    const MAP_CENTER_Y = MAP_HEIGHT / 2;

    const PADDLE_SIZE_X = 100;
    const PADDLE_SIZE_Y = 20;
    const PADDLE_SIZE: Vec2d = [_]f64{ PADDLE_SIZE_X, PADDLE_SIZE_Y };
    const PADDLE_BOUND_MIN_X = PADDLE_RADIUS_X;
    const PADDLE_BOUND_MAX_X = MAP_WIDTH - PADDLE_RADIUS_X;
    const PADDLE_POS_Y = MAP_HEIGHT - PADDLE_RADIUS_Y;
    const PADDLE_VELOCITY = 500.0;
    const PADDLE_INITIAL_POS: Vec2d = [_]f64{ MAP_CENTER_X, PADDLE_POS_Y };

    const POWERUP_SIZE_X = 60;
    const POWERUP_SIZE_Y = 20;
    const POWERUP_VELOCITY_Y = 150;

    const BALL_SIZE = 25;
    const BALL_RADIUS = BALL_SIZE / 2;
    const BALL_HALF_RADIUS = BALL_RADIUS / 2;
    const BALL_BOUND_MIN_X = BALL_RADIUS;
    const BALL_BOUND_MAX_X = MAP_WIDTH - BALL_RADIUS;
    const BALL_BOUND_MAX_Y = MAP_HEIGHT - BALL_RADIUS;
    const BALL_BOUND_MIN_Y = BALL_RADIUS;
    const BALL_INITIAL_POS: Vec2d = [_]f64{ MAP_CENTER_X, MAP_HEIGHT - PADDLE_SIZE_Y - BALL_RADIUS };
    const BALL_INITIAL_VELOCITY: Vec2d = [_]f64{ -100.0, -350.0 };

    pub fn setBallStuck(self: *Self, is_stuck: bool) void {
        self.is_ball_stuck = is_stuck;
    }

    pub fn init() Self {
        return Self{
            .is_ball_stuck = true,
            .ball = .{
                .radius = 25,
                .position = BALL_INITIAL_POS,
                .velocity = BALL_INITIAL_VELOCITY,
            },
            .player = .{
                .size = PADDLE_SIZE,
                .position = PADDLE_INITIAL_POS,
                .velocity_x = PADDLE_INTIAL_VELOCITY,
            },
            .levels = &[_]GameLevels{},
        };
    }

    pub fn update(self: *Self, dt: f64) GameStatus {
        if (self.is_ball_stuck) return;
        const ball_delta_x = self.ball.velocity[0] * dt;
        const ball_delta_y = self.ball.velocity[1] * dt;
        const ball_x = self.ball.position[0];
        const ball_y = self.ball.position[1];
        if (ball_y + ball_delta_y > MAP_HEIGHT) {
            resetBallAndPlayer(self);
            return .BallEscaped;
        }
        if (ball_x + ball_delta_x <= BALL_BOUND_MIN_X or ball_x + ball_delta_x >= BALL_BOUND_MAX_X) {
            self.ball.position[0] += (ball_delta_x * -1);
            self.ball.velocity[0] *= -1;
        }
        if (ball_y + ball_delta_y <= BALL_BOUND_MIN_Y) {
            self.ball.position[1] += (ball_delta_y * -1);
            self.ball.velocity[1] *= -1;
        }
    }

    fn doBallPaddleCollision(self: *Self) bool {
        var ballp = &self.ball;
        const half_extnts = [_]f32{ self.paddle.halfExtentX(), self.paddle.halfExtentY() };
        if (maybeGetBallBoxCollision(ball_pos, radius, paddle_pos, half_extnts)) |c| {
            const strength: f32 = 2.0;
            const old_velo = ballp.velocity;
            const velo_x = std.math.absFloat(BALL_INITIAL_VELOCITY[0]) * p.percent_from_center * strength;
            const velo_y = -1 * std.math.absFloat(ball_velocity[1]);
            ballp.velocity = math.normVec2f([_]f32{ velo_x, velo_y }) * @splat(2, math.magVec2f(old_velo));
            ballp.position[1] -= BALL_RADIUS - std.math.absFloat(c.base_box.penetration_vec[0]);
            return true;
        } else return false;
    }

    fn doBallBricksCollision(self: *Self) bool {
        const b = game.maybeGetBallBrickCollision(ball_pos, BALL_RADIUS, game_level) orelse return;
        if (game_level.types[b.index] != .Solid) {
            game_level.statuses[b.index] = .Destroyed;
            const spawn_val = rgen.random.int(usize);
            if (spawn_val % 75 == 0) {
                const powerup_id = @intToEnum(powerup_system.PowerupType, rgen.random.int(u3) % 4);
                powerups.queue(game_level.world_states[b.index].position, powerup_id);
            } else if (spawn_val % 15 == 0) {
                const scene_id = @intToEnum(powerup_system.PowerupType, rgen.random.int(u3) % 2 + 4);
                powerups.queue(game_level.world_states[b.index].position, scene_id);
            }
        } else {
            post_proc_vars.do_shake = @boolToInt(true);
            post_proc_vars.delta_time = 0.05;
        }
        switch (b.base_box.side) {
            .Top => {
                ball_pos[1] -= BALL_RADIUS - std.math.absFloat(b.base_box.penetration_vec[1]);
                ball_velocity[1] *= -1;
            },
            .Bottom => {
                ball_pos[1] += BALL_RADIUS - std.math.absFloat(b.base_box.penetration_vec[1]);
                ball_velocity[1] *= -1;
            },
            .Left => {
                ball_pos[0] += BALL_RADIUS - std.math.absFloat(b.base_box.penetration_vec[0]);
                ball_velocity[0] *= -1;
            },
            .Right => {
                ball_pos[0] -= BALL_RADIUS - std.math.absFloat(b.base_box.penetration_vec[0]);
                ball_velocity[0] *= -1;
            },
        }
    }

    fn detectCollisions(self: *Self) void {
        if (doBallPaddleCollision(self)) {
            return;
        } else else if (game.maybeGetPaddlePowerupCollision(paddle_pos, [_]f32{ PADDLE_SIZE_X, PADDLE_SIZE_Y }, powerups, [_]f32{ POWERUP_SIZE_X, POWERUP_SIZE_Y })) |c| {
            powerups.delete(c.index);
        }
    }

    pub fn movePlayerLeft(self: *Self, dt: f64) void {
        const old_x = self.player.position[0];
        const new_x = old_x - (PADDLE_VELOCITY * dt);
        var diff_x: f64 = 0;
        if (new_x <= PADDLE_BOUND_MIN_X) {
            diff_x = old_x - PADDLE_BOUND_MIN_X;
        }
        self.player.position[0] -= diff_x;
        if (self.is_ball_stuck) {
            self.ball.position[0] -= diff_x;
        }
    }

    pub fn movePlayerRight(self: *Self, dt: f64) void {
        const old_x = self.player.position[0];
        const new_x = old_x + (PADDLE_VELOCITY * dt);
        var diff_x: f64 = 0;
        if (new_x >= PADDLE_BOUND_MAX_X) {
            diff_x = PADDLE_BOUND_MAX_X - old_x;
        }
        self.player.position[0] += diff_x;
        if (self.is_ball_stuck) {
            self.ball.position[0] += diff_x;
        }
    }

    fn checkEscapeMap(ball_pos: Vec2d, delta: f64, map_height: f64) bool {
        if (ball_pos[1] + delta >= map_height) return true else false;
    }

    fn resetBallAndPlayer(self: *Self) void {
        self.is_ball_stuck = true;
        self.ball.velocity = BALL_INITIAL_VELOCITY;
        self.ball.position = BALL_INITIAL_POS;
        self.player.velocity = PADDLE_INITIAL_VELOCITY;
        self.player.position = PADDLE_INITIAL_POS;
    }
};

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
