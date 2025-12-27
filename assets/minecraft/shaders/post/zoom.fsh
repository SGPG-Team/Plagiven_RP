#version 150

#define RADIUS 0.5
#define SCALE 3.0

uniform sampler2D InSampler;
uniform sampler2D DataSampler;

uniform vec4 ColorModulate;
uniform vec2 OutSize;

in vec2 texCoord;

out vec4 fragColor;

void main() {
    vec2 coord = texCoord;

    vec3 data = round(texelFetch(DataSampler, ivec2(0, 0), 0).rgb * 255.0);
    if (data == vec3(255.0, 205.0, 1.0)) {
        coord = coord * 2.0 - 1.0;

        vec2 coord2 = coord;
        coord2.x *= OutSize.x / OutSize.y;

        if (dot(coord2, coord2) < RADIUS * RADIUS) {
            coord /= SCALE;
        }

        coord = coord * 0.5 + 0.5;
    }

    fragColor = texture(InSampler, coord) * ColorModulate;
}