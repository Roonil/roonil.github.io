#include "linear/structs.glsl"

#define coordinateRotation 0
#define fragmentWidth 16

#define visualiserDirections 2
#define visualiserMode 0

#define weight 3.4

void audioFetch(inout float fetchedAudio, int n, int lastN)
{
#define W2 weight* weight
#define EW exp(-W2)

    float d = 1. - fetchedAudio;

    fetchedAudio = ((exp(-d * d * W2) - EW) * (W2));
    fetchedAudio *= 1. - step(abs(fetchedAudio), .005);
}

void init()
{
    audioSettings.mode = 1;

    bar.audio.multiplier = 160;
    bar.mergeLeftBar = int(1. - step(mod(bar.fragment.n, 4), 0));
    bar.mergeRightBar = int(step(mod(bar.fragment.n, 4), 2));
}

void setOffsets(inout vec2 particleOffset, inout vec2 barOffset, inout vec2 barSizeOffset, vec2 barAudio, vec2 particleAudio, float xCoordinate, float n, float lastN)
{
    barOffset.y = -24 + 12. * cos(10.5 * x);
}

void setProps()
{
    bar.size = vec3(5., 9., 5);
    bar.borderSize = vec3(1, 1, 1);

    bar.outerSoftness = vec3(3.3, .1, 3);
    bar.innerSoftness = vec3(2.5, .3, 2.5);

    bar.bottomCenterOffset.y = 95;

    bar.color = mix(vec4(0.0392, 0.0118, 0.0784, 0.301), vec4(0.6627, 0.0706, 0.1686, 0.351), clamp(2. * abs(.5 - bar.fragment.coords.x / resolution.x) / 3., 0, 1));
    bar.borderColor = vec4(1.0, 0.6706, 0.8353, 1.0);

    bar.downCap.enable = true;
    bar.downCap.rate = 0.01;
    bar.downCap.elasticity = .6;
    bar.downCap.launchVelocity = 1.1;
    bar.downCap.acceleration = .3;
    bar.downCap.launchFlingMultiplier = 1.8;
    bar.downCap.width = 8.;
    bar.downCap.height = 1.;
    bar.downCap.offset = vec2(0);
    bar.downCap.color = mix(vec4(0.6471, 0.1176, 0.9294, 0.775), vec4(0.1176, 0.7608, 0.9569, 0.863), clamp(.8 * abs(bar.audio.current.x / bar.fragment.relativeCoords.y), 0, 1));
}

void setParticleDownProps()
{
}

void modifySDFs()
{
}

#define enableGlow true
#define glowSize 3.5
#define glowIntensity .5
#define glowDirections 16.0
#define glowQuality 3.0
#define glowColor vec4(0.0235, 0.2667, 0.3608, 1.0)
#define glowBrightnessOffset .4
#define glowLightStrength 1