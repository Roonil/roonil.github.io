<details><summary>Audio Settings<h6>Represents the various Audio-transformation properties for each side.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| reverseLeft | int | Specifies the reversal of the left audio channel. Either 0 or 1. | 0 |
| reverseRight | int | Specifies the reversal of the right audio channel. Either 0 or 1. | 0 |
| mode | int | 0 for mirrored audio output, where the left half corresponds to the left audio channel and the right half corresponds to the right audio channel. 1 for linear audio output, where the top half represents the right audio channel and the bottom half represents the left audio channel. | 1 |
| combineChannels | int | Specifies whether the audio values should be combined from the left and right channels. Either 0 or 1. | 1 |
</details>

---

<details><summary>Audio<h6>Represents the captured Audio Data, and its multiplier.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| multiplier | float | Amplification for the audio value | 100 |
| current | vec2 | Stores the `Current Fragment's` left audio channel data in x, and the right audio channel data in y. | - |
| prev | vec2 | Stores the `Previous Fragment's` left audio channel data in x, and the right audio channel data in y. | - |
| next | vec2 | Stores the `Next Fragment's` left audio channel data in x, and the right audio channel data in y. | - |
</details>

---

<details><summary>Fragment<h6>Represents the underlying `Fragment` that can show one `Particle` and one `Bar`. None of the Attributes are meant to be modified.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| n | float | Number of the current `Fragment`. Ranges from 0 to `lastN`. | - |
| lastN | float | Number of the last possible Fragment. | - |
| span | float | Span of the Fragment. Lies in `[-fragmentAngle/2.,fragmentAngle/2.]` | - |
| currentAngle | float | Specifies the absolute current Angle. Lies in `[0, TWOPI]` | - |
| coords | vec2 | Specifies the absolute current coordinates. Lies in `[vec2(0,0),vec2(resolution.xy)]` | - |
| currentCenterAngle | float | Specifies the absolute Angle of the `current Fragment's` Center. | - |
| vectorFromCenter | vec2 | Specifies the Vector from the Center of the `Circle`. | - |
| distanceFromCenter | float | Corresponds to length of the Vector from the Center of the `Circle`. | - |
</details>

---

<details><summary>Circle<h6>Represents the `Circle` at the Center.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| maxAngle | float | The Maximum Angle at which the `Circle` should be drawn. | 360 |
| startAnglePadding | float | The start padding for the angle, that will begin drawing the primitives starting from this angle. This will only be relevant if you want to show rounded Connector ends with larger Connector Height and smaller `fragmentAngle`. You can use `angleOffset` otherwise. | 0 |
| endAnglePadding | float | The end padding for the angle, that will be the final angle for the primitives to draw to. This will only be relevant if you want to show rounded Connector ends with larger Connector Height and smaller `fragmentAngle`. You can use `maxAngle` otherwise. | 0 |
| restrictCircleAngle | float | Specifies whether to also restrict the `Circle` when `maxAngle` is smaller than 360. Set to 0 to disable the restriction, or 1 to enable it. | 1 |
| angleOffset | float | Specifies the offset Angle at which to place the `Circle`. | 30 |
| radius | int | Specifies the radius of the `Circle`. | 100 |
| borderSize | int | Specifies the size of the Border of the `Circle`. | 4 |
| innerSoftness | float | Inner Softness of the `Circle`. Higher softness value yields a smoother and blurred edge. | 1.5 |
| outerSoftness | float | Outer Softness of the `Circle`. Higher softness value yields a smoother and blurred edge. | 1.5 |
| center | vec2 | Absolute Coordinates of the Center of the `Circle`. Defaults to the center of the Window, that is, `vec2(resolution.xy/2.)` | vec2(resolution.xy) |
| color | vec4 | Inner Color of the `Circle`. | vec4(0.0, 1.0, 1.0, 1.0) |
| borderColor | vec4 | Outer Color of the `Circle`. | vec4(1.0, 0.0, 0.5, 1.0) |
</details>

---

