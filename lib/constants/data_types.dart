List<String> scalarDataTypes = ["bool", "int", "uint", "float", "double"];
List<String> scalarDataTypeDescriptions = [
  "Specifies whether the value is True or False.",
  "Specifies an integer number. 32-bit.",
  "An unsigned 32-bit integer",
  "Specifies a floating-point number with decimal places; single-precision",
  "(OpenGL 4.0 and above) Double-precision; can store more decimal places",
];

List<String> vectorDataTypes = [
  "bvec2",
  "bvec3",
  "bvec4",
  "vec2",
  "vec3",
  "vec4",
];
List<String> vectorDataTypesDescriptions = [
  "A vector of 2 booleans",
  "A vector of 3 booleans",
  "A vector of 4 booleans",
  "A vector of 2 single-precision floating-point numbers",
  "A vector of 3 single-precision floating-point numbers",
  "A vector of 4 single-precision floating-point numbers",
];

List<String> matrixDataTypes = ["matnxm", "matn", "dmat"];
List<String> matrixDataTypesDescriptions = [
  "A matrix with n columns and m rows (examples: mat2x2, mat4x3). Note that this is backward from convention in mathematics!",
  "Common shorthand for matnxn: a square matrix with n columns and n rows.",
  "(GL 4.0 and above) Double-precision matrices.",
];

List<String> pipeDataTypes = [
  "bool",
  "int",
  "float",
  "double",
  "vec2",
  "vec3",
  "rgb",
  "vec4",
  "rgba",
];
List<String> pipeDataTypesDescriptions = [
  "Boolean",
  "Integer",
  "Float",
  "Double",
  "Vector of 2 values",
  "Vector of 3 values",
  "Vector of 4 values",
  "8-bit RGB Representation",
  "8-bit RGBA Representation",
];
