String ncsBaseFormStructDescription =
    "Represents the `Grid` of the `Particles`.";
List<String> ncsBaseFormParameters = [
  "type",
  "scale",
  "numParticles",
  "zSize",
  "rotations",
  "rotationCenter",
];

List<String> ncsBaseFormParametersDescriptions = [
  "Type of the `Grid` to use. 0 for `Rectangular`, and 1 for `Spherical Grid` arranged as `Concentric Circles`",
  "The overall Scaling Factor for the displayed `Grid` in X, Y and Z directions",
  "The number of `Particles` to render. Maximum number of `Particles` in each Dimension is the size of the window in that dimension",
  "The size of the Window in the Z Axis",
  "The rotations to apply to the `BaseForm`",
  "The center around which the rotations will be applied",
];

List<String> ncsBaseFormDataTypes = [
  "int",
  "vec3",
  "vec3",
  "float",
  "mat3",
  "vec3",
];

List<String> ncsBaseFormExamples = [
  "0",
  "vec3(2)",
  "resolution.xy",
  "100",
  "IDENTITY_MATRIX",
  "vec3(resolution.xy / 2, 0)",
];

String ncsAudioStructDescription =
    "Represents various Audio Settings and captured Audio Data.";
List<String> ncsAudioParameters = [
  "multiplier",
  "bassMultiplier",
  "mixing",
  "bass",
  "exponentiationFactor",
  "samplePoints[9]",
  "samplePointsDifferences[9]",
  "intermediateAudios[8]",
  "value",
];

List<String> ncsAudioParametersDescriptions = [
  "Determines the strength by which the audio stream affects the inner `Fractal Field` displacements",
  "Determines the `Sphere's` size change by the audio's lower frequencies",
  "Between 0 and 1. Greater value means stronger reaction to beats or tonal changes in audio",
  "Audio value corresponding to the lower frequencies is stored here",
  "The Factor that is used to raise the power of the intermediate Audio Data Points, for the 'quickness' of the reactions when there is a sudden change in the playing Frequencies",
  "The Normalised Points at which Audio Samples are taken for an Intermediate Audio Value that is used to derive the final Audio output value.",
  "The Step for the next Audio Sample Point for the current Intermediate Audio Value, which will be used to find the maximum of the Audio Data at this stepped Point and the Point before the difference.",
  "Intermediate Audio Values, stored in Ascending Order of the Intensity of the Frequencies. Used to derive the final driving audio value",
  "The Final Audio Value that is derived from the Intermediate Audio Values",
];

List<String> ncsAudioDataTypes = [
  "float",
  "float",
  "float",
  "float",
  "float",
  "float",
  "float",
  "float",
  "float",
];

List<String> ncsAudioExamples = [
  "7",
  "5",
  "0.5",
  "-",
  "1.02",
  "{0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9}",
  "{0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05, 0.05}",
  "-",
  "-",
];

String ncsParticleStructDescription = "Represents individual `Particles`.";
List<String> ncsParticleParameters = [
  "color",
  "opacityMultiplier",
  "size",
  "feather",
  "colorIntensityAddStrength",
  "antiAlias",
  "position",
];

List<String> ncsParticleParametersDescriptions = [
  "Color of the `Particles`",
  "Use this value to affect the Particle's opacity with various parameters",
  "Size of the `Particles`",
  "Feathering or Smoothing of the `Particles`. Between 0 and 1",
  "Uses `Add Color Blend mode` to mix colors when `Particles` overlap. Between 0 and 1",
  "Change this value in case some color combination produces jagged spherical edges. Greater than 0",
  " The position of the `Particle`",
];

List<String> ncsParticleDataTypes = [
  "vec4",
  "float",
  "int",
  "float",
  "float",
  "float",
  "vec3",
];

List<String> ncsParticleExamples = [
  "vec4(0, 0, 1, 1)",
  "1",
  "3",
  "0.5",
  "0.1",
  "4.5",
  "-",
];

String ncsFractalFieldStructDescription =
    "Represents the Underlying `Noise Field`.";
