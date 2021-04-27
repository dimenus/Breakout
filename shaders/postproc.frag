#version 450

#include "postprocess.inc"

layout(location = 0) in vec2 inUV;

layout(location = 0) out vec4 outColor;


layout(set = 0, binding = 0) uniform sampler2D texSampler;
layout(set = 0, binding = 1) uniform OFFSETS {
    vec2 offsets[9];
    int edge_kernel[9];
    float blur_kernel[9];
} ubo;

const float offset = 1.0 / 300.0;  
vec2 offsets[9] = vec2[](
    vec2(-offset,  offset), // top-left
    vec2( 0.0f,    offset), // top-center
    vec2( offset,  offset), // top-right
    vec2(-offset,  0.0f),   // center-left
    vec2( 0.0f,    0.0f),   // center-center
    vec2( offset,  0.0f),   // center-right
    vec2(-offset, -offset), // bottom-left
    vec2( 0.0f,   -offset), // bottom-center
    vec2( offset, -offset)  // bottom-right    
);
float kernel[9] = float[](
    1.0 / 16, 2.0 / 16, 1.0 / 16,
    2.0 / 16, 4.0 / 16, 2.0 / 16,
    1.0 / 16, 2.0 / 16, 1.0 / 16  
);

void main()
{
    outColor = vec4(0.0f);
    vec3 sampled[9];

    if (pp_vars.do_chaos) {
        for (int i = 0; i < 9; i++) {
            sampled[i] = vec3(texture(texSampler, inUV.st + ubo.offsets[i]));
            outColor += vec4(sampled[i] * ubo.edge_kernel[i], 0.0f);
        }
        outColor.a = 1.0;
    } else if (pp_vars.do_confuse) {
        outColor = vec4(1.0 - texture(texSampler, inUV).rgb, 1.0);
    } else if (pp_vars.do_shake) {
        for (int i = 0; i < 9; i++) {
            sampled[i] = vec3(texture(texSampler, inUV.st + ubo.offsets[i]));
            outColor += vec4(sampled[i] * ubo.blur_kernel[i], 0.0f);
        }
        outColor.a = 1.0;
    } else {
        outColor = texture(texSampler, inUV);
    }
}


