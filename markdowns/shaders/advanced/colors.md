# Colors

By Default, `GLSL` uses `vec4` data type to represent `RGBA` Colors, and `vec3` to represent `RGB`. All the individual components in the `vectors` are normalized in the range `[0, 1]`. To use a more familiar format for specifying colors, you can include the `colors.glsl` file from the `utils` directory, and use the specified functions to get Colors in a more suitable format.

---

<details><summary><h2>rgb(float r, float g, float b)</h2><h6>Can be used to specify Colors in the `RGB (0 - 255)` range</h6>
</summary>

```glsl
#include ":utils/colors.glsl"

vec3 color = rgb(0, 255, 255); // Cyan

// Each channel value gets divided by 255. You may use float values for finer control
```

</details>
<details><summary><h2>rgba(float r, float g, float b, float a)</h2><h6>Can be used to specify Colors in the `RGBA (0 - 255)` range</h6></summary>

```glsl
#include ":utils/colors.glsl"

vec4 color = rgba(0, 255, 255, 255); // Cyan

// Each channel value gets divided by 255. You may use float values for finer control
color = rgba(0, 255, 255, 127.5); // Cyan at 50% Transparency
```

</details>

---

<details><summary><h2>hsv(float h, float s, float v)</h2><h6>Can be used to specify Colors in the `HSV (0 - 360, 0 - 100, 0 - 100)` range</h6></summary>

```glsl
#include ":utils/colors.glsl"

vec3 color = hsv(128, 100, 100); // Green

// You may use float values for finer control
```

</details>
<details><summary><h2>hsva(float h, float s, float v, float a)</h2><h6>Can be used to specify Colors in the `HSVA (0 - 360, 0 - 100, 0 - 100, 0 - 100)` range</h6></summary>

```glsl
#include ":utils/colors.glsl"

vec4 color = hsva(128, 100, 100, 50); // Green at 50% Opacity

// You may use float values for finer control
```

</details>

---

<details><summary><h2>interpolateHue(vec3 startColor, float hueInterpolation, float bandIndex, float lastBandIndex)</h2><h6>Can be used to specify Interpolated Hue value, starting from `startColor`, and interpolating the value from `bandIndex` to `lastBandIndex`, using `hueInterpolation` (in range `[0, 1]`) as the modifier</h6></summary>

```glsl
#include ":utils/colors.glsl"

vec3 color = interpolateHue(vec3(0.2, 1.0, 0.0), 1, gl_FragCoord.x, resolution.x);
```

</details>
<details><summary><h2>interpolateHue(vec4 startColor, float hueInterpolation, float bandIndex, float lastBandIndex)</h2><h6>`vec4` counter-part of the `interpolateHue()` function<h6></summary>

```glsl
#include ":utils/colors.glsl"

vec4 color = interpolateHue(vec4(0.2, 1.0, 0.0, 0.5), 1, gl_FragCoord.x, resolution.x);
```

</details>


<footer>

[Prev](post-processing.md)
[Next](extras.md)

</footer>