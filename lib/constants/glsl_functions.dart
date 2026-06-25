List<String> functions = [
  "genType step(genType x, genType y)",
  "genType smoothstep(genType a, float b, float x)",
  "genType mix(genType a, genType b, genType x)",
  "genType clamp(genType x, genType minVal, genType maxVal)",
  "genType min(genType x, genType y)",
  "genType max(genType x, genType y)",
  "genType sin(genType angle)",
  "genType cos(genType angle)",
  "genType tan(genType angle)",
  "genType asin(gentType x)",
  "genType acos(gentType x)",
  "genType atan(genType y, genType x),",
  "genType atan(genType y_over_x)",
];

List<String> functionsDescriptions = [
  "Returns 1.0 if `x` <= `y`, 0.0 otherwise",
  "Performs Smooth Hermite Interpolation of `x` using `a` and `b` as min and max values. Output is in the range `[0, 1]`",
  """`x` should be in the range `[0, 1]`. `x` determines the fractional value of `b` in the final "mixture" of `a` & `b`.
Calculated as `x * b + (1 - x) * a`.
`mix(vec4(0, 0, 1, 1), vec4(1, 0, 0, 1), 0.4)` means `b` (with value `vec4(1, 0, 0, 1)`) constitues 0.4 (or 40%) of the final output""",
  "Input value `x` is returned, and is restricted in the range `[minVal, maxVal]`",
  "Returns the minimum of the two values",
  "Returns the maximum of the two values",
  "Returns the sine value of the `angle`",
  "Returns the cosine value of the `angle`",
  "Returns the tangent value of the `angle`",
  "Returns the angle whose trigonometric sine is `x`. Returned value is in the range `[−π / 2, π / 2]`. The result is undefined if `|x|` > 1",
  "Returns the angle whose trigonometric cosine is `x`. Returned value is in the range `[0, π]`. The result is undefined if `|x|` > 1",
  "Returns either the angle whose trigonometric arctangent is `y` / `x`. The signs of `y` and `x` are used to determine the quadrant that the angle lies in. The value returned by atan in this case is in the range `[−π, π]`. The result is undefined if `x` = 0. ",
  "Returns the angle whose tangent is `y_over_x`. The value returned in this case is in the range `[−π / 2, π / 2]`",
];
