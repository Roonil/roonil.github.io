<details><summary>Classic Bars<h6>Standard, Vertical Bars with Blue Inner Color and White Border Color</h6></summary>

```glsl
#include "linear/structs.glsl"

#define coordinateRotation 0
#define fragmentWidth 10                  // Fragment Width is 10

#define leftPadding 0
#define rightPadding 0

#define visualiserMode 1                  // Show only Bars
#define visualiserDirections 0        // Show only the Top Direction

void init()
{
    // Set audio multiplier for Bars
    bar.audio.multiplier = 50;
}

void audioFetch(inout float fetchedAudio, int n, int lastN)
{
}

void setOffsets(float direction, inout vec2 particleOffset, inout vec2 barOffset, inout vec2 barSizeOffset, vec2 barAudio, vec2 particleAudio, float xCoordinate, float n, float lastN)
{  
}

void setProps()
{
    // Each Bar will have a starting height in vertically-up direction with a value of 12 Pixels, width of 5 Pixels and no vertically-downwards height
    bar.size = vec3(12, 5, 0);

    // The Outer Border of each Bar (Top, Left & Right, and Downwards) will respectively be of sizes 5, 1, and 2 Pixels 
    bar.borderSize = vec3(5, 1, 2);

    // The Inner Color of each Bar will be Blue with Opacity 1
    bar.color = vec4(0, 0, 1, 1); 

    // The Border or Outer Color of each Bar will be White with Opacity 1
    bar.borderColor = vec4(1);

    // Uncomment to use Rounded Bars. Rounded Bars use the y component of borderSize, outerSoftness and innerSoftness to use the respective values.
    // bar.type = 1;
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

<details><summary>Particles<h6>Particles with Red Inner Color and Yellow Border Color</h6></summary>


```glsl
#include "linear/structs.glsl"

#define coordinateRotation 0
#define fragmentWidth 15                   // Fragment Width is 15

#define leftPadding 0
#define rightPadding 0

#define visualiserMode 0                  // Show only Particles
#define visualiserDirections 2         // Show Particles in both Directions


void init()
{
    // Set audio multiplier for Particles
    particle.audio.multiplier = 50;
}

void audioFetch(inout float fetchedAudio, int n, int lastN)
{
}

void setOffsets(float direction, inout vec2 particleOffset, inout vec2 barOffset, inout vec2 barSizeOffset, vec2 barAudio, vec2 particleAudio, float xCoordinate, float n, float lastN)
{  
}

void setProps()
{
    // Each Particle will have a radius of 4 Pixels, and an outer Border of 2 Pixels
    particle.radius = 4;
    particle.borderSize = 2;

    // Each Particle will have Red Inner Color with Full Opacity
    particle.color = vec4(1, 0, 0, 1);
    
    // Each Particle will have Yellow Border Color with Full Opacity
    particle.borderColor = vec4(1, 1, 0, 1);
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

<details><summary>Merged Bars<h6>Vertically-downward Bars where every 4 are 'grouped' or 'merged' together, along with Caps that follow Newtonian Physics to simulate Acceleration, Air Drag Factor and such. The Bars are also offseted by a Cosine Function.</h6></summary>

```glsl
#include "linear/structs.glsl"

#define coordinateRotation 0
#define fragmentWidth 16

#define leftPadding 0
#define rightPadding 0

#define visualiserDirections 2
#define visualiserMode 0

#define weight 3.4

void audioFetch(inout float fetchedAudio, int n, int lastN)
{
#define W2 weight* weight
#define EW exp(-W2)

    float d = 1. - fetchedAudio;

    fetchedAudio = ((exp(-d * d * W2) - EW) * (W2));
    fetchedAudio *= 1. - step( abs(fetchedAudio), .005 );
}

void init()
{
    audioSettings.mode = 1;

    bar.audio.multiplier = 160;
    bar.mergeLeftBar = int(1. - step( mod(bar.fragment.n, 4), 0));
    bar.mergeRightBar = int( step( mod(bar.fragment.n, 4), 2));
}

void setOffsets(float direction, inout vec2 particleOffset, inout vec2 barOffset, inout vec2 barSizeOffset, vec2 barAudio, vec2 particleAudio, float xCoordinate, float n, float lastN)
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

    bar.color = mix(
      vec4(0.0392, 0.0118, 0.0784, 0.301),
      vec4(0.6627, 0.0706, 0.1686, 0.351), 
      clamp(2. * abs(.5 - bar.fragment.coords.x / resolution.x) / 3., 0, 1));

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
```

</details>

<footer>

[Prev](life-cycle.md)
[Next](../angular/overview.md)

</footer>