#version 450

#include "postprocess.inc"

layout (location = 0) out vec2 outUV;

void main()
{

    vec2 uv = vec2((gl_VertexIndex << 1) & 2, gl_VertexIndex & 2);
	vec2 pos = uv * 2.0f - 1.0f;
    if (pp_vars.do_chaos) {
        float strength = 0.3;
        outUV = vec2(uv.x + sin(pp_vars.delta_time) * strength, uv.y + cos(pp_vars.delta_time) * strength);
    } else if (pp_vars.do_confuse) {
        outUV = vec2(1.0) - uv;
    } else {
        outUV = uv;
    }

    if (pp_vars.do_shake) {
        float strength = 0.01;
        pos.x += cos(pp_vars.delta_time * 10) * strength;
        pos.y += cos(pp_vars.delta_time * 15) * strength;
    }
    gl_Position = vec4(pos, 0.0, 1.0);
}


