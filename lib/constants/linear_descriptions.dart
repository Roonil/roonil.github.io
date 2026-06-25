String linearFragmentStructDescription = "Represents the underlying `Fragment` that can show one `Particle` and one `Bar`. None of the Attributes are meant to be modified.";
List<String> linearFragmentParameters = [
"n",
"lastN",
"span",
"coords",
"centerCoords",
];

List<String> linearFragmentParametersDescriptions = [
"Number of the current `Fragment`. Ranges from 0 to `lastN`.",
"Number of the last possible `Fragment`.",
"Span of the `Fragment`. Lies in `[-fragmentWidth/2.,fragmentWidth/2.]`",
"Absolute Coordinates in the `Shader`, corresponding to `(x,y)`. Lies in `[vec2(0,0), vec2(resolution.xy)]`",
"Absolute Coordinates of the `Fragment's Center`.",
];

List<String> linearFragmentDataTypes = [
"float",
"float",
"float",
"vec2",
"vec2",
];

List<String> linearFragmentExamples = [
"-",
"-",
"-",
"-",
"-",
];

String linearAudioSettingsStructDescription = "Represents the various Audio-transformation properties for each side.";
List<String> linearAudioSettingsParameters = [
"reverseLeft",
"reverseRight",
"mode",
"combineChannels",
];

List<String> linearAudioSettingsParametersDescriptions = [
"Specifies the reversal of the left audio channel. Either 0 or 1.",
"Specifies the reversal of the right audio channel. Either 0 or 1.",
"0 for mirrored audio output, where the left half corresponds to the left audio channel and the right half corresponds to the right audio channel. 1 for linear audio output, where the top half represents the right audio channel and the bottom half represents the left audio channel.",
"Specifies whether the audio values should be combined from the left and right channels. Either 0 or 1.",
];

List<String> linearAudioSettingsDataTypes = [
"int",
"int",
"int",
"int",
];

List<String> linearAudioSettingsExamples = [
"0",
"0",
"1",
"1",
];

String linearAudioStructDescription = "Represents the captured Audio Data, and its multiplier.";
List<String> linearAudioParameters = [
"multiplier",
"current",
"prev",
"next",
];

List<String> linearAudioParametersDescriptions = [
"Amplification for the audio value",
"Stores the `Current Fragment's` left audio channel data in x, and the right audio channel data in y.",
"Stores the `Previous Fragment's` left audio channel data in x, and the right audio channel data in y.",
"Stores the `Next Fragment's` left audio channel data in x, and the right audio channel data in y.",
];

List<String> linearAudioDataTypes = [
"float",
"vec2",
"vec2",
"vec2",
];

List<String> linearAudioExamples = [
"100",
"-",
"-",
"-",
];

String linearCapStructDescription = "Represents a `Cap` that can 'bounce' over a `Primitive` (`Bar` or `Particle`). Requires 1 `Image Texture` to be enabled when `visualiserMode` is either 0 or 1, and requires 2 when`visualiserMode` is 2.";
List<String> linearCapParameters = [
"enable",
"rate",
"elasticity",
"elasticityMinThreshold",
"launchVelocity",
"size",
"acceleration",
"launchFlingMultiplier",
"dragFactor",
"offset",
"audio",
"softness",
"color",
];

List<String> linearCapParametersDescriptions = [
"Specifies whether the `Caps` should be enabled.",
"The Downwards fall rate for the `Cap`. Constant.",
"Bounciness of the `Cap` when encountering the Edge of the `Parent Primitive`.",
"Minimum 'bounciness' value that is used to immediately put the `Cap` at rest on the `Parent Primitive's` Edge.",
"Upwards Velocity of the `Cap` when the `parent Primitive` moves upwards.",
"Size of the `Cap`.",
"Acceleration for the downwards fall of the `Cap`.",
"Upwards Thrust of the `Cap` influenced by the current Audio value in the `Fragment`, when the `Parent Primitive` moves upwards.",
"Drag factor. Higher values yield a constant downwards terminal velocity for the `Cap`.",
"Offset for the `Cap`. Will be added to the coordinates of the `Cap`.",
"The audio value that will be used for the `Cap`. `x` stores the left channel for the current `Fragment` and `y` stores the right channel. Each channel is used according to the channel of the `Primitive`.",
"Softness of the `Cap`. `x, y and z` respectively represent softness values for the `top`, `left & right`, and `bottom` edges. Higher softness value yields a smoother and blurred edge.",
"Color of the `Cap`.",
];

List<String> linearCapDataTypes = [
"bool",
"float",
"float",
"float",
"float",
"vec2",
"float",
"float",
"float",
"vec2",
"vec2",
"vec3",
"vec4",
];

List<String> linearCapExamples = [
"false",
"0.03",
"0.03",
"0.6",
"0.04",
"vec2(3, 5)",
"0.5",
"0.5",
"0.01",
"vec2(0,12)",
"-",
"vec3(1, 1.5, 1)",
"vec4(1, 0, 0, 0)",
];

String linearConnectorHalfStructDescription = "Represents the left and right sides of a `Connector`.";
List<String> linearConnectorHalfParameters = [
"enable",
"height",
"borderSize",
"innerSoftness",
"outerSoftness",
"color",
"borderColor",
];

List<String> linearConnectorHalfParametersDescriptions = [
"Specifies whether the `ConnectorHalf` should be enabled.",
"Height of the `ConnectorHalf`.",
"BorderSize of the `ConnectorHalf`.",
"Inner Softness of the `ConnectorHalf`. Higher softness value yields a smoother and blurred edge.",
"Outer Softness of the `ConnectorHalf`. Higher softness value yields a smoother and blurred edge.",
"Inner Color of the `ConnectorHalf`.",
"Outer Color of the `ConnectorHalf`.",
];

