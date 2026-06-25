# Tips

Here are some tips that you should keep in mind while running `WayVes` to keep the clutter at the minimum, while ensuring good performance.

---

# Audio Configuration

`WayVes` captures Audio data that goes into the default Audio Sink. Since `PipeWire` supports Virtual Sinks, you can:

1. Set up a Virtual Sink as the default Audio Sink and route all Audio data to that Sink,
2. Set that Sink's latency to a suitable number so that the actual output Audio gets 'synced' with the Visualisers.

:::info 
If you see little Audio reaction in the Visualisers while using YouTube, ensure that the `stable volume` setting on YouTube has been disabled.
:::

---

# Configuration Overrides
Each Shader can take a list of `overrides` from the YAML Configuration file, that can be used to override the constants that are specified with the `#define` directive.

You can use this behaviour for instance to show Red Color for a `Primitive` when some variable has a particular value, and Blue Color when it has some other value. This way, you can avoid unnecessarily duplicating Shader Configuration files if you want different outputs from the same Shader.

For Example, in a Linear Configuration file defined as:

```glsl
#include "linear/structs.glsl" 
 
#define coordinateRotation 0 
#define fragmentWidth 10 
 
#define visualiserDirections 0 
#define visualiserMode 0  // Only Particles

// Rest of the Life Cycle Functions go here
```

Will display Particles, as `visualiserMode` is set to 0.Using the following Shader entry within the YAML Configuration file as such:

```yaml
- name: linear
  overrides:
    - visualiserMode=1
```

Will only display Bars, as `visualiserMode` has been set to 1 by the override.

:::info
You can define your own attributes that can be overriden by the config file to further fine-tune the outcomes
:::

---

# Shader Specification Structure

`WayVes` uses the 'first' instance of a `Shader` within an `Audio Object` (as specified in the `YAML Configuration file`) to drive the underlying Audio updations. The captured Audio Data is applied only for the `Shaders` in the chain that do not specify any `Audio Overrides` themselves.

For this reason, it is recommended to put the `Shaders` with the layer `Overlay` in an `Audio Object` first, as that `Shader` will always render on top of the windows, and the rest of the `Shaders` should follow suit.

Specifying a `Shader` with a `layer` that can be obscured by other Windows might cause it to not get rendered at all, and thus the Audio updation will not work, meaning that all other `Shaders` that are 'driven' by that Audio Data will appear to be stuck.

:::info
For this reason, the `Audio-driving Shader's FPS` also determines the Audio Output variance in the subsequent chained `Shaders`
:::

---

# Making Conditions Branchless

`GLSL` supports conditions, but ideally, there should be as little branching as possible, as the `Shaders` run on the GPU which operate parallelly.

Introducing branches might cause the GPU to 'stall' until the other branch gets completed on a separate invocation in order to provide a coherent result.

Branching on constant conditions should be fine, as the compiler should be smart enough to optimise away any redundant code. Nevertheless, it is often recommended to go as branch-less as possible.

For example, the following branching condition:

```glsl
float a = 10;
float b = 20;

if (a <= b) {
    bar.color = vec4(1, 0, 0, 1); //Red
} else {
    bar.color = vec4(0, 0, 1, 1); //Blue
}
```

Can be evaluated without using the `if-else` blocks entirely, using some built-in `GLSL` functions such as `step()` and `mix()` as follows:

```glsl
float a = 10;
float b = 20;

bar.color = mix(vec4(0, 0, 1, 1), vec4(1, 0, 0, 1), step(a, b));
```

The `genType step(genType a, genType b)` function returns 1 whenever `a`<=`b`, and 0 otherwise. For `vectors`, step will return a `vector` of the same type as the supplied parameters, comparing the values component-wise.

The `genType mix(	genType x, genType y, genType a)` function performs a linear interpolation from `x` to `y`, using the provided factor `a`. You can interpret the returned amount by the fact that `a` is the fraction of `y` that is present in the final combination of `x` and `y`.

Combining these two, our expression essentially acts like a 'switch' due to the `step()` function.

When `a` <= `b`, `step()` returns 1, which means that the returned value from the `mix()` function is the second supplied attribute (Red Color). When `a` > `b`, `step()` returns 0, so the returned value from the `mix()` function is the first supplied  attribute (Blue Color).


<footer>

[Prev](../updating-properties/cli-arguments.md)
[Next](performance.md)

</footer>