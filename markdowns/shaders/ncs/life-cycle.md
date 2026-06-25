# Life Cycle 
Functions that are called at particular instances within the NCS Shader

---

<details><summary><h2>init()</h2><h6>Called before the Shader starts taking in the Audio Data.</h6></summary>

```glsl
void init() {
    // Set audio.multiplier and audio.bassMultiplier here
    audio.multiplier = 120;
    audio.bassMultiplier = 190;

    // Set baseForm.type, baseForm.numParticles and baseForm.zSize here
    // Base Form Controls
    baseForm.type = 0;
}
```

</details>

---

<details><summary><h2>setProps()</h2><h6>Sets various visual properties of the Shader and the underlying Fractal Noise Field.</h6></summary>

```glsl
void setProps() {
    // Particle Controls
    particle.color = vec4(0.0353, 0.5216, 0.9725, 0.26);
    particle.size = 4;
    particle.feather = 1;
    particle.colorIntensityAddStrength = 0.4;
    particle.antiAlias = 8.5;

    // Fractal Field Controls
    fractalField.octaveMultiplier = 0.25;
    fractalField.octaveScale = 1.0;
    fractalField.complexity = 3;
    fractalField.fScale = 9.473;
    fractalField.gamma = 1.0;
    fractalField.minVal = -5.0;
    fractalField.maxVal = 5.0;

    // Displacement And Flow Controls
    fractalField.flows = vec4(0, 3.8, 0, 1.3);
    fractalField.displacements = vec3(.3884 * resolution.x, .3884 * resolution.x - 20, .3884 * resolution.x - 5);

    // Sphere Controls
    sphere.radius = .7236 * resolution.x;
    sphere.feather = 0.45;
}
```

</details>

---

<details><summary><h2>modifyNoiseCoordinates()</h2><h6>Changes the coordinates that get passed to the Fractal Noise Function</h6></summary>

```glsl
void modifyNoiseCoordinates(inout vec4 coords) {
    coords.xy *= 2;
}
```

</details>

---

<details><summary><h2>setPropsWithNoise()</h2><h6>Adjusts various parameters after the Noise value has been calculated (stored in `fractalField.noise`)</h6></summary>

```glsl
void setPropsWithNoise() {
    particle.color.y *= length(fractalField.noise);
}
```

</details>

---

<details><summary><h2>modifySphericalDisplacement()</h2><h6>Allows final modification of parameters, after Spherical Displacement has been applied.</h6></summary>

```glsl
void modifySphericalDisplacement() {
    particle.color *= length(particle.position - sphere.center) / sphere.radius;
}
```

</details>


<footer>

[Prev](configuration.md)
[Next](examples.md)

</footer>