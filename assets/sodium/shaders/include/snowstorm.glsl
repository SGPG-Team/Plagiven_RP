uniform float u_FogStart;
uniform float u_FogEnd;
uniform vec4 u_FogColor;


bool isSnowStormProj() {
    return
    u_FogEnd > 4.0
    && u_FogEnd < 32.0
    && u_FogStart < 1000000.0;
}