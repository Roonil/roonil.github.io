List<String> baseVariables = [
  "coordinateRotation",
  "fragmentWidth",
  "leftPadding",
  "rightPadding",
  "visualiserDirections",
  "visualiserMode",
];
List<String> baseVariablesDescriptions = [
  "The relative angle of the Orthogonal Coordinate System used to draw the `Shaders`, from the center of the Window View. This is different from a simple Rotation about the Z-Axis, as this is a Coordinate-Basis Transform",
  "The width of each `Fragment`, that stores a `Primitive`",
  "Amount of space that is reserved from the left side",
  "Amount of space that is reserved from the right side",
  "The number of \"sides\" for the `Primitives`. 0 is only Up, 1 is only Down, 2 is both Up and Down.",
  "Decides the type of `Primitives` to draw. 0 is `Particles`, 1 is `Bars`, 2 is both `Particles` and `Bars`.",
];

List<String> angularBaseVariables = [
  "coordinateRotation",
  "fragmentAngle",
  "visualiserDirections",
  "visualiserMode",
];
List<String> angularBaseVariablesDescriptions = [
  "The relative angle of the Orthogonal Coordinate System used to draw the `Shaders`, from the center of the Window View. This is different from a simple Rotation about the Z-Axis, as this is a Coordinate-Basis Transform",
  "The angle of each `Fragment`, that stores a `Primitive`",
  "The number of \"sides\" for the `Primitives`. 0 is only Up, 1 is only Down, 2 is both Up and Down.",
  "Decides the type of `Primitives` to draw. 0 is `Particles`, 1 is `Bars`, 2 is both `Particles` and `Bars`.",
];

List<String> glowVariables = [
  "coords",
  "blendMode",
  "mixAlpha",
  "offsetAngle",
  "size",
  "intensity",
  "directions",
  "quality",
  "color",
  "brightnessOffset",
  "lightStrength",
];

List<String> glowDescriptions = [
  "The coordinates of the current Pixel/Fragment being processed. Can be modified.",
  "Blend Mode for the Glow Effect",
  "Whether to use the Alpha Channel for the Glow Effect",
  "Offset for Glow Directons",
  "Size of the Glow.",
  "Intensity with which to add in the neighboring colors.",
  "Number of directions to use while getting color data from radially-outward coordinates. Higher is Expensive.",
  "Quality of Glow. Higher is Expensive.",
  "Overlaying Color to use for the Glow Effect ",
  "Adjusts brightness of the final Color",
  "Brightens or darkens the opacity of the final Color",
];

List<String> rotateVariables = ["coords", "angle", "center"];
List<String> rotateVariablesDescriptions = [
  "The coordinates of the current Pixel/Fragment being processed. Can be modified.",
  "The angle by which to rotate the output",
  "The coordinates around which the rotation should take place",
];
