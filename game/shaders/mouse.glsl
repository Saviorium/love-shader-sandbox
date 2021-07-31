uniform vec2 mouse_coords;

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    return vec4(vec3(step(mouse_coords.x, screen_coords.x)*step(mouse_coords.y, screen_coords.y)), 1.0);
}
