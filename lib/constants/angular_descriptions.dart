String angularFragmentStructDescription =
    "Represents the underlying `Fragment` that can show one `Particle` and one `Bar`. None of the Attributes are meant to be modified.";
List<String> angularFragmentParameters = [
  "n",
  "lastN",
  "span",
  "currentAngle",
  "coords",
  "currentCenterAngle",
  "vectorFromCenter",
  "distanceFromCenter",
];

List<String> angularFragmentParametersDescriptions = [
  "Number of the current `Fragment`. Ranges from 0 to `lastN`.",
  "Number of the last possible Fragment.",
  "Span of the Fragment. Lies in `[-fragmentAngle/2.,fragmentAngle/2.]`",
  "Specifies the absolute current Angle. Lies in `[0, TWOPI]`",
  "Specifies the absolute current coordinates. Lies in `[vec2(0,0),vec2(resolution.xy)]`",
  "Specifies the absolute Angle of the `current Fragment's` Center.",
  "Specifies the Vector from the Center of the `Circle`.",
  "Corresponds to length of the Vector from the Center of the `Circle`.",
];

List<String> angularFragmentDataTypes = [
  "float",
  "float",
  "float",
  "float",
  "vec2",
  "float",
  "vec2",
  "float",
];

List<String> angularFragmentExamples = ["-", "-", "-", "-", "-", "-", "-", "-"];

String angularAudioSettingsStructDescription =
    "Represents the various Audio-transformation properties for each side.";
List<String> angularAudioSettingsParameters = [
  "reverseLeft",
  "reverseRight",
  "mode",
  "combineChannels",
];

List<String> angularAudioSettingsParametersDescriptions = [
  "Specifies the reversal of the left audio channel. Either 0 or 1.",
  "Specifies the reversal of the right audio channel. Either 0 or 1.",
  "0 for mirrored audio output, where the left half corresponds to the left audio channel and the right half corresponds to the right audio channel. 1 for linear audio output, where the top half represents the right audio channel and the bottom half represents the left audio channel.",
  "Specifies whether the audio values should be combined from the left and right channels. Either 0 or 1.",
];

List<String> angularAudioSettingsDataTypes = ["int", "int", "int", "int"];

List<String> angularAudioSettingsExamples = ["0", "0", "1", "1"];

String angularAudioStructDescription =
    "Represents the captured Audio Data, and its multiplier.";
List<String> angularAudioParameters = ["multiplier", "current", "prev", "next"];

List<String> angularAudioParametersDescriptions = [
  "Amplification for the audio value",
  "Stores the `Current Fragment's` left audio channel data in x, and the right audio channel data in y.",
  "Stores the `Previous Fragment's` left audio channel data in x, and the right audio channel data in y.",
  "Stores the `Next Fragment's` left audio channel data in x, and the right audio channel data in y.",
];

List<String> angularAudioDataTypes = ["float", "vec2", "vec2", "vec2"];

List<String> angularAudioExamples = ["100", "-", "-", "-"];

String angularCapStructDescription =
    "Represents a `Cap` that can 'bounce' over a `Primitive` (`Bar` or `Particle`). Requires 1 `Image Texture` to be enabled when `visualiserMode` is either 0 or 1, and requires 2 when`visualiserMode` is 2.";
