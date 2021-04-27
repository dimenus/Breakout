#version 450

#include "scene.inc"

layout (location = 0) in vec2 inVertPos;
layout (location = 1) in vec2 inTexUV;

layout (location = 2) in vec4 inInstColor;
layout (location = 3) in vec2 inInstPos;

layout (location = 0) out vec2 outUV;
layout (location = 1) out vec4 outColor;

out gl_PerVertex 
{
    vec4 gl_Position;   
};

void main() 
{
    outUV = inTexUV;
    outColor = inInstColor;
    gl_Position = sceneUBO.ortho * vec4((inVertPos * vars.scale) + inInstPos, 0.0, 1.0);
}
