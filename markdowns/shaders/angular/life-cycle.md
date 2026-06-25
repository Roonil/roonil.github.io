# Life Cycle

Functions that are called at particular instances within the Angular Shader

:::info
Both Linear and Angular Visualisers have the same Life Cycle Functions
:::

---

<details><summary><h2>init()</h2><h6>Called before the Shader starts taking in the Audio Data.</h6></summary>

```glsl
void init() {
	// Set all the required audioSettings attributes here
	audioSettings.mode = 1;
	audioSettings.combineChannels = 0;

	// Audio Multipliers
	particle.audio.multiplier = 120;
	bar.audio.multiplier = 220;

	// Set circle.center, circle.maxAngle and circle.angleOffset here
	circle.center = vec2(resolution.xy / 2.);
	circle.maxAngle = 330;
	circle.angleOffset = 120;

	// Enabling Connectors
	particle.connector.left.enable = 1;
	particle.connector.right.enable = 1;

	// Looping the Connectors at the Ends
	particle.connector.loop = 1;

	// Ensuring that the Connectors are always joined at the Ends when looping is enabled, when using arbitrary fragmentAngle values
	particle.connector.mergeEnds = 1;

	// Enabling Merged Bars
	bar.mergeLeftBar = 1;
	bar.mergeRightBar = 1;

	// Additionally, always clamping the ends of the merged bars so that only the borders get shown
	bar.clampLeftMergeBorder = 1;
	bar.clampRightMergeBorder = 1;

	// Or, if clamping for both ends has been disabled, you can opt to always merge the bars at the ends as one
	bar.mergeEnds = 1;
}
```

</details>

---

<details><summary><h2>audioFetch()</h2><h6>Called just after the Audio Data has been fed into the Shader. Fetched Audio is in the normalised Range [0, 1], and after the function returns, gets multiplied by the multiplier values.</h6></summary>
   
```glsl
void audioFetch(inout float fetchedAudio, float n, float lastN) {
	fetchedAudio = 1. - fetchedAudio;
}
```

</details>

---

<details><summary><h2>setOffsets()</h2><h6>Ensures proper Offset Synchronisation when `bar.mergeLeftBar` / `bar.mergeRightBar` or `particle.connector.left.enable` / `particle.connector.right.enable` is set to 1.</h6></summary>
   
```glsl
void setOffsets(float direction, inout vec2 particleOffset, inout vec2 barOffset, inout vec2 barSizeOffset, vec2 barAudio, vec2 particleAudio, float xCoordinate, float n, float lastN) {
	particleOffset.y = 120 * sin(12.5 * x);
	barSizeOffset.x = 9 * mod(int(n), 2);
	barOffset.y = -16 * int(barAudio.x / 16);
}
```

</details>

---

<details><summary><h2>setProps()</h2><h6>Sets various visual properties of the Shader, such as Size, Softness, and Color.</h6></summary>
   
```glsl
void setProps() {
	particle.radius = 12;
	particle.borderSize = 3;
	particle.color = vec4(1);
	particle.borderColor = vec4(1, 0, 0, 1);
}
```

</details>

---

<details><summary><h2>setParticleDownProps()</h2><h6>Can be used to change the properties of the Particles that move downwards.</h6></summary>
   
```glsl
void setParticleDownProps() {
	particle.radius = 4;
	particle.color = vec4(0, 0, 1, 1);
}
```

</details>

---

<details><summary><h2>modifySDFs()</h2><h6>Can be used to change the shapes of all the objects that will be drawn via the Shader. Colors are applied just after this Function.</h6></summary>
   
```glsl
void modifySDFs() {
	sdfs[BAR_INNER_SDF] *= sdfs[PARTICLE_UP_INNER_SDF];
}
```

</details>


<footer>

[Prev](configuration.md)
[Next](examples.md)

</footer>