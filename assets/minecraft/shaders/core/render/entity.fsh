#version 150

#moj_import <minecraft:light.glsl>
#moj_import <minecraft:fog.glsl>
#moj_import <minecraft:matf.glsl>


uniform sampler2D Sampler0;

uniform vec4 ColorModulator;
uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

uniform mat3 IViewRotMat;
uniform mat4 ModelViewMat;
uniform float GameTime;

uniform vec3 Light0_Direction;
uniform vec3 Light1_Direction;

in float vertexDistance;
in vec4 vertexColor;
in vec4 lightColor;
in vec4 overlayColor;
in vec2 texCoord;
in vec2 texCoord2;
in vec3 Pos;
in float transition;
in vec3 pnormal;
in vec2 pcorner;
flat in vec2 fcorner;
in vec3 Pos1;
in vec3 Pos2;
in vec3 Pos4;
flat in vec3 Pos3;
flat in vec4 col;

flat in int isCustom;
flat in int isGUI;
flat in int isHand;
flat in int noshadow;

out vec4 fragColor;

void main() {
    vec4 color = texture(Sampler0, texCoord);
    float set;

        //custom lighting
        set=0;
        #define ENTITY
        #moj_import<minecraft:objmc_light.glsl>

    if (color.a < 0.01) discard;


    if (set==1) {
        fragColor = color;
    }
    else {
    fragColor = linear_fog(color, vertexDistance, FogStart, FogEnd, FogColor);
    }
}