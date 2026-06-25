<details><summary>Base Form<h6>Represents the `Grid` of the `Particles`.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| type | int | Type of the `Grid` to use. 0 for `Rectangular`, and 1 for `Spherical Grid` arranged as `Concentric Circles` | 0 |
| scale | vec3 | The overall Scaling Factor for the displayed `Grid` in X, Y and Z directions | vec3(2) |
| numParticles | vec3 | The number of `Particles` to render. Maximum number of `Particles` in each Dimension is the size of the window in that dimension | resolution.xy |
| zSize | float | The size of the Window in the Z Axis | 100 |
| rotations | mat3 | The rotations to apply to the `BaseForm` | IDENTITY_MATRIX |
| rotationCenter | vec3 | The center around which the rotations will be applied | vec3(resolution.xy / 2, 0) |
</details>

---

<details><summary>Particle Properties<h6>Represents individual `Particles`.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| color | vec4 | Color of the `Particles` | vec4(0, 0, 1, 1) |
| opacityMultiplier | float | Use this value to affect the Particle's opacity with various parameters | 1 |
| size | int | Size of the `Particles` | 3 |
| feather | float | Feathering or Smoothing of the `Particles`. Between 0 and 1 | 0.5 |
| colorIntensityAddStrength | float | Uses `Add Color Blend mode` to mix colors when `Particles` overlap. Between 0 and 1 | 0.1 |
| antiAlias | float | Change this value in case some color combination produces jagged spherical edges. Greater than 0 | 4.5 |
| position | vec3 |  The position of the `Particle` | - |
</details>

---

<details><summary>Audio Controls<h6>Represents various Audio Settings and captured Audio Data.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| multiplier | float | Determines the strength by which the audio stream affects the inner `Fractal Field` displacements | 7 |
| bassMultiplier | float | Determines the `Sphere's` size change by the audio's lower frequencies | 5 |
| mixing | float | Between 0 and 1. Greater value means stronger reaction to beats or tonal changes in audio | 0.5 |
| bass | float | Audio value corresponding to the lower frequencies is stored here | - |
| exponentiationFactor | float | The Factor that is used to raise the power of the intermediate Audio Data Points, for the 'quickness' of the reactions when there is a sudden change in the playing Frequencies | 1.02 |
| samplePoints[9] | float | The Normalised Points at which Audio Samples are taken for an Intermediate Audio Value that is used to derive the final Audio output value. | {0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9} |
| samplePointsDifferences[9] | float | The Step for the next Audio Sample Point for the current Intermediate Audio Value, which will be used to find the maximum of the Audio Data at this stepped Point and the Point before the difference. | {0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05} |
| intermediateAudios[8] | float | Intermediate Audio Values, stored in Ascending Order of the Intensity of the Frequencies. Used to derive the final driving audio value | - |
| value | float | The Final Audio Value that is derived from the Intermediate Audio Values | - |
</details>

---

<details><summary>Fractal Field Controls<h6>Represents the Underlying `Noise Field`.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| octaveMultiplier | float | Defines the multiplier value with which a `Noise Octave` gets added in to the final `Noise Output`. Higher values produce more peaks and valleys | 0.5 |
| octaveScale | float | Defines the scale of each `Noise Octave` that constitutes the final `Noise Output` | 1.5 |
| complexity | int | Defines the number of `Octaves`, or the number of values that add up in the final `Noise Output`. Higher is slower. | 3 |
| fScale | float | Defines the scale of the overall noise-displaced `Particle Grid`. Higher value gives a 'zoomed-in' view, providing more displaced output | 10 |
| dimensions | vec4 | The dimensions of the `Fractal Field` in `X, Y, and Z` directions along with `time` | vec4(1000) |
| gamma | float | Adjusts the difference between the valleys and peaks of the `Noise Output`, similar to gamma for brightness / contrast values | 1 |
| noiseType | float | Type of noise. 0 is `normal`, while 1 is `abs` | 0 |
| minVal | float | Determines the minimum possible output value of the `Noise` function | -1 |
| maxVal | float | Determines the maximum possible output value of the `Noise` function | 1 |
| offset | float | The offset to add to the overall `Noise` produced | 0 |
| noiseMultiplier | float | Multiplier for generated `Noise` | 1 |
| constantNoiseMultiplier | float | Value that gets added along with the Audio Value to the overall `Noise` generated; can be used to have a non-zero `Noise Output` | 0 |
| affectOpacity | float | Determines the extent to which the `Fractal Field` affects the `Opacity` of the `Particles` | 0 |
| affectSize | float | Determines the extent to which the `Fractal Field` affects the `Size` of the `Particles` | 0 |
| loop | int | Whether to loop the `Fractal Field` after the specified amount of `loopFrames` have passed | 0 |
| loopFrames | int | The Number of Frames after which the `Fractal Field` will loop. `fScale >= loopTime * min(flow.x, flow.y, flow.z, flow.w) / dimensions` should be satisfied for the looping to take place, or you might see unexpected `Noise` values | 200 |
| displacementType | int | The type of the displacement to use. 0 is `Normal Displacement`, and 1 is `Radial Displacement` (strength of the displacement is determined by `displacements.x`) | 0 |
| displacements | vec3 | Displacements in `X,Y and Z` directions | vec3(100) |
| flows | vec4 | `Flow` of the `Fractal Field` in `X, Y and Z` directions, along with `Flow` in `Time` (`Flow Evolution`) | vec4(0, 0, 0, 2) |
| noise | vec3 | The output noise value for each spatial direction `X, Y and Z` | - |
</details>

---

<details><summary>Sphere Controls<h6>Represents the `Sphere` that can displace the `Particles` Radially.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| radius | float | Radius of the `Sphere` | 0 |
| feather | float |  Determines the size of the "band" around the `Sphere`. Between 0 and 1 | 0 |
| strength | float | The Strength with which the particles get pushed (or pulled) from the center of the `Sphere` | 1 |
| center | vec3 | Coordinates of the Center of the `Sphere` | vec3(resolution.xy / 2, 0) |
| scale | vec3 | Scale of the `Sphere` in each Direction | vec3(1) |
</details>