<details><summary>Cap<h6>Represents a `Cap` that can 'bounce' over a `Primitive` (`Bar` or `Particle`). Requires 1 `Image Texture` to be enabled when `visualiserMode` is either 0 or 1, and requires 2 when`visualiserMode` is 2.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| enable | bool | Specifies whether the `Caps` should be enabled. | false |
| rate | float | The Downwards fall rate for the `Cap`. Constant. | 0.03 |
| elasticity | float | Bounciness of the `Cap` when encountering the Edge of the `Parent Primitive`. | 0.03 |
| type | float | The type of the `Cap`. 0 for `Angular Cap` that changes width based on its height, 1 for `Fixed-Width Cap` | 1 |
| elasticityMinThreshold | float | Minimum 'bounciness' value that is used to immediately put the `Cap` at rest on the `Parent Primitive's` Edge. | 0.6 |
| launchVelocity | float | Upwards Velocity of the `Cap` when the `parent Primitive` moves upwards. | 0.04 |
| size | vec2 | Size of the `Cap`. | vec2(3, 5) |
| acceleration | float | Acceleration for the downwards fall of the `Cap`. | 0.5 |
| launchFlingMultiplier | float | Upwards Thrust of the `Cap` influenced by the current Audio value in the `Fragment`, when the `Parent Primitive` moves upwards. | 0.5 |
| dragFactor | float | Drag factor. Higher values yield a constant downwards terminal velocity for the `Cap`. | 0.01 |
| offset | vec2 | Offset for the `Cap`. Will be added to the coordinates of the `Cap`. | vec2(0,12) |
| audio | vec2 | The audio value that will be used for the `Cap`. `x` stores the left channel for the current `Fragment` and `y` stores the right channel. Each channel is used according to the channel of the `Primitive`. | - |
| softness | vec3 | Softness of the `Cap`. `x, y and z` respectively represent softness values for the `top`, `left & right`, and `bottom` edges. Higher softness value yields a smoother and blurred edge. | vec3(1, 1.5, 1) |
| color | vec4 | Color of the `Cap`. | vec4(1, 0, 0, 0) |
</details>

---

<details><summary>Connector Half<h6>Represents the left and right sides of a `Connector`.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| enable | int | Specifies whether the `Connector Half` should be enabled. | 0 |
| height | float | Height of the `Connector Half`. | 3 |
| borderSize | float | BorderSize of the `Connector Half`. | 2 |
| innerSoftness | float | Inner Softness of the `Connector Half`. Higher softness value yields a smoother and blurred edge. | 0.5 |
| outerSoftness | float | Outer Softness of the `Connector Half`. Higher softness value yields a smoother and blurred edge. | 0.5 |
| color | vec4 | Inner Color of the `Connector Half`. | vec4(1.0, 1.0, 0.0, 1.0) |
| borderColor | vec4 | Outer Color of the `Connector Half`. | vec4(1.0, 1.0, 1.0, 1.0) |
</details>

---

<details><summary>Connector<h6>Represents the combination of left and right `Connectors`.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| left | ConnectorHalf | Left `Connector Half` | - |
| right | ConnectorHalf | Right `Connector Half` | - |
| jointMode | int | Joint Mode | 1 |
| jointColorMode | int | Joint Color Mode | 0 |
| leftCenter | vec2 | Stores the coordinates of the `Particle` in the `Left Fragment`. | - |
| currentCenter | vec2 | Stores the coordinates of the `Particle` in the `Current Fragment`. | - |
| rightCenter | vec2 | Stores the coordinates of the `Particle` in the `Right Fragment`. | - |
| loop | int | Whether to loop the `Connectors` for the first and last `Particles`, when `left Connector Half` is enabled or `right Connector Half` is enabled for the last `Particle`. Does not necessarily create merged `Connectors` at all `fragmentAngle` values. | 1 |
| mergeEnds | int | 1 to specify whether the first and last `Connectors` should be merged, when `left Connector Half` is enabled or `right Connector Half` is enabled for the last `Particle`. | 1 |
</details>

---

