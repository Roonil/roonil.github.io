# Linear

The `Linear` Visualiser represents the Set of `Bars`, `Particles` and `Particle Connectors` that can be drawn on a straight line.

[![Linear Merged Bars Preview](/images/bars_merged_frame0.webp)](/images/bars_merged.webp)
[![Linear Particles Preview](/images/particles_frame0.webp)](/images/particles.webp)
[![Linear Sawtooth Preview](/images/sawtooth_frame0.webp)](/images/sawtooth.webp)

---

# Primitives

A `Bar` or a `Particle` is referred to as a `Primitive`.

A `Primitive` resides in a `Fragment` (this is different from the Fragment in a `Vertex / Fragment Shader`), and has properties that define its size and appearance.

---

# Fragments

A `Fragment` is the division of the total Window View into different 'Columns'. This serves as the housing space for the `Primitives`.

Each `Fragment` has a width that must be a constant throughout the current Frame of the Shader Program, and is represented by `fragmentWidth`.

:::info 
Although both types of `Primitives` have a child structure that represents the `Fragment`, they are essentially the same. They're supplied so for ease of reference.
:::

:::info
Window View : divided into `Fragments` that have a fixed width, `Fragment` : Houses `Bars` and `Particles`
:::

If a `Primitive`'s width exceeds that of the `Fragment`, then the `Primitive` appears as if it's been clipped or cut-off. This is intended, as no two `Primitives` from different `Fragments` can overlap.

This is because `Linear` Shader's logic divides the screen in different sections (`Fragments`) and treats them independently.

---

# Working

In the `Common GLSL Configuration File`, various variables and functions have been laid out that are essential for the `Shader` to Compile.

The variables primarily define:

- The `width` of the `Fragment`,

- The vertical directions of the `Primitives` (Up, Down, or both), and

- Type(s) of `Primitive` to display (`Bar`, `Particle`, or both)

The functions serve as concrete stages in the processing of the `Shader`, and hence allow the specification of different values that affect the `Primitives'` Visuals.

---
[GLSL Structs](include/structs.md)


<footer>

[Prev](../chain/examples.md)
[Next](configuration.md)

</footer>