List<String> angularCapParameters = [
  "enable",
  "rate",
  "elasticity",
  "type",
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

List<String> angularCapParametersDescriptions = [
  "Specifies whether the `Caps` should be enabled.",
  "The Downwards fall rate for the `Cap`. Constant.",
  "Bounciness of the `Cap` when encountering the Edge of the `Parent Primitive`.",
  "The type of the `Cap`. 0 for `Angular Cap` that changes width based on its height, 1 for `Fixed-Width Cap`",
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

List<String> angularCapDataTypes = [
  "bool",
  "float",
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

List<String> angularCapExamples = [
  "false",
  "0.03",
  "0.03",
  "1",
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

String angularBarStructDescription = "Represents a `Bar`.";
List<String> angularBarParameters = [
  "fragment",
  "audio",
  "upCap",
  "downCap",
  "type",
  "mergeLeftBar",
  "mergeRightBar",
  "mergeEnds",
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

List<String> angularBarParametersDescriptions = [
  "Stores the current `Fragment`.",
  "Stores captured Audio Data.",
  "Stores the `Top Cap` for the `Bar`.",
  "Stores the `Bottom Cap for the Bar`.",
  "Specifies the type of `Bars` to draw: 0 for `Angular`, 1 for `Rectangular` and 2 for `Rounded`. Only `Angular` and `Rectangular Bars` can be merged.",
  "Specifies merging of the `Bar` on the Left. Either 0 or 1.",
  "Specifies merging of the `Bar` on the Right. Either 0 or 1.",
  "1 to specify whether the first and last `Bars` should be merged, when `mergeLeftBar` is 1 or mergeRightBar is 1 for the last Bar. `clampLeftMergeBorder` and `clampRightMergeBorder` should both be 0 for this setting to take effect.",
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

List<String> angularBarDataTypes = [
  "Fragment",
  "Audio",
  "Cap",
  "Cap",
  "int",
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

List<String> angularBarExamples = [
  "-",
  "-",
  "-",
  "-",
  "1",
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

String angularCircleStructDescription =
    "Represents the `Circle` at the Center.";
List<String> angularCircleParameters = [
  "maxAngle",
  "restrictCircleAngle",
  "angleOffset",
  "radius",
  "borderSize",
  "innerSoftness",
  "outerSoftness",
  "center",
  "color",
  "borderColor",
];

List<String> angularCircleParametersDescriptions = [
  "The Maximum Angle at which the `Circle` should be drawn.",
  "Specifies whether to also restrict the `Circle` when `maxAngle` is smaller than 360. Set to 0 to disable the restriction, or 1 to enable it.",
  "Specifies the offset Angle at which to place the `Circle`.",
  "Specifies the radius of the `Circle`.",
  "Specifies the size of the Border of the `Circle`.",
  "Inner Softness of the `Circle`. Higher softness value yields a smoother and blurred edge.",
  "Outer Softness of the `Circle`. Higher softness value yields a smoother and blurred edge.",
  "Absolute Coordinates of the Center of the `Circle`. Defaults to the center of the Window, that is, `vec2(resolution.xy/2.)`",
  "Inner Color of the `Circle`.",
  "Outer Color of the `Circle`.",
];

List<String> angularCircleDataTypes = [
  "float",
  "float",
  "float",
  "int",
  "int",
  "float",
  "float",
  "vec2",
  "vec4",
  "vec4",
];

List<String> angularCircleExamples = [
  "360",
  "1",
  "30",
  "100",
  "4",
  "1.5",
  "1.5",
  "vec2(resolution.xy)",
  "vec4(0.0, 1.0, 1.0, 1.0)",
  "vec4(1.0, 0.0, 0.5, 1.0)",
];

String angularConnectorHalfStructDescription =
    "Represents the left and right sides of a `Connector`.";
List<String> angularConnectorHalfParameters = [
  "enable",
  "height",
  "borderSize",
  "innerSoftness",
  "outerSoftness",
  "color",
  "borderColor",
];

List<String> angularConnectorHalfParametersDescriptions = [
  "Specifies whether the `ConnectorHalf` should be enabled.",
  "Height of the `ConnectorHalf`.",
  "BorderSize of the `ConnectorHalf`.",
  "Inner Softness of the `ConnectorHalf`. Higher softness value yields a smoother and blurred edge.",
  "Outer Softness of the `ConnectorHalf`. Higher softness value yields a smoother and blurred edge.",
  "Inner Color of the `ConnectorHalf`.",
  "Outer Color of the `ConnectorHalf`.",
];

List<String> angularConnectorHalfDataTypes = [
  "int",
  "float",
  "float",
  "float",
  "float",
  "vec4",
  "vec4",
];

List<String> angularConnectorHalfExamples = [
  "0",
  "3",
  "2",
  "0.5",
  "0.5",
  "vec4(1.0, 1.0, 0.0, 1.0)",
  "vec4(1.0, 1.0, 1.0, 1.0)",
];

String angularConnectorStructDescription =
    "Represents the combination of left and right `Connectors`.";
List<String> angularConnectorParameters = [
  "left",
  "right",
  "jointMode",
  "jointColorMode",
  "leftCenter",
  "currentCenter",
  "rightCenter",
  "loop",
  "mergeEnds",
];

List<String> angularConnectorParametersDescriptions = [
  "Left `ConnectorHalf`",
  "Right `Connector Half`",
  "Joint Mode",
  "Joint Color Mode",
  "Stores the coordinates of the `Particle` in the `Left Fragment`.",
  "Stores the coordinates of the `Particle` in the `Current Fragment`.",
  "Stores the coordinates of the `Particle` in the `Right Fragment`.",
  "Whether to loop the `Connectors` for the first and last `Particles`, when `left ConnectorHalf` is enabled or `right ConnectorHalf` is enabled for the last `Particle`. Does not necessarily create merged `Connectors` at all `fragmentAngle` values.",
  "1 to specify whether the first and last `Connectors` should be merged, when `left ConnectorHalf` is enabled or `right ConnectorHalf` is enabled for the last `Particle`.",
];

List<String> angularConnectorDataTypes = [
  "ConnectorHalf",
  "ConnectorHalf",
  "int",
  "int",
  "vec2",
  "vec2",
  "vec2",
  "int",
  "int",
];

List<String> angularConnectorExamples = [
  "-",
  "-",
  "1",
  "0",
  "-",
  "-",
  "-",
  "1",
  "1",
];

String angularParticleStructDescription = "Represents a `Particle`.";
List<String> angularParticleParameters = [
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

List<String> angularParticleParametersDescriptions = [
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

List<String> angularParticleDataTypes = [
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

List<String> angularParticleExamples = [
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
