<details><summary>Glow<h6>Adds a Glowing Effect to the final output of the Shader.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| blendMode | float | Blend mode for the glow effect. 0 = Additive, 1 = Overlay | 0 |
| mixAlpha | float | Whether to use the Alpha Channel for the Glow Effect | 1 |
| offsetAngle | float | Offset (in degrees) for Glow directions | 90 |
| maxAngle | float | Max Angle (in degrees) for Glow directions | 360 |
| size | vec2 | Size of the Glow | vec2(10,10) |
| intensity | float | Intensity of the Glow | 0.5 |
| directions | float | Number of directions that are sampled radially. Higher is expensive. | 4 |
| coords | vec2 | The coordinates of the current Pixel/Fragment being processed. Can be modified. | - |
| quality | float | Quality of Glow. Higher is expensive. | 8 |
| color | vec4 | Overlay color for the Glow Effect | vec4(1.0, 1.0, 1.0, 1.0) |
| brightnessOffset | float | Adjusts brightness of the final Color | 0. |
| lightStrength | float | Brightens or darkens the opacity of the final Color | .5 |
| onTop | float | Whether to stack glow on top or below the sampled output | 0 |
</details>


