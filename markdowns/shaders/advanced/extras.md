# Noise Functions

You can find many noise function implementations within the `utils/lygia/generative` folder, and some other math functions within the `utils/lygia/math` folder originally created by `lygia`, check [here](https://lygia.xyz/)

The `NCS` Shader utilises the `4-D Tileable Perlin Noise` implementation from this library.

---

# Coordinate System Rotation

`Angular`, `Linear`, and `Chain` Shaders have a `coordinateRotation` property, that represents the `angle` of the Coordinate System.

This is useful when you want the `Bars` to go from left to right instead of from down to up, for instance.

This effect is achieved within the `Vertex Shader`. The Vertex Shader File `rotatedCoordinatesVertex.vert` present in the `utils` directory is used as the `Vertex Shader`.

This `Vertex Shader` exposes `r_ngl_FragCoord` (normalised in range `[vec4(0), vec4(1)]`) and `r_resolution` attributes that are essentially the rotated counter-parts of `gl_FragCoord` and `resolution` parameters.

From `r_ngl_FragCoord`, `r_gl_FragCoord` is derived within the `Fragment Shader`. This has to be done in the `Fragment Shader` as otherwise the `Shader Rasterisation` can lead to weird artifacts if this step is done within the `Vertex Shader` itself.

In the `GLSL Configuration Files`, you can use `r_gl_FragCoord` and `r_resolution` instead of `gl_FragCoord` and `resolution` to ensure that the outputs stay consistent with any arbitrary `coordinateRotation` angles.

For example, to make the `Bars` and `Particles` in `Linear` go from left to right, use:

```glsl
#define coordinateRotation 90
```

:::info
`fragment.coords` in `Linear` and `Angular` automatically resolve to `r_gl_FragCoord`
:::


<footer>

[Prev](colors.md)
[Next](z-orders.md)

</footer>