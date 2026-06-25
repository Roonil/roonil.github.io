List<String> audioProps = [
  "name",
  "pipewire-settings",
  "audio-overrides",
  "shaders",
];
List<String> audioPropsDescriptions = [
  "Name of the Audio Capturing thread",
  "Represents Audio Capturing properties, such as `Sample Rate` and `Buffer Size`. Consumed by PipeWire",
  "Represents Audio Transformation properties, such as `minimum / maximum frequency`, `smoothing` parameters, and `averaging / gravity` parameters",
  "Represents the list of Shaders that take in as input the transformed Audio values for visualisation",
];

List<String> shaderProps = [
  "name",
  "class-name",
  "fps",
  "width, height",
  "layer",
  "exclusive-layer",
  "image-textures",
  "atomic-textures",
  "anchors",
  "margins",
  "overrides",
  "audio-overrides",
  "post-processing",
  "paintables",
];

List<String> shaderPropsDescriptions = [
  "Name of the Shader Program to display",
  "Class Name to identify the Shader for Styling purposes",
  "Target Framerate",
  "Bounds of the Window",
  "Specifies the placement of the Shader on the 'Z Axis' on the screen, via the Wayland Layer Shell Protocol. Supported Types are `Background`, `Bottom`, `Top`, and `Overlay`",
  "Whether to enable Exclusive Layer for this Window.",
  "The number of Image Textures that should be enabled for this Shader",
  "The number of Atomic Image Textures that should be enabled for this Shader",
  "Edges to anchor to",
  "Margin from anchored Edges",
  "GLSL Overrides for specifying different `#define` attribute substitutions",
  "Audio Overrides that deviate from the 'Global' Audio Overrides (that is, Overrides that belong to the parent Audio Object for the current Shader)",
  "List of Post-Processing Effects that get applied one after the other",
  "List of 'Copies' of the Current Shader that can be displayed in another Window",
];

List<String> paintableProps = [
  "class-name",
  "width, height",
  "layer",
  "exclusive-layer",
  "anchors",
  "margins",
];

List<String> paintablePropsDescriptions = [
  "Class Name to identify the Shader for Styling purposes",
  "Bounds of the Window",
  "Specifies the placement of the Shader on the 'Z Axis' on the screen, via the Wayland Layer Shell Protocol. Supported Types are `Background`, `Bottom`, `Top`, and `Overlay`",
  "Whether to enable Exclusive Layer for this Window.",
  "Edges to anchor to",
  "Margin from anchored Edges",
];

List<String> postProcessingProps = ["name", "passes"];

List<String> postProcessingPropsDescriptions = [
  "The name of the Post-Processing Shader / Effect to apply",
  "The number of times the effect gets applied",
];

List<String> gravitySettings = ["gravity-step", "average-frames"];

List<String> gravitySettingsDescriptions = [
  "Specifies the 'Gravity' of the Audio. Higher values means faster drops.",
  "Number of Frames to queue and run through the average function. Increasing this value will create latency between the audio input and the Visualiser Output, but will make for much smoother results.",
];

List<String> smoothSettings = [
  "round-formula",
  "sample-mode",
  "sample-hybrid-weight",
  "sample-scale",
  "sample-range",
  "smooth-factor",
  "adjacent-sample-nums",
];
List<String> smoothSettingsDescriptions = [
  "The type of formula to use for weighting values when smoothing.\n0 : Circular, heavily rounded points\n1 : Sinusoidal, rounded at both low and high weighted values like a sine wave\n2 : Linear, not rounded at all; linear distance",
  "Sampling Mode for Smoothing.\n0 : averages all the inputs in the sample range for a given point. Produces smooth output, but peaks are not well represented.\n1 : obtains the best value from the closest peak in the sample range. Very accurate peaks, but output is jagged and sporadic.\n2 : uses the results from both `0` and `1` sample modes, with the weight provided in \$(sample-hybrid-weight).",
  "Should be provided in the range (0, 1). Higher values favor averaged results. For \$(sample-mode) : 2 only.",
  "Factor used to scale frequencies. Lower values allows lower frequencies to occupy more space.",
  "The frequency range to sample. 1.0 would be the entire FFT output, and lower values reduce the displayed frequencies in a log-like scale.",
  "Larger values mean more smoothing in the output, however high values can be expensive to compute.",
  "The Number of samples that are taken from the left and right of the current audio sample, that are also included in the current audio sample. The final result is then averaged based on the number of averaged samples.",
];

List<String> channelMap = ["left", "right"];
List<String> channelMapDescriptions = [
  "Channel to map to the Left Audio Channel.\n0 : Left Channel\n 1 : Right Channel",
  "Channel to map to the Right Audio Channel.\n0 : Left Channel\n 1 : Right Channel",
];

List<String> audioOverrides = [
  "min-frequency",
  "max-frequency",
  "reduce-frequency-range",
  "smooth-audio",
  "channels-map",
  "smooth-settings",
  "gravity-settings",
];
List<String> audioOverridesDescriptions = [
  "Minimum Frequency for the input Audio.",
  "Maximum Frequency for the input Audio. Should be greater than `min-frequency`, and smaller than or equal to `sample-rate / 2.0`,",
  "Specifies whether the input Audio Range corresponds to the supplied Minimum and Maximum Frequencies. If False, the audio input for the Shaders will always have `fragment-size` length, regardless of the Minimum / Maximum Frequencies.",
  "Specifies whether the audio should be smoothed by the Smoothing Function, conforming to the `smooth-settings` parameters.",
  "Used to map the Audio Channels. Left Channel can be mapped to the Right, and vice-versa. Or, Both Channels can be mapped to either the Left or the Right Channel.",
  "Parameters used while Smoothing the audio input values for the Shaders.",
  "Parameters used to specify the responsiveness and the latency of audio input for the Shaders.",
];

List<String> pipeWireSettings = [
  "sample-rate",
  "channels",
  "fft-scale",
  "fft-cutOff",
  "apply-fft",
  "sample-size",
  "fragment-size",
  "target-object",
  "capture-mic",
  "audio-format",
];
List<String> pipeWireSettingsDescriptions = [
  "Sample Rate that will be used for capturing audio. Consumed by PipeWire.",
  "Number of channels that specify Mono / Stereo capturing.",
  "Factor for how to scale higher frequencies. Used in a linear equation which is multiplied by the result of the fft transformation.",
  "Cut-Off for the Bass end of the audio data when scaling frequencies. Higher values cause more of the bass frequencies to be skipped when scaling.",
  "Whether to apply FFT to the captured Audio. Set False for Waveform Audio Output.",
  "Represents the amount of audio samples that get captured at once. Consumed by PipeWire.",
  "Represents the actual amount of audio samples that get sent to the Shaders for Visualisation.",
  "Specifies the Target Object to which the PipeWire Stream will be connected. Consumed by PipeWire.",
  "Enable if microphone input audio needs to be captured. Consumed by PipeWire.",
  "Specifies the Audio Format in which audio will be captured. Consumed by PipeWire.",
];

List<String> overrides = ["overrides"];

List<String> overridesDescriptions = [
  "List of Override values that will override the `#define` attribute within the Shader. Each value should conform to 'variableName=newVariableValue' format.",
];
