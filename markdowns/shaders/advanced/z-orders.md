# Z-Index Ordering
- `Linear` and `Angular` Shaders expose `Primitives`, that can additionally have `Caps` and / or `Connectors`
- All the `Objects` naturally follow a pre-configured hierarchy in which they appear to be stacked from bottom to top
- This is more prominent when the `Objects` have different Transparency valuesBy default, the `Objects` appear to be stacked from bottom to top as such:


<div class=objects-stack>                
                                
        Only for Angular                        | Inner Circle  
                                                            | Outer Circle

        Bar Group                                  | Bar Background 
                                                            | Inner Bar 
                                                            | Outer Bar 
                                                            | Top Cap 
                                                            | Bottom Cap


        Upper Particle Group                | Inner Particle 
                                                            | Outer Particle
                                                            | Left Inner Connector
                                                            | Right Inner Connector
                                                            | Left Outer Connector
                                                            | Right Outer Connector
                                                            | Cap

        Lower Particle Group                | Inner Particle 
                                                            | Outer Particle
                                                            | Left Inner Connector
                                                            | Right Inner Connector
                                                            | Left Outer Connector
                                                            | Right Outer Connector
                                                            | Cap


</div>

- You can modify each `SDF` or `Shape` for the `Primitives`, `Caps`, and `Connectors` in the `modifySDFs()` function.
- The array `zOrder` defined within `linear/structs.glsl` (and `angular/structs.glsl`) can be manipulated to manually specify the `Z-Index` of each `Object`.
- Additionally, as helper functions, the `Z-Orders` files contain some logic that can rearrange the `Z-Index` for each Object within a `Group` (`Bar`, `Upside Particles` and `Downside Particles`)
- You can import the relevant `Z-Orders` file within your `GLSL Configuration File` (`#include "linear/zOrders.glsl"` or `#include "angular/zOrders.glsl"`), then call the necessary functions from the `modifySDFs()` function.
 
Both `Z-Orders` counter-parts provide 3 different kinds of 'functionalities', namely, setting the `Z-Index` for each `Object / Group`, the `Color Blend Mode` for each `Object` within a `Group`, and `PassThrough` for how 'deep' an `Object` appears within a `Group` when the `Color Blend Mode` is not additive; as if the `Object` at the top 'cuts' the `Object(s)` that is / are beneath it.

Listed below are the functions that `Z-Orders` exposes. These are described for the `Angular` Shader, but except for the `Circle` counter-part, they are the same for the `Linear` Shader. Ensure that for the `Linear` Shader, you pass only 3 parameters to the `setLayerOffsets()` function.

:::warning
It is absolutely necessary that the values provided to the zIndex functions are all different (as they indicate the zIndex for each Object / Group)
:::

:::info
The zIndices that are passed to the functions are all relative, meaning that all the zIndices begin from 0.
:::

| Property | Description |
| :--- | :--- |
| setLayerOffsets(int circleOffset, int barOffset, int particleUpOffset, int particleDownOffset) | Sets the `Z-Index` for each `Group`. `setLayerOffsets(1,3,0,2)` makes the `Bars Group` appear at the top, followed by `Downside Particles`, `Circle`, and finally the `Upside Particles` |

For each `Group`, there are 3 functions, each for setting the `Z-Index` for each `Object` within that `Group` (all different values), for setting the `Color Blend Mode` of each `Object` (either 0 or 1), and for setting the `PassThrough` for each `Intermediate Layer` within that group (by excluding the `top and bottom layers` within that `Group`)

| Property | Description |
| :--- | :--- |
| set\<GroupName\>GroupZIndex(int object1ZIndex, int object2ZIndex, ...) | Sets the `Z-Index` for each `Object` within the `Group`. All passed values must be different, with the lowest value being 0. If the `Group` has 5 Objects in total, then sending in the values 1, 0, 4, 2, 3 will mean that `Object3` will appear at the Top, followed by `Object5`, `Object4`, `Object1` and then `Object2` at the bottom of all `Objects`. |
| set\<GroupName\>GroupCBM(int object1CBM, int object2CBM, ...) | Sets the `Color Blend Mode` for each `Object`, that decides how the `Object` 'below' this `Object` will be rendered, if this `Object` has some Transparency. Each value is either 0 or 1. Setting 1 means that the `Object` below this `Object` will be rendered with the necessary `Alpha Blending` applied. Setting 0 means that the portion of the `Object` below this `Object` won't be rendered, as if this `Object` 'cuts' the `Object` below. The extent of this 'cutting' is specified by the `PassThrough` function. |
| set\<GroupName\>GroupPassThrough(int layer1PassThrough, int layer2PassThrough, ...) | Sets whether the `Object` that 'cuts' this `layer`, should also 'cut' the `layer` beneath. Each value is either 0 or 1. Setting 0 means that the 'cutting' stops at this `layer`. Setting 1 means that the current `layer` should also get 'cut'. This is only effective when an `Object` with CBM 0 is 'cutting' the current `layer`. |


