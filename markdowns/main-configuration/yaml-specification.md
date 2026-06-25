# Configuration File
- The config.yaml file serves as the layout specification for the Shaders.
- Used to Define:-      
    - `Audio Objects`
    - `Shader Objects`, belonging to an `Audio object`

:::info
You can specify a different YAML file via the `-f` CLI Argument
:::

The YAML Configuration file has the following structure:

```yaml
audios:
    - name: audio1
      pipewire-settings:
        .
        .
        .
      audio-overrides:
        .
        .
        .
      shaders:
        - name: linear
          class-name: linear1
          .
          .
          .
          audio-overrides:
            .
            .
            .
          paintables:
            - class-name: paintable_1
              .
              .
              .
          post-processing:
            - name: glow
              passes: 1
            .
            .
            . 
          overrides:
            - visualiserMode=1
            .
            .
            .
    - name: audio2
    .
    .
    .
```

---

<details><summary>PipeWire Settings<h6>Represents Audio Capturing properties, such as `Sample Rate` and `Buffer Size`</h6></summary>

| Property | Description |
| :--- | :--- |
| sample-rate | Sample Rate that will be used for capturing audio. Consumed by PipeWire.channelsNumber of channels that specify Mono / Stereo capturing.| 
| fft-scale | Factor for how to scale higher frequencies. Used in a linear equation which is multiplied by the result of the fft transformation.| 
| fft-cutOff | Cut-Off for the Bass end of the audio data when scaling frequencies. Higher values cause more of the bass frequencies to be skipped when scaling.| 
| apply-fft | Whether to apply FFT to the captured Audio. Set False for Waveform Audio Output.| 
| sample-size | Represents the amount of audio samples that get captured at once. Consumed by PipeWire.| 
| fragment-size | Represents the actual amount of audio samples that get sent to the Shaders for Visualisation.| 
| target-object | Specifies the Target Object to which the PipeWire Stream will be connected. Consumed by PipeWire.| 
| capture-mic | Enable if microphone input audio needs to be captured. Consumed by PipeWire.| 
| audio-format | Specifies the Audio Format in which audio will be captured. Consumed by PipeWire. |

</details>

---
 
<details><summary>Channels Map<h6>Handles mapping for each Audio Channel</h6></summary>

| Property | Description |
| :--- | :--- |
| left | Channel to map to the Left Audio Channel.\n0 : Left Channel\n1 : Right Channel |
| right | Channel to map to the Right Audio Channel.\n0 : Left Channel\n1 : Right Channel |

</details>

---

<details><summary>Smooth Settings<h6>Represents various paramters used to smoothen the Audio Output</h6></summary>

| Property | Description |
| :--- | :--- |
| round-formula | The type of formula to use for weighting values when smoothing.\n0 : Circular, heavily rounded points\n1 : Sinusoidal, rounded at both low and high weighted values like a sine wave\n2 : Linear, not rounded at all; linear distance|
| sample-mode | Sampling Mode for Smoothing.\n0 : averages all the inputs in the sample range for a given point. Produces smooth output, but peaks are not well represented.\n1 : obtains the best value from the closest peak in the sample range. Very accurate peaks, but output is jagged and sporadic.\n2 : uses the results from both `0` and `1` sample modes, with the weight provided in `sample-hybrid-weight`.| 
| sample-hybrid-weight | Should be provided in the range (0, 1). Higher values favor averaged results. For `sample-mode : 2` only.| 
| sample-scale | Factor used to scale frequencies. Lower values allows lower frequencies to occupy more space.| 
| sample-range | The frequency range to sample. 1.0 would be the entire FFT output, and lower values reduce the displayed frequencies in a log-like scale.| 
| smooth-factor | Larger values mean more smoothing in the output, however high values can be expensive to compute.adjacent-| 
| sample-nums | The Number of samples that are taken from the left and right of the current audio sample, that are also included in the current audio sample. The final result is then averaged based on the number of averaged samples.|


</details>

---

<details><summary>Gravity Settings<h6>Represents the amount of time for which the captured Audio Data 'stays' in the buffer</h6></summary>

