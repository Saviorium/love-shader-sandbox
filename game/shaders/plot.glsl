// https://thebookofshaders.com/05/

uniform vec2 mouse_normalized;

const float LINE_THICKNESS = 0.01;

float funct(float x) {
    return fract(sin(x*10)*1.0);;
}

float plot(vec2 coords, float value, float next_value) {
    float upper = max(value, next_value);
    float lower = min(value, next_value);
    return smoothstep( lower-LINE_THICKNESS, lower, coords.y) -
           smoothstep( upper, upper+LINE_THICKNESS, coords.y);
}

vec4 effect(vec4 color, Image tex, vec2 texture_coords, vec2 screen_coords)
{
    vec2 coords = screen_coords/love_ScreenSize.xy;

    float y = funct(coords.x);
    float dy = funct(coords.x + LINE_THICKNESS);
    
    vec3 result_color = vec3(y);
    float plot_line = plot(coords, y, dy);
    result_color = (1.0-plot_line)*result_color+plot_line*vec3(0.0,1.0,0.0);

    return vec4(result_color, 1.0);
}
