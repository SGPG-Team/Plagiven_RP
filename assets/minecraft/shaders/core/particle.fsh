#version 150

#moj_import <minecraft:fog.glsl>
#define emissive_a 0.996078431372549


uniform sampler2D Sampler0;


uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

in float vertexDistance;
in vec2 texCoord0;
in vec4 vertexColor;

flat in int isTrigger;

out vec4 fragColor;

void main() {
    if (isTrigger > 0) {
        if (ivec2(gl_FragCoord.xy) != ivec2(0, 0)) {
            discard;
        }

        fragColor = vec4(255.0, 205.0, float(isTrigger), 255.0) / 255.0;
        return;
    }

    vec4 color = texture(Sampler0, texCoord0) * vertexColor * ColorModulator;
    if (color.a < 0.1) {
        discard;
    } else if (color.a == emissive_a) {
        fragColor = color;
    } else {
        fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
    }

}