List<String> ncsFractalFieldParameters = [
  "octaveMultiplier",
  "octaveScale",
  "complexity",
  "fScale",
  "dimensions",
  "gamma",
  "minVal",
  "maxVal",
  "offset",
  "noiseMultiplier",
  "constantNoiseMultiplier",
  "affectOpacity",
  "affectSize",
  "loop",
  "loopFrames",
  "displacementType",
  "displacements",
  "flows",
  "noise",
];

List<String> ncsFractalFieldParametersDescriptions = [
  "Defines the multiplier value with which a `Noise Octave` gets added in to the final `Noise Output`. Higher values produce more peaks and valleys",
  "Defines the scale of each `Noise Octave` that constitutes the final `Noise Output`",
  "Defines the number of `Octaves`, or the number of values that add up in the final `Noise Output`. Higher is slower.",
  "Defines the scale of the overall noise-displaced `Particle Grid`. Higher value gives a 'zoomed-in' view, providing more displaced output",
  "The dimensions of the `Fractal Field` in `X, Y, and Z` directions along with `time`",
  "Adjusts the difference between the valleys and peaks of the `Noise Output`, similar to gamma for brightness / contrast values",
  "Determines the minimum possible output value of the `Noise` function",
  "Determines the maximum possible output value of the `Noise` function",
  "The offset to add to the overall `Noise` produced",
  "Multiplier for generated `Noise`",
  "Value that gets added along with the Audio Value to the overall `Noise` generated; can be used to have a non-zero `Noise Output`",
  "Determines the extent to which the `Fractal Field` affects the `Opacity` of the `Particles`",
  "Determines the extent to which the `Fractal Field` affects the `Size` of the `Particles`",
  "Whether to loop the `Fractal Field` after the specified amount of `loopFrames` have passed",
  "The Number of Frames after which the `Fractal Field` will loop. `fScale >= loopTime * min(flow.x, flow.y, flow.z, flow.w) / dimensions` should be satisfied for the looping to take place, or you might see unexpected `Noise` values",
  "The type of the displacement to use. 0 is `Normal Displacement`, and 1 is `Radial Displacement` (strength of the displacement is determined by `displacements.x`)",
  "Displacements in `X,Y and Z` directions",
  "`Flow` of the `Fractal Field` in `X, Y and Z` directions, along with `Flow` in `Time` (`Flow Evolution`)",
  "The output noise value for each spatial direction `X, Y and Z`",
];

List<String> ncsFractalFieldDataTypes = [
  "float",
  "float",
  "int",
  "float",
  "vec4",
  "float",
  "float",
  "float",
  "float",
  "float",
  "float",
  "float",
  "float",
  "int",
  "int",
  "int",
  "vec3",
  "vec4",
  "vec3",
];

List<String> ncsFractalFieldExamples = [
  "0.5",
  "1.5",
  "3",
  "10",
  "vec4(1000)",
  "1",
  "-1",
  "1",
  "0",
  "1",
  "0",
  "0",
  "0",
  "0",
  "200",
  "0",
  "vec3(100)",
  "vec4(0, 0, 0, 2)",
  "-",
];

String ncsSphereStructDescription =
    "Represents the `Sphere` that can displace the `Particles` Radially.";
List<String> ncsSphereParameters = [
  "radius",
  "feather",
  "strength",
  "center",
  "scale",
];

List<String> ncsSphereParametersDescriptions = [
  "Radius of the `Sphere`",
  " Determines the size of the \"band\" around the `Sphere`. Between 0 and 1",
  "The Strength with which the particles get pushed (or pulled) from the center of the `Sphere`",
  "Coordinates of the Center of the `Sphere`",
  "Scale of the `Sphere` in each Direction",
];

List<String> ncsSphereDataTypes = ["float", "float", "float", "vec3", "vec3"];

List<String> ncsSphereExamples = [
  "0",
  "0",
  "1",
  "vec3(resolution.xy / 2, 0)",
  "vec3(1)",
];
