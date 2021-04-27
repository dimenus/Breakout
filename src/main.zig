const std = @import("std");
const builtin = @import("builtin");
const pdbg = std.debug.warn;
const vks = @import("vks.zig");
const cimport = @import("cimport");
const glfw = cimport.glfw;
const Allocator = std.mem.Allocator;
const math = @import("math.zig");
const game = @import("game_load.zig");
const Random = std.rand.Random;
const vertex_data = @import("vertex_data.zig");
const sound = @import("sound.zig");
const particle_system = @import("particles.zig");
const Particles = particle_system.Particles;
const powerup_system = @import("powerups.zig");
const Powerups = powerup_system.Powerups;
const postproc = @import("postprocess.zig");

usingnamespace glfw;
usingnamespace vks;
usingnamespace math;

const RenderTargetShaderVars = extern struct {
    frag_color: Vec4f = [_]f32{ 1.0, 1.0, 1.0, 1.0 },
    position: [2]f32 = [_]f32{ 0, 0 },
    scale: [2]f32 = [_]f32{ 1.0, 1.0 },
    tex_idx: u32 = 0,
};

const SCREEN_WIDTH = 800;
const SCREEN_CENTER_X = SCREEN_WIDTH / 2;
const SCREEN_HEIGHT = 600;
const SCREEN_CENTER_Y = SCREEN_HEIGHT / 2;

const PADDLE_SIZE_X = 100;
const PADDLE_RADIUS_X = PADDLE_SIZE_X / 2;
const PADDLE_BOUND_MIN_X = PADDLE_RADIUS_X;
const PADDLE_BOUND_MAX_X = SCREEN_WIDTH - PADDLE_RADIUS_X;
const PADDLE_SIZE_Y = 20;
const PADDLE_RADIUS_Y = PADDLE_SIZE_Y / 2;
const PADDLE_POSITION_Y = SCREEN_HEIGHT - PADDLE_RADIUS_Y;

const POWERUP_SIZE_X = 60;
const POWERUP_SIZE_Y = 20;
const POWERUP_VELOCITY_Y = 150;

const BALL_SIZE = 25;
const BALL_RADIUS = BALL_SIZE / 2;
const BALL_HALF_RADIUS = BALL_RADIUS / 2;
const BALL_BOUND_MIN_X = BALL_RADIUS;
const BALL_BOUND_MAX_X = SCREEN_WIDTH - BALL_RADIUS;
const BALL_BOUND_MAX_Y = SCREEN_HEIGHT - BALL_RADIUS;
const BALL_BOUND_MIN_Y = BALL_RADIUS;
const BALL_POSITION_X = SCREEN_CENTER_X;
const BALL_POSITION_Y = SCREEN_HEIGHT - PADDLE_SIZE_Y - BALL_RADIUS;

const BACKGROUND_DESCR_ID = 0;
const PADDLE_DESCR_ID = 1;
const BALL_DESCR_ID = 2;
const BRICK_DESCR_ID = 3;

const BACKGROUND_TEX_ID = 0;
const PADDLE_TEX_ID = 1;
const BALL_TEX_ID = 2;
const BRICK_TEX_ID = 3;
const SOLID_BRICK_TEX_ID = 4;
const PARTICLE_TEX_ID = 5;
const CHAOS_TEX_ID = 6;
const CONFUSE_TEX_ID = 7;
const INCREASE_TEX_ID = 8;
const PASS_THROUGH_TEX_ID = 9;
const SPEED_TEX_ID = 10;
const STICKY_TEX_ID = 11;

const PADDLE_INITIAL_VELOCITY = 500.0;
const BALL_INITIAL_VELOCITY: Vec2f = [_]f32{ -100.0, -350.0 };

const USE_VSYNC = false;

pub fn getPowerupTexID(t: powerup_system.PowerupType) u32 {
    switch (t) {
        .Speed => return SPEED_TEX_ID,
        .Sticky => return STICKY_TEX_ID,
        .PassThrough => return PASS_THROUGH_TEX_ID,
        .PadSizeIncrease => return INCREASE_TEX_ID,
        .Confuse => return CONFUSE_TEX_ID,
        .Chaos => return CHAOS_TEX_ID,
    }
}

