#version 450

layout(set = 0, binding = 1) uniform sampler font_sampler;
layout(set = 0, binding = 2) uniform texture2D font_tex;

layout(location = 0) in vec2 f_tex_pos;
layout(location = 1) in vec4 f_color;
layout(location = 2) in float f_pixelation;

layout(location = 0) out vec4 Target0;

void main() {
    float alpha = texture(sampler2D(font_tex, font_sampler), f_tex_pos).r;

    if ((alpha <= 0.0) || (f_pixelation != -1 && alpha < 0.5)) {
        discard;
    }

    if (f_pixelation != -1) {
        alpha = 1;
    }


    Target0 = f_color * vec4(1.0, 1.0, 1.0, alpha);
}