<details><summary>Bar<h6>Represents a `Bar`.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| fragment | Fragment | Stores the current `Fragment`. | - |
| audio | Audio | Stores captured Audio Data. | - |
| upCap | Cap | Stores the `Top Cap` for the `Bar`. | - |
| downCap | Cap | Stores the `Bottom Cap for the Bar`. | - |
| type | int | Specifies the type of `Bars` to draw: 0 for `Angular`, 1 for `Rectangular` and 2 for `Rounded`. Only `Angular` and `Rectangular Bars` can be merged. | 1 |
| mergeLeftBar | int | Specifies merging of the `Bar` on the Left. Either 0 or 1. | 1 |
| mergeRightBar | int | Specifies merging of the `Bar` on the Right. Either 0 or 1. | 1 |
| mergeEnds | int | 1 to specify whether the first and last `Bars` should be merged, when `mergeLeftBar` is 1 or mergeRightBar is 1 for the last Bar. `clampLeftMergeBorder` and `clampRightMergeBorder` should both be 0 for this setting to take effect. | 1 |
| clampLeftMergeBorder | int | 1 to specify left Border to be always present on the very first `Bar`, when `mergeLeftBar` is 1. | 1 |
| clampRightMergeBorder | int | 1 to specify right Border to be always present on the very last `Bar`, when `mergeRightBar` is 1. | 1 |
| offset | vec2 | Specifies the offset of the `Bar`. Added to `Bar's` coordinates. | vec2(0,-12) |
| size | vec3 | Specifies the Size of the `Bar`. `x, y and z` represent the minimum upwards height, horizontal size, and the minimum downwards height. | vec3(3, 12, 3) |
| borderSize | vec3 | Specifies the BorderSize of the `Bar`. `x, y and z` represent the top, left & right, down side Borders. | vec3(1, 2, 1) |
| innerSoftness | vec3 | Softness of the Inner Edge of the `Bar`. `x, y and z` respectively represent softness values for the `top`, `left & right`, and `bottom` edges. Higher softness value yields a smoother and blurred edge. | vec3(0.5) |
| outerSoftness | vec3 | Softness of the Outer Edge of the `Bar`. `x, y and z` respectively represent softness values for the `top`, `left & right`, and `bottom` edges. Higher softness value yields a smoother and blurred edge. | vec3(0.5) |
| color | vec4 | Specifies the Inner Color of the `Bar`. | vec4(0,1,1,1) |
| borderColor | vec4 | Specifies the Outer Color of the `Bar`. | vec4(0.0, 1.0, 0.5, 1.0) |
| bgColor | vec4 | Specifies the background Color over which `Bars` are displayed. | vec4(0.5) |
</details>

---

<details><summary>Particle<h6>Represents a `Particle`.</h6></summary>

| Property | Data Type | Description | Example |
| :--- | :---: | :---: | :--- |
| fragment | Fragment | Stores the current `Fragment`. | - |
| audio | Audio | Stores captured Audio Data. | - |
| cap | Cap | Stores the `Cap` for the `Particle`. | - |
| connector | Connector | Stores `Connector` Settings. | - |
| reverseBottomOffset | int | Specifies whether the bottom offset value provided should be inverted for the `Bottom Particles`. | 1 |
| radius | float | Specifies the radius of the `Particle`. | 3 |
| borderSize | float | Specifies the borderSize of the `Particle`. | 2 |
| interChannelDistance | float | Specifies the vertical distance between the `Top and Bottom Particles` | 12 |
| innerSoftness | float | Specifies the inner Softness of the `Particle`. Higher softness value yields a smoother and blurred edge. | 0.5 |
| outerSoftness | float | Specifies the inner Softness of the `Particle`. Higher softness value yields a smoother and blurred edge. | 0.5 |
| offset | vec2 | Specifies the offset of the `Particle`. Added to the coordinates of the `Particle`. Use `setOffsets()` to properly show connectors if enabled. | vec2(1,12) |
| color | vec4 | Inner Color of the `Particle`. | vec4(1, 0, 0, 1) |
| borderColor | vec4 | Outer Color of the `Particle`. | vec4(1, 1, 1, 1) |
</details>


