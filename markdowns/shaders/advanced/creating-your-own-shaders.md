# Creating your own Shaders

`WayVes` reads `Shaders` that follow the below hierarchy:

<div class=creating-your-own-shaders>


        <directory>Shader Name
        |   <directory>vertex
        |       | <file>1.vert
        |       | <file>2.vert
        |       .
        |       .
        |       .
        |   <directory>fragment
        |       | <file>1.frag
        |       | <file>2.frag
        |       .
        |       .
        |       .
                                                     

</div>

The pair of Vertex and Fragment Shaders get compiled and executed in the order in which they are numbered.

:::info
When `number of Vertex Shader files <= number of Fragment Shader files`, then the default Vertex Shader File will be used:

```glsl
#version 330 core
layout(location = 0) in vec3 aPos;
void main()
{
    gl_Position = vec4(aPos.x, aPos.y, 0.0f, 1.0);
}
```

:::

By using `Shaders` in this way, you can utilise the output of the 'previous' pass and consume it for some `Post-Processing Effects`

---

<details><summary>Uniforms<h6>`WayVes` provides several `uniforms` that can be consumed in a `Shader`.</h6></summary>

| Property | Description |
| :--- | :--- |
| uniform float time | Value of the current frame. When targeting 60 fps, the last frame within the first second should be 60. Supplied as a float for bypassing unnecessary type-casts |
| uniform vec2 resolution | The Resolution of the View, where the resolution.x is windowWidth, and resolution.y is windowHeight |
| uniform sampler1D audioL | 1D Texture containing Audio data for the Left-mapped Audio Channel |
| uniform sampler1D audioR | 1D Texture containing Audio data for the Right-mapped Audio Channel |
| uniform int audioLSize | Size of the Left-mapped Audio Channel |
| uniform int audioRSize | Size of the Right-mapped Audio Channel |
| layout(binding = [0...atomicN], r32ui) uniform uimage2D atomicImageTexture[0...atomicN] | 2D unsigned integer Texture that is used for Atomic Image Load / Store operations. Specify the layout binding in increasing numbers starting from 0, and increase the value of N by 1 for each Atomic Texture you require |
| layout(binding = atomicN + [0...imageN], rgba32f) uniform restrict image2D imageTexture[0...imageN] | 2D 32-bit floating Texture that is used for arbitrary Image Load / Store operations. Specify the layout binding in increasing numbers starting from the number after the last Atomic Texture Binding Number used, and increase the value of N by 1 for each Image Texture you require |
| uniform sampler2D tex | 2D Texture that contains the output of the previous Fragment Shader pass. Available only for Shader Stages 2 and onwards |

:::info
Besides Uniforms, `gl_FragCoord` and `FragColor` are also to be specified to handle input and output values for the current Fragment Shader
:::

</details>

---

<details><summary>Minimal Fragment Shader Example; all Uniforms</summary>

```glsl
#define version 430

in vec4 gl_FragCoord;

uniform float time;
uniform vec2 resolution;

uniform sampler2D tex; // Not available in 1.frag

uniform sampler1D audioL;
uniform int audioLSize;

uniform sampler1D audioR;
uniform int audioRSize;

layout(r32ui, binding = 0) uniform uimage2D atomicImageTexture0;

layout(binding = 1, rgba32f) uniform image2D imageTexture0;
layout(binding = 2, rgba32f) uniform image2D imageTexture1;

out vec4 FragColor;

void main()
{
}
```

</details>


<footer>

[Prev](special-directives.md)
[Next](../../main-configuration/yaml-specification.md)

</footer>