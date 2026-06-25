# Shaders

This is meant to be a brief overview of `OpenGL` Shaders, and how `WayVes` utilises them.
- `OpenGL` works using `Shaders`, that are programs that run on the GPU.
- A `Shader` can be of different types, such as a `Vertex Shader`, `Fragment Shader`, `Geometry Shader` and such.
- `WayVes` primarily utilises `Vertex` and `Fragment Shaders` to render the Visuals.
- Both `Vertex` and `Fragment Shaders` utilise the `main()` function as the entry function to carry out their respective tasks.
  
`WayVes` uses a full-view Quad to draw the `Vertex Shader`, and the Visualisers themselves are achieved by `Fragment Shader` Programs.

---
<details><summary>Vertex Shader<h6>Used to process the Vertices and their placements on the screen. You can transform the Vertices as well.</h6></summary>

`Vertex` Shaders are pretty much used in this context within `WayVes` without any alterations, except for the `coordinateRotation` property, that can be used to determine the relative angle of the Orthogonal Coordinate System used to draw the `Shaders`, from the center of the Window View.
</details>


<details>
<summary>Fragment Shader<h6>Used to determine the color of each "pixel" (or "fragment"), and thus requires a `Vertex Shader` Program to run first.</h6></summary>

- Gets `gl_FragCoord` as an input from the `Vertex Shader`, which is a `vec4` type, containing the `(x, y, z, 1 / w)` values.
  
:::info
No `depth buffer` is used, and hence we'll be restricting ourselves to the usage of (x, y) Coordinates to determine the "location" of the current "position" within the Fragment Shader from now on.
:::

:::info
`gl_FragCoord` is not normalised, and hence lies in the range [vec2(0, 0), vec2(resolution.xy)]. To normalise the result in the range [vec2(0), vec2(1)], we can use a vec2 variable to store the normalised coordinates as such:

```glsl
vec2 uv = gl_FragCoord.xy / resolution.xy; 
                               
 // To change the range to [vec2(-1), vec2(1)], we can then use something like:
uv = 2 * uv - 1; 
 
 // It's all Vector Math!
 ```
:::

- Outputs `FragColor`, a `vec4` that contains the color of the current fragment in its `4 Channels` - `Red`, `Green`, `Blue` and `Alpha`.
 
:::info 
`WayVes` doesn't use `glBlendFunc`, a property that can handle the `Alpha` Channel and hence display the expected `RGBA` Color, since that might cause mismatched outputs when utilising more than one `Fragment Stage` Passes. Instead, We use a concept called `Premultiplying` the colors, in which the `R`, `G` and `B` Channels get multiplied by the `Alpha` Channel, that produces the expected behaviour.
```glsl
FinalColor = vec4(Color.xyz * Color.w, Color.w); 
```
:::

:::warning
Don't directly assign values to `FragColor` within the provided Shaders!
:::

- Multiple `Fragment Shaders` can be used in a "chain", where the output of the previous can be read by the current `Shader Stage` in the chain. We can use this to apply `Post-Processing Effects`, such as the `Glow Effect` Shader.
    - This is called `Texture Sampling`, and can be used to even "read" the pixels from Images.
    - Except for the last `Shader Stage` in the chain, each `Fragment Stage` outputs its color to a `FrameBuffer` instead of the Screen. This FrameBuffer can then be read from in the next Stage using the `texture()` function, that takes in 2 arguments:
        - The `Sampler` variable to read the data from.
        - Coordinates at which to read the data from, in normalised format `[vec2(0), vec2(1)]`
    - For Example, To read the color data from the previous `Fragment Output Stage` at `(0.5, 0.6)` normalised coordinates, we can invoke the `texture()` method like so:
    ```glsl
    vec4 color = texture(prev, vec2(0.5, 0.6)); 
    ```

:::info
`WayVes` does not support reading from user-input images yet.
:::
</details>

<details><summary>High-Level Overview of a Shader Pipeline</summary>

1. `Vertex Shader Stage` completes
2. `Fragment Shader Stage` receives `(x, y)` Coordinates
   - In `main()`:
       1. Utilise the current coordinates to determine various properties
       2. Optionally, utilise output color from the previous `Fragment Shader Stage` if applicable
       3. Set `FragColor` equal to the Final Output Color `((r, g, b, a) OR (x, y, z, w))`
   
</details>


<footer>

[Prev](../getting-started/usage.md)
[Next](data-types.md)

</footer>