uniform float FogStart;
uniform float FogEnd;
uniform vec4 FogColor;

uniform mat4 ProjMat;

bool isSnowStormProj() {
    return FogEnd > 4.0 && FogEnd < 32.0 && FogColor.rgb == vec3(0.0) && ProjMat[2][3] != 0.0 && FogStart < 1000000.0;
}