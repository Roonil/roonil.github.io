List<String> uniforms = [
  "uniform float time",
  "uniform vec2 resolution",
  "uniform sampler1D audioL",
  "uniform sampler1D audioR",
  "uniform int audioLSize",
  "uniform int audioRSize",
  "layout(binding = [0...atomicN], r32ui) uniform uimage2D atomicImageTexture[0...atomicN]",
  "layout(binding = atomicN + [0...imageN], rgba32f) uniform restrict image2D imageTexture[0...imageN]",
  "uniform sampler2D tex",
];
List<String> uniformsDescriptions = [
  "Value of the current frame. When targeting 60 fps, the last frame within the first second should be 60. Supplied as a float for bypassing unnecessary type-casts",
  "The Resolution of the View, where the resolution.x is windowWidth, and resolution.y is windowHeight",
  "1D Texture containing Audio data for the Left-mapped Audio Channel",
  "1D Texture containing Audio data for the Right-mapped Audio Channel",
  "Size of the Left-mapped Audio Channel",
  "Size of the Right-mapped Audio Channel",
  "2D unsigned integer Texture that is used for Atomic Image Load / Store operations. Specify the layout binding in increasing numbers starting from 0, and increase the value of N by 1 for each Atomic Texture you require",
  "2D 32-bit floating Texture that is used for arbitrary Image Load / Store operations. Specify the layout binding in increasing numbers starting from the number after the last Atomic Texture Binding Number used, and increase the value of N by 1 for each Image Texture you require",
  "2D Texture that contains the output of the previous Fragment Shader pass. Available only for Shader Stages 2 and onwards",
];
