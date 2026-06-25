# Styling

- The styles.css file can be used to specify various aspects for the Shader Windows.
- You can use it to:
  
    - Specify an overall background color to the Window
    
    - Rotate the final output
    
    - Specify the padding / margins of the GL Area within the Window
    
The class name of a Shader Window is the class name you specify within the main configuration yaml file.

:::info
The `.` selector is used for styling the underlying GL Area within the Window that displays the Shader. The `#` selector is used for styling the Window itself
:::

---

<details>
<summary>Examples</summary>

Inverts the final Shader Output on the X Axis for all Shaders with the Class name as `chain_paintable`

```css
.chain_paintable {
    transform: scaleX(-1);
}
```

Rotates the final Shader Output on the Screen for all Shaders with the Class name as `angular`

```css
.angular {
    transform: rotateX(-5deg) rotateY(140deg) rotateZ(170deg);
}
```

</details>


<footer>

[Prev](yaml-specification.md)
[Next](../updating-properties/piping-data.md)

</footer>