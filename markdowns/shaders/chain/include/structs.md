<details><summary>Audio Settings<h6>Represents the various Audio-transformation properties for each side.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| reverseLeft | int | Specifies the reversal of the left audio channel. | 1 |
| reverseRight | int | Specifies the reversal of the right audio channel. | 1 |
| mode | int | 0 for mirrored audio output, where the left half corresponds to the left audio channel and the right half corresponds to the right audio channel. 1 for linear audio output, where the top half represents the right audio channel and the bottom half represents the left audio channel. | 1 |
| combineChannels | int | Specifies whether the audio values should be combined from the left and right channels | 1 |
</details>

---

<details><summary>Audio<h6>Represents Audio Settings and captured Audio Data.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| value | vec2 | Stores the captured Audio Data's left channel data in x, and the right audio channel data in y. | - |
| multiplier | float | Amplification for the audio value | 100 |
</details>

---

<details><summary>Chain<h6>Represents the `Chain` Object.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| heightRatio | float | The Extent of the height of the `Chain`, compared to the total height of the Window | 1 |
| strength | float | The overall visibility of the `Particles` within the `Chain`. Set it to a very low value. Higher values make the displacements broader in height | 0.175 |
| radius | float | The radius of the `Chain` | 15 |
| density | float | The number of `Particles` within a section of the `Chain` | 128 |
| index | float | The index of the current `Particle` in the `Chain`. | - |
| color | vec4 | Color of the `Chain` | vec4(0,1,1,1) |
| interChannelDistance | float | The vertical distance between the top and lower halves of the `Chain`. | 12 |
| channelLineHeight | float | The height of the center line of the `Chain`. | 10 |
| verticalColorDropExtent | float | Determines the color drop-off as `Particles` go vertically away from the `Chain's` center. Between 0 and 1. | 0.02 |
</details>


