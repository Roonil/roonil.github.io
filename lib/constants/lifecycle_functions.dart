List<String> chainLifeCycleFunctions = ["init()", "audioFetch()", "setProps()"];

List<String> chainLifeCycleFunctionsDescriptions = [
  "Called before the Shader starts taking in the Audio Data.",
  "Called just after the Audio Data has been fed into the Shader. Fetched Audio is in the normalised Range [0, 1], and after the function returns, gets multiplied by the multiplier values.",
  "Sets various visual properties of the Shader, such as Strength and Color.",
];

List<String> chainSampleCodes = [
  """void init() {
    // Set audio.multiplier and chain.density here
		chain.density = 256;
		audio.multiplier = 1.2;
}""",
  """void audioFetch(inout float fetchedAudio, float n, float lastN) {
		fetchedAudio *= .5;
}""",
  """void setProps() {
		chain.channelLineHeight = max(0, 1. - audio.value.x);
		chain.color = interpolateHue(vec4(0, 0.4, 1, 0.03), .05, 15 * (resolution.x - chain.index) * audio.value.x, resolution.x);
}""",
];

List<String> linearLifeCycleFunctions = [
  "init()",
  "audioFetch()",
  "setOffsets()",
  "setProps()",
  "setParticleDownProps()",
  "modifySDFs()",
];

List<String> linearLifeCycleFunctionsDescriptions = [
  "Called before the Shader starts taking in the Audio Data.",
  "Called just after the Audio Data has been fed into the Shader. Fetched Audio is in the normalised Range [0, 1], and after the function returns, gets multiplied by the multiplier values.",
  "Ensures proper Offset Synchronisation when `bar.mergeLeftBar` / `bar.mergeRightBar` or `particle.connector.left.enable` / `particle.connector.right.enable` is set to 1.",
  "Sets various visual properties of the Shader, such as Size, Softness, and Color.",
  "Can be used to change the properties of the Particles that move downwards.",
  "Can be used to change the shapes of all the objects that will be drawn via the Shader. Colors are applied just after this Function.",
];

List<String> linearSampleCodes = [
  """void init() {
		// Set all the required audioSettings attributes here
		audioSettings.mode = 1;
		audioSettings.combineChannels = 0;

		// Audio Multipliers
		particle.audio.multiplier = 120;
		bar.audio.multiplier = 220;

		// Enabling Connectors
		particle.connector.left.enable = 1;
		particle.connector.right.enable = 1;

		// Enabling Merged Bars
		bar.mergeLeftBar = 1;
		bar.mergeRightBar = 1;

		// Additionally, always clamping the ends of the merged bars so that only the borders get shown
		bar.clampLeftMergeBorder = 1;
		bar.clampRightMergeBorder = 1;
}""",

  """void audioFetch(inout float fetchedAudio, float n, float lastN) {
		fetchedAudio = 1. - fetchedAudio;
}""",
  """void setOffsets(float direction, inout vec2 particleOffset, inout vec2 barOffset, inout vec2 barSizeOffset, vec2 barAudio, vec2 particleAudio, float xCoordinate, float n, float lastN) {
		particleOffset.y = 120 * sin(12.5 * x);
		barSizeOffset.x = 9 * mod(int(n), 2);
		barOffset.y = -16 * int((barAudio.x) / 16);
}""",
  """void setProps() {
		particle.radius = 12;
		particle.borderSize = 3;
		particle.color = vec4(1);
		particle.borderColor = vec4(1, 0, 0, 1);
}""",
  """void setParticleDownProps() {
		particle.radius = 4;
		particle.color = vec4(0, 0, 1, 1);
}""",
  """void modifySDFs() {
		sdfs[BAR_INNER_SDF] *= sdfs[PARTICLE_UP_INNER_SDF];
}""",
];

