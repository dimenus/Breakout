#version 450
#extension GL_ARB_separate_shader_objects : enable
#include "scene.inc"

layout(location = 0) in vec2 inUV;
layout(location = 1) in vec4 inColor;

layout(location = 0) out vec4 outColor;

void main() {
    vec4 comp_color =  vec4(texture(sampler2D(objTexture[vars.tex_idx], defSampler), inUV));
    outColor = comp_color * inColor; 
}
