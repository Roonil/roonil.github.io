# Requirements

`WayVes` runs on `Wayland`, and needs `GTK4`, `GTK4 Layer Shell`, `DBus`, `LibCYAML`, `PipeWire`, `libepoxy`, `GBM` and `EGL` packages to be installed on your system. `CLI11` is bundled with `WayVes`, so it doesn't need to be installed separately.

You can install the required packages by specifying the appropriate installation commands for your distro.

:::info
`WayVes` will fall back to displaying Shaders in a normal Window in case the Layer Shell Protocol is not supported.
:::

## For Arch:
`libcyaml-git` is in the AUR, so install it with an AUR helper such as `paru` or `yay`:

```bash
sudo pacman -S gtk4 gtk4-layer-shell dbus pipewire libepoxy mesa libglvnd
paru -S libcyaml-git
```

:::warning
The `libcyaml` package from the official repositories is too old to build `WayVes`. Use `libcyaml-git`, or build `libcyaml` manually from git.
:::


## For Debian:
```bash
apt install libgtk-4-dev libdbus-1-dev libpipewire-0.3-dev libepoxy-dev libgbm-dev libegl-dev libgl-dev
```

Especially for Debian-based distros, `GTK4 Layer Shell` and `LibCYAML` Packages might either not be available for your System, or provide an older version (the packages are `libgtk4-layer-shell-dev` and `libcyaml-dev`). It is recommended to build and install these from their respective Sources [here](https://github.com/wmww/gtk4-layer-shell) and [here](https://github.com/tlsa/libcyaml).

---

# Installation

```bash
git clone https://github.com/Roonil/WayVes
cd WayVes
make
sudo make install
```

`make install` installs the `WayVes` binary to `/usr/local/bin`, and the Shaders, starter configs and advanced configs to `/usr/local/share/WayVes/`. Use `PREFIX` to install somewhere else, passing the same `PREFIX` to both commands, for example `make PREFIX=/usr` and `sudo make PREFIX=/usr install`. Run `make clean` first if you already built with a different `PREFIX`.

:::info
The Makefile respects `CXXFLAGS`, `CPPFLAGS` and `LDFLAGS`. Without them, `WayVes` is built with debug symbols and no optimisations, so for regular use build it with, for example, `CXXFLAGS="-O2" make`.
:::

---

# Copying the Shaders

`WayVes` reads the Shaders from `$XDG_CONFIG_HOME/WayVes/` (usually `~/.config/WayVes/`), so copy them there after installing (Assuming `$XDG_CONFIG_HOME` is `~/.config`):

```bash
mkdir -p ~/.config/WayVes/
cp -r /usr/local/share/WayVes/shaders/* ~/.config/WayVes/
```

If you installed with a different `PREFIX`, copy from `<PREFIX>/share/WayVes/shaders/` instead. You can also copy straight from the `shaders` directory of the cloned repository.

:::info
Updating `WayVes` does not update the Shaders in `~/.config/WayVes/`. Copy them again after updating, keeping in mind that this overwrites any changes you made to the shipped Shaders.
:::

:::info
If a Shader is missing, `WayVes` prints the exact `cp` command to copy it from the installed Shaders.
:::


<footer>

[Next](usage.md)

</footer>
