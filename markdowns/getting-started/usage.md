# Usage

:::info 
Newer GTK4 versions might require you to set `GSK_RENDERER=opengl` and `GDK_DEBUG=gl-prefer-gl` Environment Variables first.
:::

`WayVes` reads from a `YAML` file that specifies the layout and positioning of each `Shader` / `Visualiser` on the Screen, along with the Audio Properties that alter the behaviour of the Visualisers' Reactions to the captured Audio Data.

:::info
By default, `config.yaml` file present in `$XDG_CONFIG_HOME/WayVes` is read. You can specify the name of a different `.yaml` file (also present in `$XDG_CONFIG_HOME/WayVes`) by specifiying the `-f` CLI Argument, followed by the file name (without the extension)
:::

- Each Visualiser is an `OpenGL` Program that (primarily) uses a `Fragment` Shader to display Visuals, based on the attributes that are supplied to the `Shader`
- The attributes can be specified using a `.glsl` file. The `.glsl` file is parsed and then the assigned properties are fed into the `Shader Pipeline`
  
:::info
By default, for a `Shader` with the name `ShaderName`, the file `ShaderName.glsl` is read. This behaviour can be overriden by specifying the desired name in the `YAML Configuration file`
:::

To further transform the final output on the Screen, or to modify various Window Properties for the `Shader`, you can use the `styles.css` file. This can be used to rotate and 'embed' a Visualiser onto the Wallpaper, for instance

---

# Starter Configuration

Copy the starter configs to the `$XDG_CONFIG_HOME/WayVes/` directory:

```bash
cp -r /usr/local/share/WayVes/starter-configs/* ~/.config/WayVes/
```

If you installed with a different `PREFIX`, copy from `<PREFIX>/share/WayVes/starter-configs/` instead. You can also copy from the `starter-configs` directory of the cloned repository. In that case, also copy the repository's `schemas` directory, which editors use for completion in `config.yaml`:

```bash
cp -r starter-configs/* schemas ~/.config/WayVes/
```

Execute `WayVes` by typing in `WayVes` in the terminal. You should see some bars on the bottom-left side of the screen, and the angular counter-part of the bars on the bottom-left of the screen. Play any audio on your Desktop, and you should see the Visualisers react to the Audio in Real-Time!

---

# Advanced Configurations

More complete examples are installed to `/usr/local/share/WayVes/advanced-configs/` (`<PREFIX>/share/WayVes/advanced-configs/` with a different `PREFIX`), one directory per configuration. To use one, copy the contents of its directory to `$XDG_CONFIG_HOME/WayVes/`, for example:

```bash
cp -r /usr/local/share/WayVes/advanced-configs/linear_showCase/* ~/.config/WayVes/
```


<footer>

[Prev](installation.md)
[Next](../introduction/overview.md)

</footer>