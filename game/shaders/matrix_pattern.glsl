// From exercises of https://thebookofshaders.com/09/
// https://graphicriver.net/item/vector-pattern-scottish-tartan/6590076 this pattern

uniform vec2 mouse_normalized;

vec2 zoom_by_mouse(vec2 coords) {
    float zoom = (1 / max(mouse_normalized.x, mouse_normalized.y));
    return coords * zoom;
}

vec2 rotate2D(vec2 coords, float angle){
    coords -= 0.5;
    coords = mat2(cos(angle),-sin(angle),
                  sin(angle),cos(angle)) * coords;
    coords += 0.5;
    return coords;
}

vec2 translate(vec2 coords, vec2 dxy) {
    return coords + dxy;
}

vec2 zoom(vec2 coords, float scale) {
    return coords * scale;
}

float vertical_line(float value, vec2 point, float from, float to) {
    return value * step(from, point.x) * step(point.x, to); 
}

float horizontal_line(float value, vec2 point, float from, float to) {
    return value * step(from, point.y) * step(point.y, to); 
}

float grid_diagonal_pattern(vec2 point, float cells) {
    point = fract(point); // wraping over 1

    // map coorinates to grid that is discretized by cell size
    vec2 left_top_grid = floor(point*cells)/(cells-1);

    float left_top_distance = left_top_grid.x + left_top_grid.y;
    float right_down_distance = 2.0-left_top_distance;

    float diagonal = step(0.99, left_top_distance) * step(0.99, right_down_distance);
    return diagonal;
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 coords = screen_coords/love_ScreenSize.xy;
    coords = zoom_by_mouse(coords);
    float mouse_angle = atan(mouse_normalized.y-0.5, mouse_normalized.x-0.5);
    coords = rotate2D(coords, mouse_angle);

    vec3 red = vec3(0.86, 0.15, 0.15);
    vec3 gray = vec3(0.75, 0.75, 0.75);
    vec3 white = vec3(1.0, 1.0, 1.0);
    vec3 black = vec3(0.0, 0.0, 0.0);

    float pattern_grid_size = 28.0;
    const int pattern_dimension = 3;
    vec2 pattern_coords = zoom(fract(coords), pattern_grid_size);

    float[pattern_dimension] patterns;
    for(int i=0; i<pattern_dimension; ++i) {
        patterns[i] = grid_diagonal_pattern(translate(pattern_coords, vec2(i * pattern_grid_size / pattern_dimension, 0.0)), pattern_dimension);
    }

    float red_pattern = vertical_line(patterns[2], pattern_coords, 21.0, 22.0);
    red_pattern += horizontal_line(patterns[1], pattern_coords, 6.0, 7.0);
    red_pattern += horizontal_line(patterns[0], pattern_coords, 6.0, 7.0);
    red_pattern = clamp(red_pattern, 0.0, 1.0);
    vec3 result_color = red_pattern*red;

    float gray_pattern = horizontal_line(patterns[0], pattern_coords, 0.0, 6.0);
    gray_pattern += horizontal_line(patterns[1], pattern_coords, 0.0, 6.0);
    gray_pattern += horizontal_line(patterns[0], pattern_coords, 7.0, 13.0);
    gray_pattern += horizontal_line(patterns[1], pattern_coords, 7.0, 13.0);
    gray_pattern += vertical_line(patterns[2], pattern_coords, 15.0, 21.0);
    gray_pattern += vertical_line(patterns[2], pattern_coords, 22.0, 28.0);
    gray_pattern = clamp(gray_pattern, 0.0, 1.0);
    result_color += gray_pattern*gray;

    float white_pattern = vertical_line(patterns[2], pattern_coords, 3.0, 6.0);
    white_pattern += vertical_line(patterns[2], pattern_coords, 9.0, 12.0);
    white_pattern += horizontal_line(patterns[0], pattern_coords, 16.0, 19.0);
    white_pattern += horizontal_line(patterns[1], pattern_coords, 16.0, 19.0);
    white_pattern += horizontal_line(patterns[0], pattern_coords, 22.0, 25.0);
    white_pattern += horizontal_line(patterns[1], pattern_coords, 22.0, 25.0);
    white_pattern = clamp(white_pattern, 0.0, 1.0);
    result_color += white_pattern*white;

    return vec4(result_color, 1.0);
}
