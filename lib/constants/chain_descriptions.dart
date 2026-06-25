String chainAudioStructDescription = "Represents Audio Settings and captured Audio Data.";
List<String> chainAudioParameters = [
"value",
"multiplier",
];

List<String> chainAudioParametersDescriptions = [
"Stores the captured Audio Data's left channel data in x, and the right audio channel data in y.",
"Amplification for the audio value",
];

List<String> chainAudioDataTypes = [
"vec2",
"float",
];

List<String> chainAudioExamples = [
"-",
"100",
];

String chainAudioSettingsStructDescription = "Represents the various Audio-transformation properties for each side.";
List<String> chainAudioSettingsParameters = [
"reverseLeft",
"reverseRight",
"mode",
"combineChannels",
];

List<String> chainAudioSettingsParametersDescriptions = [
"Specifies the reversal of the left audio channel.",
"Specifies the reversal of the right audio channel.",
"0 for mirrored audio output, where the left half corresponds to the left audio channel and the right half corresponds to the right audio channel. 1 for linear audio output, where the top half represents the right audio channel and the bottom half represents the left audio channel.",
"Specifies whether the audio values should be combined from the left and right channels",
];

List<String> chainAudioSettingsDataTypes = [
"int",
"int",
"int",
"int",
];

List<String> chainAudioSettingsExamples = [
"true",
"true",
"1",
"1",
];

String chainChainStructDescription = "Represents the `Chain` Object.";
List<String> chainChainParameters = [
"heightRatio",
"strength",
"radius",
"density",
"index",
"color",
"interChannelDistance",
"channelLineHeight",
"verticalColorDropExtent",
];

List<String> chainChainParametersDescriptions = [
"The Extent of the height of the `Chain`, compared to the total height of the Window",
"The overall visibility of the `Particles` within the `Chain`. Set it to a very low value. Higher values make the displacements broader in height",
"The radius of the `Chain`",
"The number of `Particles` within a section of the `Chain`",
"The index of the current `Particle` in the `Chain`.",
"Color of the `Chain`",
"The vertical distance between the top and lower halves of the `Chain`.",
"The height of the center line of the `Chain`.",
"Determines the color drop-off as `Particles` go vertically away from the `Chain's` center. Between 0 and 1.",
];

List<String> chainChainDataTypes = [
"float",
"float",
"float",
"float",
"float",
"vec4",
"float",
"float",
"float",
];

List<String> chainChainExamples = [
"1",
"0.175",
"15",
"128",
"-",
"vec4(0,1,1,1)",
"12",
"10",
"0.02",
];

