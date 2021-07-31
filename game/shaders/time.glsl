uniform float time;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    return vec4(abs(sin(time)), 0.0, 0.0, 1.0);
}
