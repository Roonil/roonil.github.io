# Performance
- `WayVes` utilises the `Wayland Layer Shell Protocol` to display Windows as `Layers`. Since some GTK-specific features such as styling via `.css` files and support of Paintables was desired, `WayVes` uses GTK4 to draw and display the Windows. Hence, the `GTK4 Wayland Layer Shell Protocol` dependency is necessary.
- `WayVes` runs an instance of a GTK4 Application for each `Audio Object` in a new forked Process. These instances then drive the underlying `Shaders`. Rendering is handled asynchronously, but ultimately the render commands get queued to the Main GTK4 Application Thread, as UI updates are handled via the Main Thread in GTK.
- As the GTK Main Loop is responsible for 'updating' the UI, too many `Shaders` under a single `Audio Object` (and therefore under a single GTK4 Application instance) can lead to performance issues.
- For this reason, it is recommended to 'split' the `Shaders` among different `Audio Objects`. Too many `Shaders` under a single `Audio Object` WILL lead to stutters and performance drops.

:::info
It is also recommended to disable Blur from the Compositor settings in case any Shader lies below a Blurred element, as that might massively impact Performance.
:::

---

# New GTK GL Renderer

GTK4 recently introduced the New GL Renderer, along with Vulkan. As of the latest stable GTK4 release version (4.20.2), the New Renderers seem to offer sub-par performance as compared to the 'Old' GL Renderer (Such as in GTK4.12).
- If you encounter severe performance issues, even after 'splitting' the `Shaders` among different `Audio Objects` as discussed above, you can try to use an Older GTK4 version and see if that fixes the issues.
- You'll be building a minimal version of the `GTK4` library and then linking it to the `WayVes` Executable, so the rest of the sytem won't be affected.
- As `WayVes` needs only the underlying Windowing and Styling Logic, you need not include other GTK functionalities during the build, such as `demos`, `examples` and `tests`.


---

# Using the Old GTK Renderer

1. Get the Source Code for an older GTK4 Version (`GTK 4.12.5 / 4.12.0` produced no performance drops; it is suggested to use either one of these.)
2. Toggle the dependencies that we won't be needing besides bare-bones GTK.
 
    We'll be using an installation directory named `prefixDir` in which the actual installation of GTK4 will take place. Also assuming that build directory is `buildDir` in which the relevant build files will be generated.

    For example, using `meson`, and supplying parameters to disable building examples, demos and such:

    ```bash
    meson setup -Dintrospection=disabled -Dprefix=$PWD/prefixDir -Dbuildtype=release -Ddocumentation=false -Dmedia-gstreamer=disabled  -Dcloudproviders=disabled -Dcolord=disabled -Dman-pages=false -Dbuild-demos=false  -Dtracker=disabled -Dsysprof=disabled -Dbuild-examples=false -Dbuild-tests=false -Dbuild-testsuite=false -Dbuild-demos=false -Dmacos-backend=false -Dwin32-backend=false -Dbuildtype=release buildDir 
    ```

    To see all the available options you can toggle, then after running `meson setup`, run:

    ```bash
    meson configure buildDir 
    ```

3. Install GTK4 to `prefixDir`:

    ```bash
    ninja -C buildDir
    ninja -C buildDir install
    ```

4. Before running `WayVes`, ensure that the older version overrides the new one by running:

    ```bash
    export LD_LIBRARY_PATH="/path/to/prefixDir:$LD_LIBRARY_PATH"
    export GSETTINGS_SCHEMA_DIR="/path/to/prefixDir/share/glib-2.0/schemas"                                                                                               
    export GTK_PATH="/path/to/prefixDir"
    ```


    Check if the linking was correct by running:


    ```bash
    ldd $(which WayVes) | grep -i 'gtk' 
    ```

    You should see 2 entries, one corresponding to the `gtk4-layer-shell` library, and the other (`libgtk-4.so.1`) should point to your prefixed directory.

   - If you don't see the library from your `prefix` directory, then you'll have to explicitly load the `libgtk-4.so.1` library using `LD_PRELOAD`. The library should be present in `prefixDir/lib`, or in `prefixDir/x86_64-linux-gnu` directory.

       ```bash
       export LD_PRELOAD=/path/to/prefixDir/lib/x86_64-linux-gnu/libgtk-4.so.1  
       ```

`WayVes` should now use the older GTK version while running. Verify by running the `ldd` command again


<footer>

[Prev](tips.md)

</footer>