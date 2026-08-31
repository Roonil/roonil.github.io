# Requirements

`WayVes` runs on `Wayland`, and needs `GTK4`, `GTK4 Layer Shell`, `DBus`, `LibCYAML` and `PipeWire` packages to be installed on your system. 

You can install the required packages by specifying the appropriate installation commands for your distro.

:::info
`WayVes` will fall back to displaying Shaders in a normal Window in case the Layer Shell Protocol is not supported.
:::

## For Arch:
```bash
pacman -S gtk4 gtk4-layer-shell dbus libcyaml-git pipewire 
```

:::warning
`libcyaml` package on Arch will lead to installation issues. Use `libcyaml-git` specifically for building `WayVes`, or build `libcyaml` manually from git.
:::


## For Debian:
```bash
apt install libgtk-4-dev libdbus-1-dev libpipewire-0.3-dev 
```

Especially for Debian-based distros, `GTK4 Layer Shell` and `LibCYAML` Packages might either not be available for your System, or provide an older version (the packages are `libgtk4-layer-shell-dev` and `libcyaml-dev`). It is recommended to build and install these from their respective Sources [here](https://github.com/wmww/gtk4-layer-shell) and [here](https://github.com/tlsa/libcyaml).

---

# Installation
```bash
git clone https://github.com/Roonil/WayVes
cd WayVes 
mkdir -p build/objects 
make 
make install 
```

After installation, copy the contents of the `shaders` directory to `$XDG_CONFIG_HOME/WayVes/` as such (Assuming `$XDG_CONFIG_HOME` is `~/.config`):

```bash
mkdir -p ~/.config/WayVes/ 
cp -r shaders/* ~/.config/WayVes/ 
```


<footer>

[Next](usage.md)

</footer>