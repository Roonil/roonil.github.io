#include "angular/structs.glsl"

#define coordinateRotation 0.

#define gapAngle 8.
#define angleOffset 0.

#define maxAngle (360.)
#define restrictCircleAngle false

#define centerCoords vec2(r_resolution / 2.)

void init()
{
}

void audioFetch(inout float fetchedAudio, int n, int lastN)
{
}

void setOffsets(inout vec2 particleOffset, inout vec2 barOffset, inout vec2 barSizeOffset, vec2 barAudio, vec2 particleAudio, float xCoordinate, float n, float lastN)
{
}

void primitiveProps()
{
}

void setParticleDownProps()
{
}

void modifySDFs()
{
}

#define visualiserMode 1
#define visualiserDirections 2

#define enableGlow true
#define glowCenterRotation 0.
#define glowCenterCoords vec2(resolution.xy / 2.)
#define glowOffsetAngle 0.
#define glowSize 9.0
#define glowIntensity 4.5
#define glowDirections 16.0
#define glowQuality 3.0
#define glowColor vec4(0.2549, 0.0118, 0.702, 1.0)
#define glowBrightnessOffset .2
#define glowLightStrength .7