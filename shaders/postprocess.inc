
layout(push_constant) uniform PP_VARS {
    bool do_chaos;
    bool do_confuse;
    bool do_shake;
    float delta_time;
} pp_vars;
