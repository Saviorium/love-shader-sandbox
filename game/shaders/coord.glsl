vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 coords = screen_coords/love_ScreenSize.xy;

    return vec4(coords.x, coords.y, 0.0, 1.0);
}
