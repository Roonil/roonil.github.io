<details><summary>Rotate<h6>Rotates the final output of the Shader</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| angle | float | The angle (in degrees) by which to rotate the output | 90 |
| center | vec2 | The coordinates around which the rotation should take place | vec2(resolution.xy / 2) |
| coords | vec2 | The coordinates of the current Pixel/Fragment being processed. Can be modified. | - |
| transform | mat2 | Additional transformation matrix for complex transformations | IDENTITY_MATRIX |
</details>