List<String> linearConnectorHalfDataTypes = [
"int",
"float",
"float",
"float",
"float",
"vec4",
"vec4",
];

List<String> linearConnectorHalfExamples = [
"0",
"3",
"2",
"0.5",
"0.5",
"vec4(1.0, 1.0, 0.0, 1.0)",
"vec4(1.0, 1.0, 1.0, 1.0)",
];

String linearConnectorStructDescription = "Represents the combination of left and right `Connectors`.";
List<String> linearConnectorParameters = [
"left",
"right",
"jointMode",
"jointColorMode",
"leftCenter",
"currentCenter",
"rightCenter",
];

List<String> linearConnectorParametersDescriptions = [
"Left `ConnectorHalf`",
"Right `Connector Half`",
"Joint Mode",
"Joint Color Mode",
"Stores the coordinates of the `Particle` in the `Left Fragment`.",
"Stores the coordinates of the `Particle` in the `Current Fragment`.",
"Stores the coordinates of the `Particle` in the `Right Fragment`.",
];

List<String> linearConnectorDataTypes = [
"ConnectorHalf",
"ConnectorHalf",
"int",
"int",
"vec2",
"vec2",
"vec2",
];

List<String> linearConnectorExamples = [
"-",
"-",
"1",
"0",
"-",
"-",
"-",
];

String linearParticleStructDescription = "Represents a `Particle`.";
List<String> linearParticleParameters = [
"fragment",
"audio",
"cap",
"connector",
"reverseBottomOffset",
"radius",
"borderSize",
"interChannelDistance",
"innerSoftness",
"outerSoftness",
"offset",
"color",
"borderColor",
];

List<String> linearParticleParametersDescriptions = [
"Stores the current `Fragment`.",
"Stores captured Audio Data.",
"Stores the `Cap` for the `Particle`.",
"Stores `Connector` Settings.",
"Specifies whether the bottom offset value provided should be inverted for the `Bottom Particles`.",
"Specifies the radius of the `Particle`.",
"Specifies the borderSize of the `Particle`.",
"Specifies the vertical distance between the `Top and Bottom Particles`",
"Specifies the inner Softness of the `Particle`. Higher softness value yields a smoother and blurred edge.",
"Specifies the inner Softness of the `Particle`. Higher softness value yields a smoother and blurred edge.",
"Specifies the offset of the `Particle`. Added to the coordinates of the `Particle`. Use `setOffsets()` to properly show connectors if enabled.",
"Inner Color of the `Particle`.",
"Outer Color of the `Particle`.",
];

List<String> linearParticleDataTypes = [
"Fragment",
"Audio",
"Cap",
"Connector",
"int",
"float",
"float",
"float",
"float",
"float",
"vec2",
"vec4",
"vec4",
];

List<String> linearParticleExamples = [
"-",
"-",
"-",
"-",
"1",
"3",
"2",
"12",
"0.5",
"0.5",
"vec2(1,12)",
"vec4(1, 0, 0, 1)",
"vec4(1, 1, 1, 1)",
];

String linearBarStructDescription = "Represents a `Bar`.";
List<String> linearBarParameters = [
"fragment",
"audio",
"upCap",
"downCap",
"type",
"mergeLeftBar",
"mergeRightBar",
"clampLeftMergeBorder",
"clampRightMergeBorder",
"offset",
"size",
"borderSize",
"innerSoftness",
"outerSoftness",
"color",
"borderColor",
"bgColor",
];

List<String> linearBarParametersDescriptions = [
"Stores the current `Fragment`.",
"Stores captured Audio Data.",
"Stores the `Top Cap` for the `Bar`.",
"Stores the `Bottom Cap for the Bar`.",
"Specifies the type of `Bars` to draw: 0 for `Rectangular`, and 1 for `Rounded`. Only `Rectangular Bars` can be merged.",
"Specifies merging of the `Bar` on the Left. Either 0 or 1.",
"Specifies merging of the `Bar` on the Right. Either 0 or 1.",
"1 to specify left Border to be always present on the very first `Bar`, when `mergeLeftBar` is 1.",
"1 to specify right Border to be always present on the very last `Bar`, when `mergeRightBar` is 1.",
"Specifies the offset of the `Bar`. Added to `Bar's` coordinates.",
"Specifies the Size of the `Bar`. `x, y and z` represent the minimum upwards height, horizontal size, and the minimum downwards height.",
"Specifies the BorderSize of the `Bar`. `x, y and z` represent the top, left & right, down side Borders.",
"Softness of the Inner Edge of the `Bar`. `x, y and z` respectively represent softness values for the `top`, `left & right`, and `bottom` edges. Higher softness value yields a smoother and blurred edge.",
"Softness of the Outer Edge of the `Bar`. `x, y and z` respectively represent softness values for the `top`, `left & right`, and `bottom` edges. Higher softness value yields a smoother and blurred edge.",
"Specifies the Inner Color of the `Bar`.",
"Specifies the Outer Color of the `Bar`.",
"Specifies the background Color over which `Bars` are displayed.",
];

List<String> linearBarDataTypes = [
"Fragment",
"Audio",
"Cap",
"Cap",
"int",
"int",
"int",
"int",
"int",
"vec2",
"vec3",
"vec3",
"vec3",
"vec3",
"vec4",
"vec4",
"vec4",
];

List<String> linearBarExamples = [
"-",
"-",
"-",
"-",
"1",
"1",
"1",
"1",
"1",
"vec2(0,-12)",
"vec3(3, 12, 3)",
"vec3(1, 2, 1)",
"vec3(0.5)",
"vec3(0.5)",
"vec4(0,1,1,1)",
"vec4(0.0, 1.0, 0.5, 1.0)",
"vec4(0.5)",
];

