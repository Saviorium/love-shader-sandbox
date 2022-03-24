uniform float time;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 coords = screen_coords/love_ScreenSize.xy;

    vec2 seed = vec2(18.743, 56.845);
    vec2 time_component = vec2(sin(time)+2);
    float random_value = fract(sin(dot(coords, seed * time_component)) * 235345.546);

    return vec4(vec3(random_value), 1.0);
}
