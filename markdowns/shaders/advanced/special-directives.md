# Special Directives

`WayVes` parses the relevant `Shader Files` to process the graphical outputs.

Since the files are split to better segragate the configurations, `WayVes` uses 2 Special Directives similar to `GLava`:

1. `#include`, and
2. `#expand`
 
that can be used to include other `GLSL Configuration Files`, or to statically place loop function calls respectively.

---

<details><summary>Include<h6>Used to include other configuration files.</h6></summary>

It is recommended to place any includes at the top of the file you are placing the directive in.

Imports can be relative, or from the root of the Configuration directory (marked by a prefixed `:`)

If a file named `externalFile.glsl` has the following contents:

```glsl
#define color vec4(1)
#define radius 7
```

Then, after including the file in another Shader file, the contents of `externalFile.glsl` will be placed at the '#include' directive call within that Shader file.

If `externalFile.glsl` is in the same directory as the file that is including it, you can include it like so:

```glsl
#include "externalFile.glsl"     // You can also use '../' to import from the previous directory
// Will compile to the following:
// #define color vec4(1)
// #define radius 7 
```

If `externalFile.glsl` is to be imported from another directory that is present in `$XDG_CONFIG_HOME` directory:

```glsl
#include ":path/to/externalFile.glsl"     
// Will compile to the following:
// #define color vec4(1)
// #define radius 7 
```

As `WayVes` supports supplying any other common configuration .glsl file via the main config.yaml file, to include the config file regardless of the name, use the `:$CONFIGFile` syntax. 

```glsl
#include ":$CONFIGFILE"
// Will include the contents of the supplied .glsl file regardless of the name specified 
```

</details>

---

<details><summary>Expand<h6>Used to statically-unroll looping function calls</h6></summary>

Although looping functionality is quite performant in OpenGL, it is often better to manually call each iteration of the loop, so the compiler can make some improvements.

This can be especially useful in scenarios when you need to add some values over (such as in the provided zOrders files for Linear and Angular Shaders)

The syntax for the directive is as follows:

```glsl
#expand FunctionName numberOfIterations
```

:::info
`numberOfIterations` should be an integer value, or should be a #define variable having an integer value, either in an included file or declared previously within the same file
:::

Example:

```glsl
uniform sampler2D tex;
uniform vec2 resolution;

vec4 averageValue = vec4(0);

void main()
{

#define getValueAtHorizontalOffset(i) averageValue += texture(tex, vec2(i, gl_FragCoord.y) / resolution);
#expand getValueAtHorizontalOffset 5 // Compiles to the following:
// getValueAtHorizontalOffset(0);
// getValueAtHorizontalOffset(1);
// getValueAtHorizontalOffset(2);
// getValueAtHorizontalOffset(3);
// getValueAtHorizontalOffset(4);

// Similar to the loop: for (int i=0; i < 5; i++) getValueAtHorizontalOffset(i);

}
```

</details>


<footer>

[Prev](z-orders.md)
[Next](creating-your-own-shaders.md)

</footer>