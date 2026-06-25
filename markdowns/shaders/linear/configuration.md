<details><summary>Trivial Working Structure</summary>

```glsl
#include "linear/structs.glsl"

#define coordinateRotation 0
#define fragmentWidth 10

#define leftPadding 0
#define rightPadding 0

#define visualiserDirections 0
#define visualiserMode 0

void init()
{
}

void audioFetch(inout float fetchedAudio, int n, int lastN)
{
    // fetchedAudio = the value of the fetched audio sample
    // n = the current audio sample index being processed
    // lastN = the last audio sample index being processed
}

void setOffsets(float direction, inout vec2 particleOffset, inout vec2 barOffset, inout vec2 barSizeOffset, vec2 barAudio, vec2 particleAudio, float xCoordinate, float n, float lastN)
{  
    // direction = 0 for top Particles, 1 for bottom Particles
    // particleOffset = the offset that will be applied to the particle's position
    // barOffset = the offset that will be applied to the bar's position
    // barSizeOffset = the size offset that will be applied to the bar's size (Upward / Downward height)
    // barAudio = the audio value for the current bar being processed
    // particleAudio = the audio value for the current particle being processed
    // xCoordinate = the x coordinate of the current fragment being processed
    // n = the current bar / particle index
    // lastN = the last bar / particle index
}

void setProps()
{
}

void setParticleDownProps()
{
}

void modifySDFs()
{
}
```

</details>

---
| Property | Description |
| :--- | :--- |
| coordinateRotation | The relative angle of the Orthogonal Coordinate System used to draw the `Shaders`, from the center of the Window View. This is different from a simple Rotation about the Z-Axis, as this is a Coordinate-Basis Transform |
| fragmentWidth | The width of each `Fragment`, that stores a `Primitive` |
| leftPadding | Amount of space that is reserved from the left side |
| rightPadding | Amount of space that is reserved from the right side |
| visualiserDirections | The number of "sides" for the `Primitives`. 0 is only Up, 1 is only Down, 2 is both Up and Down. |
| visualiserMode | Decides the type of `Primitives` to draw. 0 is `Particles`, 1 is `Bars`, 2 is both `Particles` and `Bars`. |

:::warning
Avoid directly using gl_FragCoord for querying coordinates. Instead use `bar.fragment.coords`, or `particle.fragment.coords`
:::


<footer>

[Prev](overview.md)
[Next](life-cycle.md)

</footer>