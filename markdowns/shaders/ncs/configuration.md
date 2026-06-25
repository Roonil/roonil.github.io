# Trivial Working Structure

```glsl
#include "ncs/structs.glsl"

#define colorTracking 0

void init()
{
}

void setProps()
{
}

void modifyNoiseCoordinates(inout vec4 coords)
{
    // coords = the Coordinates that will be used to calculate the Noise Value
}

void setPropsWithNoise()
{
}

void modifySphericalDisplacement()
{
}
```

---

| Property | Description |
| :--- | :--- |
| colorTracking | Set to 1 to use 4 separate `Atomic Textures` to store the Color Information per `Particle`. Very expensive. |


<footer>

[Prev](overview.md)
[Next](life-cycle.md)

</footer>