# Life Cycle

Functions that are called at particular instances within the Chain Shader

---

<details><summary><h2>init()</h2><h6>Called before the Shader starts taking in the Audio Data.</h6></summary>
   
```glsl
void init() {
    // Set audio.multiplier and chain.density here
    chain.density = 256;
    audio.multiplier = 1.2;
}
```

</details>

---

<details><summary><h2>audioFetch()</h2><h6>Called just after the Audio Data has been fed into the Shader. Fetched Audio is in the normalised Range [0, 1], and after the function returns, gets multiplied by the multiplier values.</h6></summary>
   
```glsl
void audioFetch(inout float fetchedAudio, float n, float lastN) {
    fetchedAudio *= .5;
}
```

</details>

---

<details><summary><h2>setProps()</h2><h6>Sets various visual properties of the Shader, such as Strength and Color.</h6></summary>
   
```glsl
void setProps() {
    chain.channelLineHeight = max(0, 1. - audio.value.x);
    chain.color = interpolateHue(vec4(0, 0.4, 1, 0.03), .05, 15 * (resolution.x - chain.index) * audio.value.x, resolution.x);
}
```


</details>


<footer>

[Prev](configuration.md)
[Next](examples.md)

</footer>