#version 150

#moj_import <minecraft:light.glsl>
#moj_import <minecraft:fog.glsl>

in vec3 Position;
in vec4 Color;
in vec2 UV0;
in ivec2 UV2;
in vec3 Normal;

uniform sampler2D Sampler0;
uniform sampler2D Sampler2;

uniform float FogStart;
uniform int FogShape;
uniform mat4 ModelViewMat;
uniform mat4 ProjMat;
uniform mat3 IViewRotMat;
uniform vec2 ScreenSize;
uniform float GameTime;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

out float vertexDistance;
out vec4 vertexColor;
out vec4 lightColor;
out vec4 overlayColor;
out vec2 texCoord;
out vec2 texCoord2;
out vec3 Pos;
out float transition;
out vec3 pnormal;
out vec2 pcorner;
flat out vec2 fcorner;
out vec3 Pos1;
out vec3 Pos2;
out vec3 Pos4;
flat out vec3 Pos3;
flat out vec4 col;

flat out int isCustom;
flat out int isGUI;
flat out int isHand;
flat out int noshadow;

#moj_import <minecraft:objmc_tools.glsl>

void main() {
    Pos = Position;
    texCoord = UV0;
    overlayColor = vec4(1);
    lightColor = minecraft_sample_lightmap(Sampler2, UV2);
    vertexColor = minecraft_mix_light(Light0_Direction, Light1_Direction, Normal, Color);
    vec3 normal = (ProjMat * ModelViewMat * vec4(Normal, 0.0)).rgb;
    //objmc
    #define ENTITY
    #moj_import <minecraft:objmc_main.glsl>

    gl_Position = ProjMat * ModelViewMat * (vec4(Pos, 1.0));
    vertexDistance = fog_distance(Pos, FogShape);
    pnormal = Normal * IViewRotMat;
    int quadID = gl_VertexID % 4;

    col = Color;

    Pos3 = Pos4 = Position * IViewRotMat;
    Pos1 = Pos2 = vec3(0);

    if (quadID == 0)
        Pos1 = Position * IViewRotMat;
    if (quadID == 2)
        Pos2 = Position * IViewRotMat;

    const vec2[4] corners = vec2[4](vec2(0), vec2(0, 1), vec2(1, 1), vec2(1, 0));
    pcorner = fcorner = corners[gl_VertexID % 4];
}