pub fn getPowerupColor(t: powerup_system.PowerupType) Vec4 {
    switch (t) {
        .Speed => return [_]f32{ 0.5, 0.5, 1.0, 1.0 },
        .Sticky => return [_]f32{ 1.0, 0.5, 1.0, 1.0 },
        .PassThrough => return [_]f32{ 0.5, 1.0, 0.5, 1.0 },
        .PadSizeIncrease => return [_]f32{ 1.0, 0.6, 0.4, 1.0 },
        .Confuse => return [_]f32{ 1.0, 0.3, 0.3, 1.0 },
        .Chaos => return [_]f32{ 0.9, 0.25, 0.25, 1.0 },
    }
}

const FrameUniform = struct {
    paddle: Mat4x4,
    ball: Mat4x4,
};

pub fn main() anyerror!void {
    if (glfwInit() == 0) return error.GlfwInitFailed;

    const allocator = std.heap.c_allocator;
    var sound_mgr = try sound.createSoundManager(allocator);
    try sound_mgr.setBackgroundStream("breakout.mp3");

    //const tiles = &[_][]u8 {
    //    &[_]u8{1, 1, 1, 1, 1, 1},
    //    &[_]u8{2, 2, 0, 0, 2, 2},
    //    &[_]u8{3, 3, 4, 4, 3, 3}
    //};g
    const tiles = @import("game_levels.zig").StandardTiles;
    const game_level = try game.createLevel(allocator, SCREEN_WIDTH / @intToFloat(f32, tiles[0].len), SCREEN_HEIGHT / @intToFloat(f32, tiles[0].len), tiles[0..]);

    var particles = try Particles.init(allocator, 512);
    var powerups = try Powerups.init(allocator, 8);

    //FIXME: We need to cleanup Vulkan in order to cleanup GLFW with vsync on
    //https://github.com/KhronosGroup/Vulkan-LoaderAndValidationLayers/issues/1894
    //defer glfwTerminate();

    var secret_seed: [std.rand.DefaultCsprng.secret_seed_length]u8 = undefined;
    std.crypto.random.bytes(&secret_seed);
    const seed = std.mem.readIntSliceLittle(u64, secret_seed[0..16]);
    var rgen = &std.rand.DefaultPrng.init(seed).random;

    var proj = Mat4x4.orthoRH(0.0, SCREEN_WIDTH, 0, SCREEN_HEIGHT, 0.0, 1.0);

    const aspect_ratio = @floatCast(f32, SCREEN_WIDTH) / @floatCast(f32, SCREEN_HEIGHT);
    glfwWindowHint(GLFW_CLIENT_API, GLFW_NO_API);
    glfwWindowHint(GLFW_RESIZABLE, GLFW_FALSE);
    const window = glfwCreateWindow(SCREEN_WIDTH, SCREEN_HEIGHT, "Breakout", null, null) orelse return error.GlfwWindowCreateFailed;
    defer glfwDestroyWindow(window);
    glfwMakeContextCurrent(window);

    const inst = if (builtin.mode == .ReleaseFast) try createInstance(allocator, "vulkan-demo", false) else try createInstance(allocator, "vulkan-demo", true);
    const device = try createContext(allocator, inst, VK_QUEUE_GRAPHICS_BIT, true);
    const swapchain = &try swap_chain.createSwapChain(allocator, window, inst, device, 2, USE_VSYNC);

    const geo_buffers = try vertex_data.createQuadGeometryBuffers(device, true);

    const brick_size: Vec2f = [_]f32{ SCREEN_WIDTH / @intToFloat(f32, game_level.width_in_bricks), @intToFloat(f32, SCREEN_HEIGHT / game_level.width_in_bricks) };

    var particle_worlds_buffers = try createDirectBufferSliceWithLength(allocator, device.mem_alloc, .Vertex, particle_system.ParticleWorldState, particles.max_particles, swapchain.num_max_frames);

    const post_proc_buffer = try createDirectBuffer(device.mem_alloc, .Uniform, postproc.FragUniform, postproc.uniform);
    const proj_uni_buffer = try vks.createDirectBuffer(device.mem_alloc, .Uniform, Mat4x4, proj);
    const image_refs = &[_]ImageRef{
        try vks.image.createDirectFromKTXFile(allocator, device, "textures/background_BC3.ktx"),
        try vks.image.createDirectFromKTXFile(allocator, device, "textures/paddle_BC3.ktx"),
        try vks.image.createDirectFromKTXFile(allocator, device, "textures/awesomeface_BC3.ktx"),
        try vks.image.createDirectFromKTXFile(allocator, device, "textures/block_BC3.ktx"),
        try vks.image.createDirectFromKTXFile(allocator, device, "textures/block_solid_BC3.ktx"),
        try vks.image.createDirectFromKTXFile(allocator, device, "textures/particle_BC3.ktx"),
        try vks.image.createDirectFromKTXFile(allocator, device, "textures/powerup_chaos_BC3.ktx"),
        try vks.image.createDirectFromKTXFile(allocator, device, "textures/powerup_confuse_BC3.ktx"),
        try vks.image.createDirectFromKTXFile(allocator, device, "textures/powerup_increase_BC3.ktx"),
        try vks.image.createDirectFromKTXFile(allocator, device, "textures/powerup_passthrough_BC3.ktx"),
        try vks.image.createDirectFromKTXFile(allocator, device, "textures/powerup_speed_BC3.ktx"),
        try vks.image.createDirectFromKTXFile(allocator, device, "textures/powerup_sticky_BC3.ktx"),
    };

    var descr_pool: VkDescriptorPool = undefined;
    {
        const num_uniforms: u32 = 2;
        const num_samplers: u32 = 1;
        const num_images = @intCast(u32, image_refs.len);
        const descr_pool_sizes = &[_]VkDescriptorPoolSize{
            VkDescriptorPoolSize{
                .type = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
                .descriptorCount = num_uniforms,
            },
            VkDescriptorPoolSize{
                .type = VK_DESCRIPTOR_TYPE_SAMPLER,
                .descriptorCount = num_samplers,
            },
            VkDescriptorPoolSize{
                .type = VK_DESCRIPTOR_TYPE_SAMPLED_IMAGE,
                .descriptorCount = num_images,
            },
            VkDescriptorPoolSize{
                .type = VK_DESCRIPTOR_TYPE_COMBINED_IMAGE_SAMPLER,
                .descriptorCount = @intCast(u32, swapchain.num_swap_images),
            },
        };
        const descr_pci = VkDescriptorPoolCreateInfo{
            .poolSizeCount = descr_pool_sizes.len,
            .pPoolSizes = descr_pool_sizes,
            .maxSets = num_uniforms + num_samplers + num_images,
        };
        try vks.checkSuccess(vkCreateDescriptorPool(device.logical, &descr_pci, null, &descr_pool));
    }
    const num_samples = VK_SAMPLE_COUNT_4_BIT;
    const scene_descr = try createSceneDescriptor(allocator, device, proj_uni_buffer, descr_pool, image_refs);
    const msaa_image_ref = try createMSAAImageRef(device, swapchain.color_format, swapchain.extent, num_samples);
    const render_target_ref = try createDestColorAttachImageRef(device, swapchain.color_format, swapchain.extent);
    const basic_pass = try pipeline.createShaderTargetRenderPass(allocator, device, swapchain.color_format, swapchain.extent, render_target_ref, swapchain.image_refs);
    const msaa_pass = try pipeline.createShaderTargetMSAARenderPass(allocator, device, swapchain.color_format, swapchain.extent, num_samples, msaa_image_ref, render_target_ref, swapchain.image_refs);
    const post_proc_descr = try postproc.createDescriptor(device, descr_pool, post_proc_buffer, render_target_ref);
    const obj_pipe_layout = try pipeline.createPipelineLayout(device, &[_]VkDescriptorSetLayout{scene_descr.layout}, createPushConstantRange(RenderTargetShaderVars));
    const post_proc_pipe_layout = try pipeline.createPipelineLayout(device, &[_]VkDescriptorSetLayout{post_proc_descr.layout}, createPushConstantRange(postproc.ShaderVars));
    const vp_info = VkPipelineViewportStateCreateInfo{
        .viewportCount = 1,
        .pViewports = &VkViewport{
            .width = @intToFloat(f32, swapchain.extent.width),
            .height = @intToFloat(f32, swapchain.extent.height),
        },
        .scissorCount = 1,
        .pScissors = &VkRect2D{
            .offset = .{ .x = 0, .y = 0 },
            .extent = swapchain.extent,
        },
    };

    const shader_norot_info = try vertex_data.getShaderInfoNoRotate(allocator, device);
    const shader_instance_info = try vertex_data.getShaderInfoInstance(allocator, device);
    const shader_post_proc_info = try vertex_data.getShaderInfoPostProcess(allocator, device);

    const obj_pipes = [_]VkPipeline{
        try pipeline.createPipelineMultiSampledWithBlendFactor(device, shader_norot_info, vp_info, obj_pipe_layout, msaa_pass.pass, num_samples, VK_BLEND_FACTOR_SRC_ALPHA, VK_BLEND_FACTOR_ONE_MINUS_SRC_ALPHA),
        try pipeline.createPipelineWithBlendFactor(device, shader_norot_info, vp_info, obj_pipe_layout, basic_pass.pass, VK_BLEND_FACTOR_SRC_ALPHA, VK_BLEND_FACTOR_ONE_MINUS_SRC_ALPHA),
    };
    const particle_pipes = [_]VkPipeline{
        try pipeline.createPipelineMultiSampledWithBlendFactor(device, shader_instance_info, vp_info, obj_pipe_layout, msaa_pass.pass, num_samples, VK_BLEND_FACTOR_SRC_ALPHA, VK_BLEND_FACTOR_ONE),
        try pipeline.createPipelineWithBlendFactor(device, shader_instance_info, vp_info, obj_pipe_layout, basic_pass.pass, VK_BLEND_FACTOR_SRC_ALPHA, VK_BLEND_FACTOR_ONE),
    };
    const post_proc_pipes = [_]VkPipeline{
        try pipeline.createPipeline(device, shader_post_proc_info, vp_info, post_proc_pipe_layout, msaa_pass.pass, 1),
        try pipeline.createPipeline(device, shader_post_proc_info, vp_info, post_proc_pipe_layout, basic_pass.pass, 1),
    };

    var particle_spawn_timer: f64 = 0.008;
    var particle_spawn_delta: f64 = 0.0;
    var prev_frame_time: f64 = 0;
    var curr_frame_time: f64 = 0;
    var print_timer: f64 = 5.0;
    var curr_print_timer: f64 = 0.0;
    var timer_idx: usize = 0;
    const num_avgs = 5 * 30;
    var frame_avgs = [_]f64{0} ** (num_avgs);
    const num_vertices = @intCast(u32, geo_buffers.num_vertices);

    var paddle_pos: Vec2f = [_]f32{ SCREEN_CENTER_X, PADDLE_POSITION_Y };
    var paddle_velocity: f32 = PADDLE_INITIAL_VELOCITY;
    var ball_pos: Vec2f = [_]f32{ BALL_POSITION_X, BALL_POSITION_Y };
    var ball_velocity: Vec2f = BALL_INITIAL_VELOCITY;
    var is_stuck = true;
    var use_msaa = false;
    pdbg("[INFO]: MSAA (4x) is enabled...\n", .{});
    var skip_msaa_check = false;
    var skip_shake_check = false;
    var post_proc_vars = postproc.ShaderVars{};

    new_frame: while (glfwWindowShouldClose(window) == GLFW_FALSE) {
        curr_frame_time = glfwGetTime();
        const delta_time = curr_frame_time - prev_frame_time;
        prev_frame_time = curr_frame_time;

        if (isKeyDown(window, GLFW_KEY_F2)) {
            if (!skip_msaa_check) {
                use_msaa = !use_msaa;
                skip_msaa_check = true;
                const txt = if (use_msaa) "true" else "false";
                pdbg("[INFO]: MSAA = {s}\n", .{txt});
            }
        } else {
            skip_msaa_check = false;
        }

        if (isKeyDown(window, GLFW_KEY_F3)) {
            post_proc_vars.do_shake = @boolToInt(true);
            post_proc_vars.delta_time = 0.05;
        }
        if (isKeyDown(window, GLFW_KEY_F4)) {
            post_proc_vars.do_confuse = @boolToInt(true);
        } else {
            post_proc_vars.do_confuse = @boolToInt(false);
        }
        if (isKeyDown(window, GLFW_KEY_F5)) {
            post_proc_vars.do_chaos = @boolToInt(true);
        } else {
            post_proc_vars.do_chaos = @boolToInt(false);
        }

        //ball update
        {
            var delta_x = ball_velocity[0] * @floatCast(f32, delta_time);
            var delta_y = ball_velocity[1] * @floatCast(f32, delta_time);
            if (is_stuck) {
                if (isKeyDown(window, GLFW_KEY_SPACE)) is_stuck = false;
            } else {
                if (ball_pos[1] + delta_y >= SCREEN_HEIGHT) {
                    ball_pos = [_]f32{ BALL_POSITION_X, BALL_POSITION_Y };
                    ball_velocity = BALL_INITIAL_VELOCITY;
                    paddle_velocity = PADDLE_INITIAL_VELOCITY;
                    paddle_pos = [_]f32{ SCREEN_CENTER_X, PADDLE_POSITION_Y };
                    is_stuck = true;
                    game.resetLevelStatus(game_level.statuses);
                    particles.clear();
                    continue :new_frame;
                }
                if (ball_pos[0] + delta_x <= BALL_BOUND_MIN_X or ball_pos[0] + delta_x >= BALL_BOUND_MAX_X) {
                    delta_x *= -1;
                    ball_velocity[0] *= -1;
                }
                if (ball_pos[1] + delta_y <= BALL_BOUND_MIN_Y) {
                    delta_y *= -1;
                    ball_velocity[1] *= -1;
                }
                ball_pos[0] += delta_x;
                ball_pos[1] += delta_y;

                if (game.maybeGetBallPaddleCollision(ball_pos, BALL_RADIUS, paddle_pos, [_]f32{ PADDLE_SIZE_X, PADDLE_SIZE_Y })) |p| {
                    const strength: f32 = 2.0;
                    const old_velo = ball_velocity;
                    const velo_x = std.math.absFloat(BALL_INITIAL_VELOCITY[0]) * p.percent_from_center * strength;
                    const velo_y = -1 * std.math.absFloat(ball_velocity[1]);
                    ball_velocity = math.normVec2f([_]f32{ velo_x, velo_y }) * @splat(2, math.magVec2f(old_velo));
                    ball_pos[1] -= BALL_RADIUS - std.math.absFloat(p.base_box.penetration_vec[0]);
                } else if (game.maybeGetBallBrickCollision(ball_pos, BALL_RADIUS, game_level)) |b| {
                    if (game_level.types[b.index] != .Solid) {
                        game_level.statuses[b.index] = .Destroyed;
                        const spawn_val = rgen.int(usize);
                        if (spawn_val % 75 == 0) {
                            const powerup_id = @intToEnum(powerup_system.PowerupType, rgen.int(u3) % 4);
                            powerups.queue(ball_pos, powerup_id);
                            pdbg("[INFO] spawning powerup id -> {s}...\n", .{@tagName(powerup_id)});
                        } else if (spawn_val % 15 == 0) {
                            const scene_id = @intToEnum(powerup_system.PowerupType, rgen.int(u3) % 2 + 4);
                            powerups.queue(ball_pos, scene_id);
                            pdbg("[INFO] spawning negative scenario id -> {s}...\n", .{@tagName(scene_id)});
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
            }
        }

        if (isKeyDown(window, GLFW_KEY_A) or isKeyDown(window, GLFW_KEY_LEFT)) {
            var diff_x = @floatCast(f32, paddle_velocity * delta_time);
            if (paddle_pos[0] - diff_x <= PADDLE_BOUND_MIN_X) {
                diff_x = paddle_pos[0] - PADDLE_BOUND_MIN_X;
            }
            paddle_pos[0] -= diff_x;
            if (is_stuck) {
                ball_pos[0] -= diff_x;
            }
        }
        if (isKeyDown(window, GLFW_KEY_D) or isKeyDown(window, GLFW_KEY_RIGHT)) {
            var diff_x = @floatCast(f32, paddle_velocity * delta_time);
            if (paddle_pos[0] + diff_x >= PADDLE_BOUND_MAX_X) {
                diff_x = PADDLE_BOUND_MAX_X - paddle_pos[0];
            }
            paddle_pos[0] += diff_x;
            if (is_stuck) {
                ball_pos[0] += diff_x;
            }
        }

        powerups.update([_]f32{ 0.0, @floatCast(f32, POWERUP_VELOCITY_Y * delta_time) }, SCREEN_HEIGHT);

        particle_spawn_delta += delta_time;
        particles.update(delta_time);
        if (particle_spawn_delta > particle_spawn_timer) {
            particle_spawn_delta = 0.0;
            if (USE_VSYNC) {
                try particles.queueNewParticle(rgen, ball_pos, ball_velocity);
                try particles.queueNewParticle(rgen, ball_pos, ball_velocity);
                try particles.queueNewParticle(rgen, ball_pos, ball_velocity);
                try particles.queueNewParticle(rgen, ball_pos, ball_velocity);
            } else {
                try particles.queueNewParticle(rgen, ball_pos, ball_velocity);
                try particles.queueNewParticle(rgen, ball_pos, ball_velocity);
            }
        }
        const particle_worlds = particles.getWorldStatePackedSlice();
        try updateBufferWithSlice(device, particle_worlds_buffers[swapchain.getFrameIdx()], particle_system.ParticleWorldState, particle_worlds);

        const cbuf = try swapchain.waitOnNextCmdBuffer();
        const frame_idx = swapchain.getFrameIdx();
        const swap_image_idx = swapchain.getSwapImageIdx();
        const offsets = [_]VkDeviceSize{0};

        const begin_info = VkCommandBufferBeginInfo{};
        const clear_color = [_]f32{ 0.0, 0.0, 0.0, 0.0 };
        const clear_values = [_]VkClearValue{
            .{ .color = VkClearColorValue{ .float32 = clear_color } },
            .{ .color = VkClearColorValue{ .float32 = clear_color } },
            .{ .color = VkClearColorValue{ .float32 = clear_color } },
        };
        var rp_info = VkRenderPassBeginInfo{
            .renderPass = if (use_msaa) msaa_pass.pass else basic_pass.pass,
            .framebuffer = if (use_msaa) msaa_pass.frame_buffers[swap_image_idx] else basic_pass.frame_buffers[swap_image_idx],
            .renderArea = VkRect2D{
                .offset = VkOffset2D{ .x = 0, .y = 0 },
                .extent = swapchain.extent,
            },
            .clearValueCount = clear_values.len,
            .pClearValues = &clear_values,
        };
        checkSuccess(vkBeginCommandBuffer(cbuf, &begin_info)) catch unreachable;
        vkCmdBeginRenderPass(cbuf, &rp_info, VK_SUBPASS_CONTENTS_INLINE);

        const pipe_idx: usize = if (use_msaa) 0 else 1;
        vkCmdBindPipeline(cbuf, VK_PIPELINE_BIND_POINT_GRAPHICS, obj_pipes[pipe_idx]);
        vkCmdBindDescriptorSets(cbuf, VK_PIPELINE_BIND_POINT_GRAPHICS, obj_pipe_layout, 0, 1, &scene_descr.set, 0, null);
        vkCmdBindVertexBuffers(cbuf, 0, 1, &geo_buffers.vertex.handle, &offsets);

        drawObj(cbuf, obj_pipe_layout, num_vertices, RenderTargetShaderVars{
            .tex_idx = BACKGROUND_TEX_ID,
            .scale = [_]f32{ SCREEN_WIDTH, SCREEN_HEIGHT },
            .position = [_]f32{ SCREEN_CENTER_X, SCREEN_CENTER_Y },
        });

        drawObj(cbuf, obj_pipe_layout, num_vertices, RenderTargetShaderVars{
            .tex_idx = PADDLE_TEX_ID,
            .scale = [_]f32{ PADDLE_SIZE_X, PADDLE_SIZE_Y },
            .position = paddle_pos,
        });

        for (game_level.world_states) |s, i| {
            if (game_level.statuses[i] == .Destroyed) continue;
            drawObj(cbuf, obj_pipe_layout, num_vertices, .{
                .frag_color = s.color,
                .position = s.position,
                .scale = brick_size,
                .tex_idx = if (game_level.types[i] == .Solid) SOLID_BRICK_TEX_ID else BRICK_TEX_ID,
            });
        }

        vkCmdBindPipeline(cbuf, VK_PIPELINE_BIND_POINT_GRAPHICS, particle_pipes[pipe_idx]);
        vkCmdBindVertexBuffers(cbuf, 1, 1, &particle_worlds_buffers[frame_idx].handle, &offsets);
        vkCmdPushConstants(cbuf, obj_pipe_layout, VK_SHADER_STAGE_VERTEX_BIT | VK_SHADER_STAGE_FRAGMENT_BIT, 0, @sizeOf(RenderTargetShaderVars), &RenderTargetShaderVars{ .tex_idx = PARTICLE_TEX_ID, .scale = [_]f32{ 10.0, 10.0 } });
        vkCmdDraw(cbuf, num_vertices, @intCast(u32, particle_worlds.len), 0, 0);

        vkCmdBindPipeline(cbuf, VK_PIPELINE_BIND_POINT_GRAPHICS, obj_pipes[pipe_idx]);
        for (powerups.toSlice()) |s| {
            drawObj(cbuf, obj_pipe_layout, num_vertices, RenderTargetShaderVars{
                .frag_color = getPowerupColor(s.mod),
                .tex_idx = getPowerupTexID(s.mod),
                .scale = [_]f32{ POWERUP_SIZE_X, POWERUP_SIZE_Y },
                .position = s.pos,
            });
        }
        drawObj(cbuf, obj_pipe_layout, num_vertices, RenderTargetShaderVars{
            .tex_idx = BALL_TEX_ID,
            .scale = [_]f32{ BALL_SIZE, BALL_SIZE },
            .position = ball_pos,
        });

        vkCmdNextSubpass(cbuf, VK_SUBPASS_CONTENTS_INLINE);
        vkCmdBindPipeline(cbuf, VK_PIPELINE_BIND_POINT_GRAPHICS, post_proc_pipes[pipe_idx]);

        post_proc_vars.delta_time = std.math.min(1.0, std.math.max(post_proc_vars.delta_time - @floatCast(f32, delta_time), 0.0));
        if (post_proc_vars.delta_time == 0.0) {
            post_proc_vars.do_shake = @boolToInt(false);
        }
        vkCmdBindDescriptorSets(cbuf, VK_PIPELINE_BIND_POINT_GRAPHICS, post_proc_pipe_layout, 0, 1, &post_proc_descr.set, 0, null);
        vkCmdPushConstants(cbuf, post_proc_pipe_layout, VK_SHADER_STAGE_VERTEX_BIT | VK_SHADER_STAGE_FRAGMENT_BIT, 0, @sizeOf(@TypeOf(post_proc_vars)), &post_proc_vars);
        vkCmdDraw(cbuf, num_vertices, 1, 0, 0);
        vkCmdEndRenderPass(cbuf);

        checkSuccess(vkEndCommandBuffer(cbuf)) catch unreachable;
        try swapchain.submit(cbuf);

        frame_avgs[timer_idx] = delta_time;
        curr_print_timer += delta_time;
        if (curr_print_timer >= print_timer) {
            curr_print_timer = 0.0;
            timer_idx = 0;
            var avg: f64 = 0.0;
            for (frame_avgs) |f| avg += f;
            avg /= @intToFloat(f64, frame_avgs.len);
            pdbg("ms: {d:.3} fps: {d:.3}\n", .{ avg * 1000, 1 / avg });
        } else {
            timer_idx = (timer_idx + 1) % num_avgs;
        }
        swapchain.swap();
        if (glfwGetKey(window, GLFW_KEY_ESCAPE) == GLFW_PRESS) glfwSetWindowShouldClose(window, GLFW_TRUE);
        glfwPollEvents();
    }
    try waitUntilIdle(device);
}

pub fn drawObj(cbuf: VkCommandBuffer, obj_pipe_layout: VkPipelineLayout, num_vertices: u32, shader_vars: RenderTargetShaderVars) void {
    vkCmdPushConstants(cbuf, obj_pipe_layout, VK_SHADER_STAGE_VERTEX_BIT | VK_SHADER_STAGE_FRAGMENT_BIT, 0, @sizeOf(RenderTargetShaderVars), &shader_vars);
    vkCmdDraw(cbuf, num_vertices, 1, 0, 0);
}

const StaticDescriptor = struct {
    set: VkDescriptorSet,
    layout: VkDescriptorSetLayout,
};

fn createSceneDescriptor(allocator: *Allocator, dev: Context, ortho_buffer: Buffer, descr_pool: VkDescriptorPool, img_refs: []ImageRef) !StaticDescriptor {
    const layout_bindings = &[_]VkDescriptorSetLayoutBinding{
        .{
            .binding = 0,
            .descriptorType = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
            .descriptorCount = 1,
            .stageFlags = VK_SHADER_STAGE_VERTEX_BIT,
        },
        VkDescriptorSetLayoutBinding{
            .binding = 1,
            .descriptorType = VK_DESCRIPTOR_TYPE_SAMPLER,
            .descriptorCount = 1,
            .pImmutableSamplers = null,
            .stageFlags = VK_SHADER_STAGE_FRAGMENT_BIT,
        },
        .{
            .binding = 2,
            .descriptorType = VK_DESCRIPTOR_TYPE_SAMPLED_IMAGE,
            .descriptorCount = @intCast(u32, img_refs.len),
            .pImmutableSamplers = null,
            .stageFlags = VK_SHADER_STAGE_FRAGMENT_BIT,
        },
    };
    const layout_create_info = VkDescriptorSetLayoutCreateInfo{
        .bindingCount = layout_bindings.len,
        .pBindings = layout_bindings,
    };
    var set_layout: VkDescriptorSetLayout = undefined;
    try vks.checkSuccess(vkCreateDescriptorSetLayout(dev.logical, &layout_create_info, null, &set_layout));
    const alloc_info = VkDescriptorSetAllocateInfo{
        .descriptorPool = descr_pool,
        .descriptorSetCount = 1,
        .pSetLayouts = &set_layout,
    };
    var descr_set: VkDescriptorSet = undefined;
    try vks.checkSuccess(vkAllocateDescriptorSets(dev.logical, &alloc_info, &descr_set));
    var ortho_info = VkDescriptorBufferInfo{
        .buffer = ortho_buffer.handle,
        .offset = 0,
        .range = ortho_buffer.size,
    };
    var sampler_info = VkDescriptorImageInfo{
        .imageLayout = .VK_IMAGE_LAYOUT_UNDEFINED,
        .imageView = null,
        .sampler = dev.sampler,
    };

    var tex_info_list = try std.ArrayList(VkDescriptorImageInfo).initCapacity(allocator, img_refs.len);
    defer tex_info_list.deinit();

    for (img_refs) |ref| {
        try tex_info_list.append(.{
            .imageLayout = ref.image.layout,
            .imageView = ref.view,
            .sampler = null,
        });
    }

    const tex_infos = tex_info_list.items;

    const write_sets = &[_]VkWriteDescriptorSet{
        .{
            .dstSet = descr_set,
            .dstBinding = 0,
            .dstArrayElement = 0,
            .descriptorType = VK_DESCRIPTOR_TYPE_UNIFORM_BUFFER,
            .descriptorCount = 1,
            .pBufferInfo = &ortho_info,
        },
        .{
            .dstSet = descr_set,
            .dstBinding = 1,
            .dstArrayElement = 0,
            .descriptorType = VK_DESCRIPTOR_TYPE_SAMPLER,
            .descriptorCount = 1,
            .pImageInfo = &sampler_info,
        },
        .{
            .dstSet = descr_set,
            .dstBinding = 2,
            .dstArrayElement = 0,
            .descriptorType = VK_DESCRIPTOR_TYPE_SAMPLED_IMAGE,
            .descriptorCount = @intCast(u32, tex_infos.len),
            .pImageInfo = tex_infos.ptr,
        },
    };
    vkUpdateDescriptorSets(dev.logical, write_sets.len, write_sets, 0, null);
    return StaticDescriptor{
        .set = descr_set,
        .layout = set_layout,
    };
}

fn isKeyDown(window: *GLFWwindow, key_code: i32) bool {
    return glfwGetKey(window, key_code) == GLFW_PRESS;
}