| Property | Description |
| :--- | :--- |
| gravity-step | Specifies the 'Gravity' of the Audio. Higher values means faster drops.| 
| average-frames | Number of Frames to queue and run through the average function. Increasing this value will create latency between the audio input and the Visualiser Output, but will make for much smoother results. |

</details>

---

<details><summary>Audio Overrides<h6>Represents Audio Transformation properties</h6></summary>

| Property | Description |
| :--- | :--- |
| min-frequency | Minimum Frequency for the input Audio.| 
| max-frequency | Maximum Frequency for the input Audio. Should be greater than `min-frequency`, and smaller than or equal to `sample-rate / 2.0` | 
| reduce-frequency-range | Specifies whether the input Audio Range corresponds to the supplied Minimum and Maximum Frequencies. If False, the audio input for the Shaders will always have `fragment-size` length, regardless of the Minimum / Maximum Frequencies.| 
| smooth-audio | Specifies whether the audio should be smoothed by the Smoothing Function, conforming to the `smooth-settings` parameters.| 
| channels-map | Used to map the Audio Channels. Left Channel can be mapped to the Right, and vice-versa. Or, Both Channels can be mapped to either the Left or the Right Channel.| 
| smooth-settings | Parameters used while Smoothing the audio input values for the Shaders.| 
| gravity-settings | Parameters used to specify the responsiveness and the latency of audio input for the Shaders.|


</details>

---

<details><summary>Post-Processing Object<h6>Represents the Post-Processing Shader.</h6></summary>

| Property | Description |
| :--- | :--- |
| name | The name of the Post-Processing Shader / Effect to apply | 
| passes | The number of times the effect gets applied | 

</details>

---

<details><summary>Paintable Object<h6>Represents the layout properties for the `Paintable`. It is essentially a 'copy' of a `Shader` that displays the same output as the `Shader`.</h6></summary>

| Property | Description |
| :--- | :--- |
| class-name | Class Name to identify the Shader for Styling purposes
| width, height | Bounds of the Window |
| layer| Specifies the placement of the Shader on the 'Z Axis' on the screen, via the Wayland Layer Shell Protocol. Supported Types are `Background`, `Bottom`, `Top`, and `Overlay` |
| exclusive-layer | Whether to enable Exclusive Layer for this Window. |
| anchors | Edges to anchor to | 
| margins | Margin from anchored Edges |


</details>

---

<details><summary>Audio Object<h6>Represents various Audio Capturing and Transformation properties</h6></summary>


| Property | Description |
| :--- | :--- |
| name | Name of the Audio Capturing thread |
| pipewire-settings | Represents Audio Capturing properties, such as `Sample Rate` and `Buffer Size`. Consumed by PipeWire |
| audio-overrides | Represents Audio Transformation properties, such as `minimum / maximum frequency`, `smoothing` parameters, and `averaging / gravity` parameters |
| shaders | Represents the list of Shaders that take in as input the transformed Audio values for visualisation |

</details>

---

<details><summary>Shader Object<h6>Represents the layout properties of the Shader Program that gets displayed in a Window.</h6></summary>

| Property | Description |
| :--- | :--- |
| name | Name of the Shader Program to display |
| class-name | Class Name to identify the Shader for Styling purposes |
| fps | Target Framerate |
| width, height | Bounds of the Window |
| layer | Specifies the placement of the Shader on the 'Z Axis' on the screen, via the Wayland Layer Shell Protocol. Supported Types are `Background`, `Bottom`, `Top`, and `Overlay` |
| exclusive-layer | Whether to enable Exclusive Layer for this Window. |
| image-textures | The number of Image Textures that should be enabled for this Shader |
| atomic-textures | The number of Atomic Image Textures that should be enabled for this Shader |
| anchors | Edges to anchor to |
| margins | Margin from anchored Edges |
| overrides | GLSL Overrides for specifying different `#define` attribute substitutions |
| audio-overrides | Audio Overrides that deviate from the 'Global' Audio Overrides (that is, Overrides that belong to the parent Audio Object for the current Shader) |
| post-processing | List of Post-Processing Effects that get applied one after the other |
| paintables | List of 'Copies' of the Current Shader that can be displayed in another Window |

</details>


<footer>

[Prev](../shaders/advanced/creating-your-own-shaders.md)
[Next](styling.md)

</footer>