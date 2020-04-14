#version 450

layout(set = 0, binding = 0) uniform Transform {
    mat4 transform;
    float pixelation;
};

layout(location = 0) in vec3 left_top;
layout(location = 1) in vec2 right_bottom;
layout(location = 2) in vec2 tex_left_top;
layout(location = 3) in vec2 tex_right_bottom;
layout(location = 4) in vec4 color;

layout(location = 0) out vec2 f_tex_pos;
layout(location = 1) out vec4 f_color;
layout(location = 2) out float f_pixelation;

// generate positional data based on vertex ID
void main() {
    vec2 pos = vec2(0.0);

    float scale_factor = pixelation < 1 ? 1 : pixelation;

    float left = left_top.x * scale_factor;
    float right = right_bottom.x * scale_factor;
    float top = left_top.y * scale_factor;
    float bottom = right_bottom.y * scale_factor;

    switch (gl_VertexIndex) {
        case 0:
            pos = vec2(left, top);
            f_tex_pos = tex_left_top;
            break;

        case 1:
            pos = vec2(right, top);
            f_tex_pos = vec2(tex_right_bottom.x, tex_left_top.y);
            break;

        case 2:
            pos = vec2(left, bottom);
            f_tex_pos = vec2(tex_left_top.x, tex_right_bottom.y);
            break;

        case 3:
            pos = vec2(right, bottom);
            f_tex_pos = tex_right_bottom;
            break;
    }

    f_color = color;
    f_pixelation = pixelation;
    gl_Position = transform * vec4(pos, left_top.z, 1.0);
}
