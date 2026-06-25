#define version 430

in vec4 gl_FragCoord;

uniform float time;
uniform vec2 resolution;

uniform sampler2D tex;

uniform sampler1D audioL;
uniform int audioLSize;

uniform sampler1D audioR;
uniform int audioRSize;

layout(r32ui, binding = 4) uniform uimage2D atomicImageTexture0;

layout(binding = 5, rgba32f) uniform restrict image2D imageTexture0;
layout(binding = 6, rgba32f) uniform restrict image2D imageTexture1;

out vec4 FragColor;

void main()
{
}