Note that whenever you use any of the `Group Z-Index` functions, you should always call `applyZOrders()` afterwards.

```glsl
modifySDFs() {
// Sets the Z-Index for objects within the upper particle group, such that the particles appear at the top of the connectors (the inner body of the particles as well as their borders)
setParticleUpGroupZIndex(2, 3, 4, 5, 6, 0, 1);
applyZOrders();
}
```


---

<details>
<summary>Circle Group<h6>Available only in the `Angular` Shader</h6></summary>

Mostly Trivial as you should not expect to see any difference as the Inner and Outer Shapes are Mutually Exclusive, but the functions have been provided nonetheless.

```glsl
void setCircleGroupZIndex( int innerCircleZIndex, int outerCircleZIndex )

void setCircleGroupCBM( int innerCircleCBM, int outerCircleCBM )
```

:::info
No Intermediate Layers in this Group, hence no PassThrough() function
:::

</details>

---

<details>
<summary>Bars Group</summary>

```glsl
void setBarGroupZIndex( int barBGZIndex, int innerBarZIndex, int outerBarZIndex, int upperCapZIndex, int lowerCapZIndex )

void setBarGroupCBM( int barBGCBM, int innerBarCBM, int outerBarCBM, int upperCapCBM, int lowerCapCBM )

void setBarGroupPassThrough( int layer1PassThrough, int layer2PassThrough, int layer3PassThrough )
```

</details>

---

<details>
<summary>Upper Particles Group</summary>

```glsl
void setParticleUpGroupZIndex( int innerParticleUpZIndex, int outerParticleUpZIndex, int leftConnectorInnerZIndex, int rightConnectorInnerZIndex,  int leftConnectorOuterZIndex, int rightConnectorOuterZIndex, int capZIndex )

void setParticleUpGroupCBM( int innerParticleUpCBM, int outerParticleUpCBM, int leftConnectorInnerCBM, int rightConnectorInnerCBM,  int leftConnectorOuterCBM, int rightConnectorOuterCBM, int capCBM )

void setParticleUpGroupPassThrough( int layer1PassThrough, int layer2PassThrough, int layer3PassThrough, int layer4PassThrough, int layer5PassThrough )
```

</details>

---

<details>
<summary>Lower Particles Group</summary>

```glsl
void setParticleDownGroupZIndex( int innerParticleDownZIndex, int outerParticleDownZIndex, int leftConnectorInnerZIndex, int rightConnectorInnerZIndex,  int leftConnectorOuterZIndex, int rightConnectorOuterZIndex, int capZIndex )

void setParticleDownGroupCBM( int innerParticleDownCBM, int outerParticleDownCBM, int leftConnectorInnerCBM, int rightConnectorInnerCBM,  int leftConnectorOuterCBM, int rightConnectorOuterCBM, int capCBM )

void setParticleDownGroupPassThrough( int layer1PassThrough, int layer2PassThrough, int layer3PassThrough, int layer4PassThrough, int layer5PassThrough )
```

</details>

---

# Manually overriding Z-Orders and SDFs

For finer control, you can modify the `zOrder` and `sdfs` arrays to get desired outcomes.

Take care to always overwrite `zOrder` array's values in pairs, so that no two entries are the same.

You can manipulate the entries as such:

```glsl
void modifySDFs()
{
    // Changes the Z-Index ordering from
    // BG -> Inner -> Outer
    // to
    // Outer -> BG -> Inner
    // Use colors with some transparency to see the results!

    zOrder[BAR_BG_SDF] = BAR_OUTER_SDF; // Same as zOrder[0] = BAR_OUTER_SDF
    zOrder[BAR_INNER_SDF] = BAR_BG_SDF; // Same as zOrder[1] = BAR_BG_SDF;
    zOrder[BAR_OUTER_SDF] = BAR_INNER_SDF; // Same as zOrder[2] = BAR_INNER_SDF;

    // Note that using the _SDF variables within the square brackets doesn't update their value whenever you use them next here.
    // In this case, if you have to refer to BAR_INNER_SDF using the zOrder array from now on, you'll have to use  zOrder[BAR_OUTER_SDF], as this is where BAR_INNER_SDF sits now.

    // Completely hides downward particles' inner body whenever a Bar's inner body is on top of it.
    // Note that BAR_INNER_SDF is referred to as sdfs[zOrder[BAR_OUTER_SDF]] because of the previous assignment.
    sdfs[zOrder[PARTICLE_DOWN_INNER_SDF]] = clamp(sdfs[zOrder[PARTICLE_DOWN_INNER_SDF]] - sdfs[zOrder[BAR_OUTER_SDF]], 0, 1);

    // Or, you can just use the _SDF variables directly within sdfs array without worrying about previous assignments in this way.
    // sdfs[PARTICLE_DOWN_INNER_SDF] = clamp(sdfs[PARTICLE_DOWN_INNER_SDF] - sdfs[BAR_INNER_SDF], 0, 1);
}
```


<footer>

[Prev](extras.md)
[Next](special-directives.md)

</footer>