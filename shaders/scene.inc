
layout(set = 0, binding = 0) uniform SceneUBO {
    mat4 ortho;
} sceneUBO;

layout(set = 0, binding = 1) uniform sampler defSampler;

layout(set = 0, binding = 2) uniform texture2D objTexture[2];

layout(push_constant) uniform DRAW_VARS {
    vec4 color;
    vec2 position;
    vec2 scale;
    uint tex_idx;
} vars;
