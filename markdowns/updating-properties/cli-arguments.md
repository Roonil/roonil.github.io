# CLI Arguments

`WayVes` supports passing in CLI Arguments to modify various aspects of the underlying Window that displays a `Shader`, that you pass in via the `YAML Configuration file`. You can change `Margins`, `Anchors`, or the `Layer` of a particular `Shader` by supplying its class name, or dispatch them to all `Shaders` without supplying any class name. You can even specify the name of a different `.yaml` file to read the configuration from.

| Property | Description |
| :--- | :--- |
| -f | Specifies the name of the YAML Configuration file to use (without `.yaml` extension). No other Arguments can be supplied together with this one | 
| -c | Name of the Class of the `Shader` or `Paintable` to modify the Window Properties of. Properties apply to all Windows if no Class Name is specified |
| -i | Name of the Instance with which to run `WayVes`. Defaults to `default` if no value is specified. | 
-z | Changes the layer of the Window. 0: `Background`, 1: `Bottom`, 2: `Top`, 3: `Overlay` | 
| -x | Specifies whether to enable Exclusive Layer for this Window. 0: `False`, 1: `True` | 
| -l | Specifies the Left Margin of the Window | 
| -r | Specifies the Right Margin of the Window | 
| -t | Specifies the Top Margin of the Window | 
| -b | Specifies the Bottom Margin of the Window |
| -s | Specifies whether the Window should be anchored to the Left Edge. 0: `False`, 1: `True` | 
| -p | Specifies whether the Window should be anchored to the Right Edge. 0: `False`, 1: `True` | 
| -u | Specifies whether the Window should be anchored to the Top Edge. 0: `False`, 1: `True` | 
| -d | Specifies whether the Window should be anchored to the Bottom Edge. 0: `False`, 1: `True` | 
| -v | Toggles the Visibility of the Window. Specifying 0 or 1 with the argument will enforce the Visibility to be On or Off.  Note that the `Paintable` Objects also get the same visibility as that of the primary `Shader` they mirror. | 
| -w | Specifies Window Width | 
| -h | Specifies Window Height | 
| -V | Prints the current Version | 


<footer>

[Prev](piping-data.md)
[Next](../recommendations/tips.md)

</footer>