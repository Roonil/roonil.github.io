<details><summary>Trivial Working Structure</summary>

```glsl
#include "chain/structs.glsl"

#define coordinateRotation 0.

void init()
{
}

void audioFetch(inout float fetchedAudio, float n, float lastN)
{
    // fetchedAudio = the value of the fetched audio sample
    // n = the current audio sample index being processed
    // lastN = the last audio sample index being processed
}

void setProps()
{
}
```
</details>

---

| Property | Description |
| :--- | :--- |
| coordinateRotation | The relative angle of the Orthogonal Coordinate System used to draw the `Shaders`, from the center of the Window View. This is different from a simple Rotation about the Z-Axis, as this is a Coordinate-Basis Transform |


<footer>

[Prev](overview.md)
[Next](life-cycle.md)

</footer>