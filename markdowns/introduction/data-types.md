# Data Types
- `WayVes` utilises OpenGL - driven `Shaders` to draw high - quality Visuals.
- `OpenGL` uses `GLSL` (OpenGL Shading Language), which is a C - typed Language.
- Aside from most of the basic data types from C, there are some additional data types that `GLSL` supports.

The following sections are taken from the official [OpenGL Khronos Wiki](https://wikis.khronos.org/opengl/Data_Type_(GLSL))

---

<details>
<summary>Scalars<h6>Fundamental Data Types</h6></summary>

| Property | Description |
| :--- | :--- |
|bool | Specifies whether the value is True or False.|
|int | Specifies an integer number. 32-bit.|
|uint | An unsigned 32-bit integer | 
float | Specifies a floating-point number with decimal places; single-precision |
|double | (OpenGL 4.0 and above) Double-precision; can store more decimal places |

</details>

---

<details>
<summary>Vectors<h6>Each of the scalar types, including booleans, have 2, 3, and 4-component vector equivalents</h6></summary>

| Property | Description |
| :--- | :--- |
|bvec2 | A vector of 2 booleans
|bvec3 |A vector of 3 booleans | 
bvec4 | A vector of 4 booleans |
|vec2 | A vector of 2 single-precision floating-point numbers |
|vec3 | A vector of 3 single-precision floating-point numbers |
|vec4 | A vector of 4 single-precision floating-point numbers |

---

# Swizzling

You can access the components of vectors using the following syntax:

```glsl
vec4 someVec;
float value = someVec.x + someVec.y;
```

This is called swizzling. You can use x, y, z, or w, referring to the first, second, third, and fourth components, respectively.

:::info
If you initialise a vecn (vec2, vec3, or vec4) variable with just one value, then all components take on that value.
:::

```glsl
vec2 uv = vec2(1);                           // Same as vec2(1, 1);
```

You can also combine smaller vecn variables in the initialisation of a larger one.

```glsl
vec4 Color = vec4(uv, 0, 1);             // x and y components of Color are the same as the x and y components of uv.
```

Or you can Swizzle the components to switch the ordering of the inner vector to the desired order.

```glsl
Color = vec4(uv.yx, uv.xy);              // Color = vec4(uv.y, uv.x, uv.x, uv.y);
```

</details>

---

<details>
<summary>Matrices<h6>Collection of Vectors</h6></summary>

- In addition to vectors, there are also matrix types.
- All matrix types are floating-point, either single-precision or double-precision.
- Matrix types are as follows, where n and m can be the numbers 2, 3, or 4:

| Property | Description |
| :--- | :--- |
| matnxm | A matrix with n columns and m rows (examples: mat2x2, mat4x3). Note that this is backward from convention in mathematics! 
| matn |Common shorthand for matnxn: a square matrix with n columns and n rows. | 
| dmat | (GL 4.0 and above) Double-precision matrices. |

Swizzling does not work with matrices. You can instead access a matrix's fields with array syntax:

```glsl
mat3 theMatrix;
theMatrix[1] = vec3(3.0, 3.0, 3.0);             // Sets the second column to all 3.0s
theMatrix[2][0] = 16.0;                               // Sets the first entry of the third column to 16.0.
```

However, the result of the first array accessor is a vector, so you can swizzle that:

```glsl
mat3 theMatrix;
theMatrix[1].yzx = vec3(3.0, 1.0, 2.0);
```

</details>

---

# Explicit Type Conversion
To cast a data type to another, use `datatype_to_cast_to(variable)`

```glsl
int a = 2;
float b = float(a) / 3;             // a is treated as a float before the division
```


<footer>

[Prev](overview.md)
[Next](glsl-functions.md)

</footer>