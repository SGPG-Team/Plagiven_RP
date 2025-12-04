#version 150

#moj_import <minecraft:fog.glsl>

in vec3 Position;
in vec2 UV0;
in vec4 Color;
in ivec2 UV2;

uniform sampler2D Sampler2;

uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform int FogShape;
uniform vec2 ScreenSize;

out float vertexDistance;
out vec2 texCoord0;
out vec4 vertexColor;

flat out int isTrigger;

const vec2[] corners = vec2[](
    vec2(0, 0), vec2(1, 0),
    vec2(1, 1), vec2(0, 1)
);

void main() {
    gl_Position = ProjMat * ModelViewMat * vec4(Position, 1.0);

    isTrigger = int(round(Color.rgb * 255.0) == vec3(143.0, 21.0, 205.0)) + 2 * int(round(Color.rgb * 255.0) == vec3(143.0, 21.0, 206.0));
    if (isTrigger > 0) {
        vec2 xy = (corners[gl_VertexID % 4] / ScreenSize) * 2.0 - 1.0;
        gl_Position = vec4(xy, isTrigger == 2 ? -1.0 : -0.999999, 1.0);
    }

    vertexDistance = fog_distance(Position, FogShape);
    texCoord0 = UV0;
    vertexColor = Color * texelFetch(Sampler2, UV2 / 16, 0);
}