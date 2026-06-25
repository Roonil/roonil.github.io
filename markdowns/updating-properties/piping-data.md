# Piping Data

- `WayVes` supports supplying in dynamic values for its `Shaders`. This is achieved by using `Named Pipes`.
- For a variable to be eligible for dynamic overrides in this way, it should be declared as a `uniform`.
- `uniforms` are always declared globally, so they should be declared outside any functions.

For Example, if you want to supply `visualiserDirections` as a dynamic input, then in the Shader Configuration File,

change :

```glsl
#define visualiserDirections 0 
```

to

```glsl
uniform int visualiserDirections = 0; 
```

You can then pass in data using external scripts to manipulate `visualiserDirections`

Pipe the data you want to send in the `/tmp/WayVes/<ShaderClass>` file. Data should be in the form:

```txt
variableName1 = variableValue1
variableName2 = variableValue2
.
.
.
```

:::info
Use the '\n' escape sequence to go to the next line while writing data to the pipe.
:::

You can also pass in colors in the same way. Just define an attribute with a suitable name as a `uniform`:

```glsl
uniform vec4 dynamicColor = vec4(1, 0, 0, 1);             // vec4(1, 0, 0, 1) serves as the initial value here
```

Consume the value where you want in the `Shader`:

```glsl
bar.color = dynamicColor; 
```

Then, you can write to the pipe `/tmp/WayVes/linear` (assuming the className is `linear`):

```bash
echo "dynamicColor = vec4(0, 0, 1, 1)" >> /tmp/WayVes/linear 
```

Bars' color will change from Red to Blue in this case.

:::warning
`hsv / hsva` cannot be used as `uniforms`, and hence cannot be piped in. Instead use `vec4 / vec3` or `rgba / rgb`.
:::

---

<details><summary>Supported Data Types</summary>

| Property | Description |
| :--- | :--- |
| bool | Boolean | 
| int | Integer
| float | Float | 
| double | Double | 
| vec2 | Vector of 2 values | 
| vec3 | Vector of 3 values | 
| rgb | 8-bit RGB Representation | 
| vec4 | Vector of 4 values | 
| rgba | 8-bit RGBA Representation |

:::warning
vecn needs to be supplied in with all n values. vec2(1) will not be accepted, however vec2(1, 1) will be.
:::

</details>

---

# Reloading Configurations
- `WayVes` uses named instances to identify the group of Shaders that can be targeted for a reload.
- Supply an instance name while launching `WayVes` by supplying the `-i` flag along with the name to identify the Instance with.
- All `Audio` Object names within an instance must be unique. You can run different invocations of the same instance as long as their `Audio` Object names are all different. 
- To target a reload for an instance, you need to pipe in the name of the new YAML file from which to read the new Spec that will replace the Shaders for that instance.
- This is useful if you dynamically want to change the number and types of Shaders based on any runtime attribute.
- For an instance with name instanceName, the pipe is present at `/tmp/WayVes/instance_instanceName`
- For example, if you want to target the instance `desktop` and reload its contents with the Shaders specification defined in a file `newShaderSpec.yaml`, then:

```bash
echo "reload = newShaderSpec" >> /tmp/WayVes/instance_desktop 
```

:::warning
Use instance reloading sparingly, as spamming too many reloads for a single instance might lead to inconsistencies
:::



<footer>

[Prev](../main-configuration/styling.md)
[Next](cli-arguments.md)

</footer>