List<String> angularSampleCodes = [
  """void init() {
		// Set all the required audioSettings attributes here
		audioSettings.mode = 1;
		audioSettings.combineChannels = 0;

		// Audio Multipliers
		particle.audio.multiplier = 120;
		bar.audio.multiplier = 220;

		// Set circle.center, circle.maxAngle and circle.angleOffset here
		circle.center = vec2(resolution.xy / 2.);
		circle.maxAngle = 330;
		circle.angleOffset = 120;

		// Enabling Connectors
		particle.connector.left.enable = 1;
		particle.connector.right.enable = 1;

		// Looping the Connectors at the Ends
		particle.connector.loop = 1;

		// Ensuring that the Connectors are always joined at the Ends when looping is enabled, when using arbitrary fragmentAngle values
		particle.connector.mergeEnds = 1;

		// Enabling Merged Bars
		bar.mergeLeftBar = 1;
		bar.mergeRightBar = 1;

		// Additionally, always clamping the ends of the merged bars so that only the borders get shown
		bar.clampLeftMergeBorder = 1;
		bar.clampRightMergeBorder = 1;

		// Or, if clamping for both ends has been disabled, you can opt to always merge the bars at the ends as one
		bar.mergeEnds = 1;
}""",

  """void audioFetch(inout float fetchedAudio, float n, float lastN) {
		fetchedAudio = 1. - fetchedAudio;
}""",

  """void setOffsets(float direction, inout vec2 particleOffset, inout vec2 barOffset, inout vec2 barSizeOffset, vec2 barAudio, vec2 particleAudio, float xCoordinate, float n, float lastN) {
		particleOffset.y = 120 * sin(12.5 * x);
		barSizeOffset.x = 9 * mod(int(n), 2);
		barOffset.y = -16 * int(barAudio.x / 16);
}""",

  """void setProps() {
		particle.radius = 12;
		particle.borderSize = 3;
		particle.color = vec4(1);
		particle.borderColor = vec4(1, 0, 0, 1);
}""",

  """void setParticleDownProps() {
		particle.radius = 4;
		particle.color = vec4(0, 0, 1, 1);
}""",

  """void modifySDFs() {
		sdfs[BAR_INNER_SDF] *= sdfs[PARTICLE_UP_INNER_SDF];
}""",
];

List<String> ncsLifeCycleFunctions = [
  "init()",
  "setProps()",
  "modifyNoiseCoordinates()",
  "setPropsWithNoise()",
  "modifySphericalDisplacement()",
];
List<String> ncsLifeCycleFunctionsDescriptions = [
  "Called before the Shader starts taking in the Audio Data.",
  "Sets various visual properties of the Shader and the underlying Fractal Noise Field.",
  "Changes the coordinates that get passed to the Fractal Noise Function",
  "Adjusts various parameters after the Noise value has been calculated (stored in `fractalField.noise`)",
  "Allows final modification of parameters, after Spherical Displacement has been applied.",
];

List<String> ncsSampleCodes = [
  """void init() {
    // Set audio.multiplier and audio.bassMultiplier here
    audio.multiplier = 120;
    audio.bassMultiplier = 190;

    // Set baseForm.type, baseForm.numParticles and baseForm.zSize here
    // Base Form Controls
    baseForm.type = 0;
}""",
  """void setProps() {
    // Particle Controls
    particle.color = vec4(0.0353, 0.5216, 0.9725, 0.26);
    particle.size = 4;
    particle.feather = 1;
    particle.colorIntensityAddStrength = 0.4;
    particle.antiAlias = 8.5;

    // Fractal Field Controls
    fractalField.octaveMultiplier = 0.25;
    fractalField.octaveScale = 1.0;
    fractalField.complexity = 3;
    fractalField.fScale = 9.473;
    fractalField.gamma = 1.0;
    fractalField.minVal = -5.0;
    fractalField.maxVal = 5.0;

    // Displacement And Flow Controls
    fractalField.flows = vec4(0, 3.8, 0, 1.3);
    fractalField.displacements = vec3(.3884 * resolution.x, .3884 * resolution.x - 20, .3884 * resolution.x - 5);

    // Sphere Controls
    sphere.radius = .7236 * resolution.x;
    sphere.feather = 0.45;
}""",

  """void modifyNoiseCoordinates(inout vec4 coords) {
    coords.xy *= 2;
}""",

  """void setPropsWithNoise() {
    particle.color.y *= length(fractalField.noise);
}""",

  """void modifySphericalDisplacement() {
    particle.color *= length(particle.position - sphere.center) / sphere.radius;
}""",
];
