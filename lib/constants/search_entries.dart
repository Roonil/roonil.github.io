import 'package:wayves_wiki/models/search_entry.dart';

final List<SearchEntry> searchEntries = [
  SearchEntry(
    route: '/updating-properties/cli-arguments',

    pageTitle: "CLI Arguments",
    searchHits: [
      // Overview
      SearchHit(
        keyword: "CLI Arguments",
        heading: "CLI Arguments",
        snippet:
            "Command-line arguments allow modifying window properties, layout, and visibility at runtime without changing the config file.",
      ),

      // Config file
      SearchHit(
        keyword: "-f",
        heading: "CLI Arguments",
        snippet:
            "Specifies a custom configuration file instead of the default `config.yaml`.",
      ),

      // Class targeting
      SearchHit(
        keyword: "--class-name",
        heading: "CLI Arguments",
        snippet:
            "Targets a specific `Shader` or `Paintable class` when applying CLI arguments. If omitted, arguments apply to all Windows.",
      ),

      // Window size
      SearchHit(
        keyword: "--window-width",
        heading: "CLI Arguments",
        snippet: "Sets the width of the Window in pixels.",
      ),
      SearchHit(
        keyword: "--window-height",
        heading: "CLI Arguments",
        snippet: "Sets the height of the Window in pixels.",
      ),

      // Margins
      SearchHit(
        keyword: "--margin-top",
        heading: "CLI Arguments",
        snippet: "Sets the top margin of the Window.",
      ),
      SearchHit(
        keyword: "--margin-bottom",
        heading: "CLI Arguments",
        snippet: "Sets the bottom margin of the Window.",
      ),

      SearchHit(
        keyword: "--instance",
        heading: "CLI Arguments",
        snippet: "Sets the name of the Instance with which to run `WayVes`.",
      ),
      SearchHit(
        keyword: "--margin-left",
        heading: "CLI Arguments",
        snippet: "Sets the left margin of the Window.",
      ),
      SearchHit(
        keyword: "--margin-right",
        heading: "CLI Arguments",
        snippet: "Sets the right margin of the Window.",
      ),

      // Anchors
      SearchHit(
        keyword: "--anchor-top",
        heading: "CLI Arguments",
        snippet: "Anchors the Window to the top edge of the screen.",
      ),
      SearchHit(
        keyword: "--anchor-bottom",
        heading: "CLI Arguments",
        snippet: "Anchors the Window to the bottom edge of the screen.",
      ),
      SearchHit(
        keyword: "--anchor-left",
        heading: "CLI Arguments",
        snippet: "Anchors the Window to the left edge of the screen.",
      ),
      SearchHit(
        keyword: "--anchor-right",
        heading: "CLI Arguments",
        snippet: "Anchors the Window to the right edge of the screen.",
      ),

      // Exclusive Layer
      SearchHit(
        keyword: "--exclusive-layer",
        heading: "CLI Arguments",
        snippet: "Sets Layer Exclusivity",
      ),

      // Layer
      SearchHit(
        keyword: "--layer",
        heading: "CLI Arguments",
        snippet:
            "Sets the Window layer: `Background`, `Bottom`, `Top`, or `Overlay`.",
      ),

      // Visibility
      SearchHit(
        keyword: "--visibility",
        heading: "CLI Arguments",
        snippet:
            "Toggles the `visibility` of the Window. Specifying 0 or 1 with the argument will enforce the Visibility to be On or Off. `Paintable` objects inherit the visibility of their `Parent Shader`.",
      ),

      SearchHit(
        keyword: "--version",
        heading: "CLI Arguments",
        snippet: "Prints the current Version",
      ),
    ],
  ),

  SearchEntry(
    pageTitle: "Post-Processing",
    route: '/shaders/advanced/post-processing',
    searchHits: [
      // Page-level
      SearchHit(
        keyword: "Post-Processing",
        snippet:
            "Post-processing shaders that modify the final output of a shader using one or more configurable passes.",
        heading: "Post-Processing",
      ),

      // Concept & configuration
      SearchHit(
        keyword: "Post-Processing chain",
        snippet:
            "Each shader can define a chain of post-processing effects that are applied after the main render stage.",
        heading: "Post-Processing",
      ),
      SearchHit(
        keyword: "post-processing YAML",
        snippet:
            "Post-processing effects are defined per shader in the main configuration file using the post-processing key.",
        heading: "Post-Processing",
      ),
      SearchHit(
        keyword: "Post-Processing passes",
        snippet:
            "Each post-processing effect can be applied multiple times using configurable passes.",
        heading: "Post-Processing",
      ),
      SearchHit(
        keyword: "Post-Processing passes numbering",
        snippet:
            "Each pass is indexed sequentially across the entire chain, even when the same effect appears multiple times.",
        heading: "Post-Processing",
      ),

      // Internal mechanics
      SearchHit(
        keyword: "Post-Processing struct",
        snippet:
            "Each post-processing effect is defined as a struct in its corresponding primitive file.",
        heading: "Post-Processing",
      ),
      SearchHit(
        keyword: "#expand directive",
        snippet:
            "WayVes uses the #expand directive to statically unroll post-processing passes with unique variable names.",
        heading: "Post-Processing",
      ),
      SearchHit(
        keyword: "Post-Processing variable suffix",
        snippet:
            "Functions for each pass are suffixed by the pass index, such as glow0, glow1, and so on.",
        heading: "Post-Processing",
      ),
      SearchHit(
        keyword: "set<PostProcessing> functions",
        snippet:
            "Each post-processing pass is controlled via a set<PostProcessingName><PassIndex> function.",
        heading: "Post-Processing",
      ),

      // Glow
      SearchHit(
        keyword: "Glow",
        snippet:
            "Glow is a post-processing effect that adds a glowing halo to the final shader output.",
        heading: "Glow",
      ),
      SearchHit(
        keyword: "Glow passes",
        snippet:
            "Multiple glow passes can be chained to create layered or intensified glow effects.",
        heading: "Glow",
      ),
      SearchHit(
        keyword: "Glow struct",
        snippet:
            "Glow parameters are defined using the Glow struct, including intensity, size, color, and blend mode.",
        heading: "Glow",
      ),
      SearchHit(
        keyword: "setGlow0",
        snippet:
            "The first glow pass is configured using the setGlow0(inout Glow glow) function.",
        heading: "Glow",
      ),
      SearchHit(
        keyword: "setGlow1",
        snippet:
            "Subsequent glow passes are configured using functions like setGlow1, setGlow2, and so on.",
        heading: "Glow",
      ),

      // Rotate
      SearchHit(
        keyword: "Rotate",
        snippet:
            "Rotate is a post-processing effect that rotates the final shader output around a configurable center.",
        heading: "Rotate",
      ),
      SearchHit(
        keyword: "Rotate struct",
        snippet:
            "Rotation parameters are defined using the Rotate struct, including angle and rotation center.",
        heading: "Rotate",
      ),
      SearchHit(
        keyword: "Audio-driven rotation",
        snippet:
            "Rotate angle can be driven by sampled audio data to create frequency-reactive rotation effects.",
        heading: "Rotate",
      ),
      SearchHit(
        keyword: "setRotate0",
        snippet:
            "The first rotate pass is configured using the setRotate0(inout Rotate rotate) function.",
        heading: "Rotate",
      ),

      // Examples
      SearchHit(
        keyword: "Glow example",
        snippet:
            "An example showing how to configure two glow passes using setGlow0 and setGlow1.",
        heading: "Examples",
      ),
      SearchHit(
        keyword: "Multi-pass glow",
        snippet:
            "Demonstrates how multiple glow passes can be combined for layered visual effects.",
        heading: "Examples",
      ),
      SearchHit(
        keyword: "Audio reactive post-processing",
        snippet:
            "Shows how post-processing parameters can react dynamically to audio input.",
        heading: "Examples",
      ),
      SearchHit(
        keyword: "Rotate with audio",
        snippet:
            "An example where rotation is triggered by lower audio frequencies.",
        heading: "Examples",
      ),
    ],
  ),

  SearchEntry(
    pageTitle: "Performance",
    route: '/recommendations/performance',
    searchHits: [
      // Page-level
      SearchHit(
        keyword: "Performance",
        snippet:
            "Guidelines and recommendations to improve WayVes performance, focusing on GTK, shader distribution, and compositor settings.",
        heading: "Performance",
      ),

      // Core architecture & performance model
      SearchHit(
        keyword: "Wayland Layer Shell Protocol",
        snippet:
            "WayVes uses the Wayland Layer Shell Protocol to display shader windows as layers on the screen.",
        heading: "Performance",
      ),
      SearchHit(
        keyword: "GTK4 dependency",
        snippet:
            "GTK4 is used for windowing, styling via CSS, and paintable support, requiring gtk4-layer-shell integration.",
        heading: "Performance",
      ),
      SearchHit(
        keyword: "GTK main thread rendering",
        snippet:
            "Although rendering is asynchronous, render commands are queued to the GTK main thread, which handles UI updates.",
        heading: "Performance",
      ),
      SearchHit(
        keyword: "Audio Object process model",
        snippet:
            "Each Audio Object runs in its own forked GTK4 application process that drives the underlying shaders.",
        heading: "Performance",
      ),
      SearchHit(
        keyword: "Shader distribution",
        snippet:
            "Too many shaders under a single Audio Object can overload the GTK main loop and cause stutters.",
        heading: "Performance",
      ),
      SearchHit(
        keyword: "Splitting shaders",
        snippet:
            "For better performance, shaders should be split across multiple Audio Objects instead of grouping them under one.",
        heading: "Performance",
      ),

      // Compositor & blur warning
      SearchHit(
        keyword: "Compositor blur performance",
        snippet:
            "Blur effects from the compositor can severely impact performance if a shader lies beneath a blurred surface.",
        heading: "Performance",
      ),
      SearchHit(
        keyword: "Disable compositor blur",
        snippet:
            "Disabling blur in the compositor is recommended to avoid massive performance degradation.",
        heading: "Performance",
      ),

      // New GTK renderer section
      SearchHit(
        keyword: "New GTK GL Renderer",
        snippet:
            "GTK4 introduced a new OpenGL renderer and Vulkan backend, which currently may offer worse performance.",
        heading: "New GTK GL Renderer",
      ),
      SearchHit(
        keyword: "GTK Vulkan renderer",
        snippet:
            "The Vulkan renderer is part of GTK4’s new rendering pipeline but may not be optimal for WayVes yet.",
        heading: "New GTK GL Renderer",
      ),
      SearchHit(
        keyword: "GTK 4.20 performance",
        snippet:
            "As of GTK 4.20.2, the new renderers may perform worse than older GTK4 OpenGL implementations.",
        heading: "New GTK GL Renderer",
      ),
      SearchHit(
        keyword: "GTK 4.12 recommendation",
        snippet:
            "GTK 4.12.x has been observed to provide significantly better performance for WayVes.",
        heading: "New GTK GL Renderer",
      ),

      // Using old GTK renderer
      SearchHit(
        keyword: "Using the Old GTK Renderer",
        snippet:
            "Instructions to build and use an older GTK4 version to improve WayVes performance.",
        heading: "Using the Old GTK Renderer",
      ),
      SearchHit(
        keyword: "Building GTK4 from source",
        snippet:
            "An older GTK4 version can be built from source with minimal features to optimize performance.",
        heading: "Using the Old GTK Renderer",
      ),
      SearchHit(
        keyword: "Meson GTK build",
        snippet:
            "Meson can be used to configure a minimal GTK4 build by disabling demos, tests, and unused features.",
        heading: "Using the Old GTK Renderer",
      ),
      SearchHit(
        keyword: "Minimal GTK build",
        snippet:
            "WayVes only requires windowing and styling features, allowing unnecessary GTK components to be disabled.",
        heading: "Using the Old GTK Renderer",
      ),

      // Environment variables & linking
      SearchHit(
        keyword: "LD_LIBRARY_PATH",
        snippet:
            "LD_LIBRARY_PATH can be set to ensure WayVes links against the prefixed GTK4 build.",
        heading: "Using the Old GTK Renderer",
      ),
      SearchHit(
        keyword: "GSETTINGS_SCHEMA_DIR",
        snippet:
            "GSETTINGS_SCHEMA_DIR must point to the prefixed GTK4 schema directory when using a custom build.",
        heading: "Using the Old GTK Renderer",
      ),
      SearchHit(
        keyword: "GTK_PATH",
        snippet:
            "GTK_PATH ensures GTK loads resources from the custom installation directory.",
        heading: "Using the Old GTK Renderer",
      ),
      SearchHit(
        keyword: "LD_PRELOAD GTK",
        snippet:
            "LD_PRELOAD can be used to explicitly force loading the older libgtk-4.so.1 if automatic linking fails.",
        heading: "Using the Old GTK Renderer",
      ),
      SearchHit(
        keyword: "ldd WayVes",
        snippet:
            "The ldd command can be used to verify that WayVes is linked against the intended GTK libraries.",
        heading: "Using the Old GTK Renderer",
      ),
    ],
  ),

  SearchEntry(
    pageTitle: "Z-Index Ordering",
    route: '/shaders/advanced/z-orders',
    searchHits: [
      // Page-level
      SearchHit(
        keyword: "Z-Index Ordering",
        snippet:
            "Control the stacking order, blending behavior, and cut-through logic of primitives, caps, and connectors in Linear and Angular shaders.",
        heading: "Z-Index Ordering",
      ),
      SearchHit(
        keyword: "zOrder array",
        snippet:
            "The zOrder array defines the relative Z-index of every SDF and determines draw order.",
        heading: "Z-Index Ordering",
      ),

      // Core concepts
      SearchHit(
        keyword: "Primitives Caps Connectors",
        snippet:
            "Linear and Angular shaders expose primitives that may include caps and connectors, all of which participate in Z-index ordering.",
        heading: "Z-Index Ordering",
      ),
      SearchHit(
        keyword: "Transparency stacking",
        snippet:
            "Z-index ordering is most noticeable when objects use transparency, as layering becomes visually apparent.",
        heading: "Z-Index Ordering",
      ),
      SearchHit(
        keyword: "modifySDFs",
        snippet:
            "Z-ordering and SDF interactions can be customized inside the modifySDFs() function.",
        heading: "Z-Index Ordering",
      ),

      // Z-Orders system
      SearchHit(
        keyword: "Z-Orders helpers",
        snippet:
            "Z-Orders helper files provide functions for rearranging Z-index, blend mode, and passthrough behavior per group.",
        heading: "Z-Index Ordering",
      ),
      SearchHit(
        keyword: "linear zOrders.glsl",
        snippet:
            "The Linear shader provides zOrders.glsl with helper functions for group-based Z-index manipulation.",
        heading: "Z-Index Ordering",
      ),
      SearchHit(
        keyword: "angular zOrders.glsl",
        snippet:
            "The Angular shader provides zOrders.glsl with equivalent Z-index control, including Circle group support.",
        heading: "Z-Index Ordering",
      ),

      // Layer offsets
      SearchHit(
        keyword: "setLayerOffsets",
        snippet:
            "setLayerOffsets defines the relative stacking order of major groups such as bars, particles, and circles.",
        heading: "Z-Index Ordering",
      ),
      SearchHit(
        keyword: "Group Z-Index offsets",
        snippet:
            "Group offsets determine which entire group appears above or below others.",
        heading: "Z-Index Ordering",
      ),

      // Constraints
      SearchHit(
        keyword: "Unique Z-Indices",
        snippet:
            "All Z-index values must be unique; duplicate values lead to undefined behavior.",
        heading: "Z-Index Ordering",
      ),
      SearchHit(
        keyword: "Relative Z-Index",
        snippet:
            "Z-indices are relative and always start from zero within a group or layer.",
        heading: "Z-Index Ordering",
      ),

      // Group mechanics
      SearchHit(
        keyword: "Group Z-Index",
        snippet:
            "Each group exposes functions to set Z-index ordering for individual objects within that group.",
        heading: "Z-Index Ordering",
      ),
      SearchHit(
        keyword: "Color Blend Mode",
        snippet:
            "Color Blend Mode controls whether underlying objects blend with or get cut by objects above them.",
        heading: "Z-Index Ordering",
      ),
      SearchHit(
        keyword: "PassThrough",
        snippet:
            "PassThrough controls how deep a non-additive object cuts through lower layers.",
        heading: "Z-Index Ordering",
      ),

      // Circle group
      SearchHit(
        keyword: "Circle Group",
        snippet:
            "The Circle group is available only in the Angular shader and consists of inner and outer circles.",
        heading: "Circle Group",
      ),
      SearchHit(
        keyword: "Circle Z-Index",
        snippet:
            "Circle group Z-index functions allow ordering inner and outer circles.",
        heading: "Circle Group",
      ),

      // Bars group
      SearchHit(
        keyword: "Bars Group",
        snippet:
            "The Bars group contains bar background, inner bar, outer bar, and caps with full Z-index control.",
        heading: "Bars Group",
      ),
      SearchHit(
        keyword: "Bar caps",
        snippet:
            "Upper and lower bar caps participate in Z-index ordering and blending.",
        heading: "Bars Group",
      ),

      // Upper particles
      SearchHit(
        keyword: "Upper Particles Group",
        snippet:
            "Upper particles include inner and outer particles, connectors, and caps, all configurable via Z-orders.",
        heading: "Upper Particles Group",
      ),

      // Lower particles
      SearchHit(
        keyword: "Lower Particles Group",
        snippet:
            "Lower particles mirror the upper group with independent Z-index, blending, and passthrough controls.",
        heading: "Lower Particles Group",
      ),

      // Manual overrides
      SearchHit(
        keyword: "Manual Z-Order override",
        snippet:
            "Z-index ordering can be manually overridden by directly manipulating the zOrder array.",
        heading: "Manually overriding Z-Orders and SDFs",
      ),
      SearchHit(
        keyword: "Manual SDF manipulation",
        snippet:
            "The sdfs array can be modified directly to hide, cut, or subtract shapes based on Z-order.",
        heading: "Manually overriding Z-Orders and SDFs",
      ),
      SearchHit(
        keyword: "SDF subtraction",
        snippet:
            "SDF subtraction can be used to hide particles when intersected by higher-priority shapes.",
        heading: "Manually overriding Z-Orders and SDFs",
      ),
      SearchHit(
        keyword: "Cut-through logic",
        snippet:
            "Non-additive blending combined with passthrough enables precise cut-through effects between layers.",
        heading: "Manually overriding Z-Orders and SDFs",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/overview',
    pageTitle: "Overview",
    searchHits: [
      SearchHit(
        keyword: "shaders overview",
        heading: "Overview",
        snippet:
            "Overview of all shader-based visualisers available in WayVes and how they are structured.",
      ),
      SearchHit(
        keyword: "visualisers overview",
        heading: "Overview",
        snippet:
            "High-level overview of WayVes visualisers that are implemented as shader programs.",
      ),
      SearchHit(
        keyword: "shader programs",
        heading: "Overview",
        snippet:
            "WayVes visualisers are implemented as shader programs enabled through the main configuration file.",
      ),
      SearchHit(
        keyword: "enable shaders",
        heading: "Overview",
        snippet:
            "Shaders can be enabled and configured via the main YAML configuration file.",
      ),
      SearchHit(
        keyword: "main configuration file",
        heading: "Overview",
        snippet:
            "Shader visualisers are selected and controlled through the main configuration file.",
      ),
      SearchHit(
        keyword: "structs.glsl",
        heading: "Overview",
        snippet:
            "Primary shader documentation is generated from the structs.glsl files in each shader folder.",
      ),
      SearchHit(
        keyword: "shader documentation",
        heading: "Overview",
        snippet:
            "Documentation for shader structures and parameters is sourced directly from GLSL struct definitions.",
      ),
      SearchHit(
        keyword: "shader structures",
        heading: "Overview",
        snippet:
            "Each shader exposes primary structures defined in its structs.glsl file.",
      ),
      SearchHit(
        keyword: "shader customisation",
        heading: "Overview",
        snippet:
            "Shaders can be customised extensively by modifying their exposed structures and parameters.",
      ),
      SearchHit(
        keyword: "shader parameters",
        heading: "Overview",
        snippet:
            "Shader parameters are defined in GLSL structs and consumed by the rendering pipeline.",
      ),
      SearchHit(
        keyword: "audio data consumption",
        heading: "Overview",
        snippet:
            "Captured audio data is provided to shaders as a read-only entity meant to be consumed, not modified.",
      ),
      SearchHit(
        keyword: "read only values",
        heading: "Overview",
        snippet:
            "Values marked with '-' in examples indicate read-only data that should not be modified.",
      ),
      SearchHit(
        keyword: "immutable shader values",
        heading: "Overview",
        snippet:
            "Certain shader values are immutable and intended only for consumption within the shader.",
      ),
      SearchHit(
        keyword: "shader chain overview",
        heading: "Overview",
        snippet:
            "This page serves as an entry point before exploring individual shader chains and implementations.",
      ),
      SearchHit(
        keyword: "getting started with shaders",
        heading: "Overview",
        snippet:
            "Start here to understand how WayVes shaders are organised and documented.",
      ),
    ],
  ),

  SearchEntry(
    route: '/getting-started/installation',
    pageTitle: "Installation",
    searchHits: [
      SearchHit(
        keyword: "Requirements",
        heading: "Requirements",
        snippet:
            "`WayVes` runs on `Wayland` and requires `GTK4`, `GTK4 Layer Shell`, `DBus`, `LibCYAML`, and `PipeWire` to be installed.",
      ),
      SearchHit(
        keyword: "Wayland",
        heading: "Requirements",
        snippet:
            "`WayVes` runs on `Wayland` and relies on Wayland-compatible system components.",
      ),
      SearchHit(
        keyword: "GTK4",
        heading: "Requirements",
        snippet:
            "`GTK4` is required for windowing and rendering support in `WayVes`.",
      ),
      SearchHit(
        keyword: "GTK4 Layer Shell",
        heading: "Requirements",
        snippet:
            "`GTK4 Layer Shell` is used to place `Shader` windows on specific `Wayland layers`.",
      ),
      SearchHit(
        keyword: "LibCYAML",
        heading: "Requirements",
        snippet:
            "`LibCYAML` is required to parse the `config.yaml` file used by `WayVes`.",
      ),

      SearchHit(
        keyword: "DBus",
        heading: "Requirements",
        snippet: "`DBus` is required to pass runtime messages to `WayVes`.",
      ),
      SearchHit(
        keyword: "PipeWire",
        heading: "Requirements",
        snippet:
            "`PipeWire` is used for capturing and processing audio data in real time.",
      ),
      SearchHit(
        keyword: "Arch Linux installation",
        heading: "Requirements",
        snippet:
            "On Arch Linux, required dependencies can be installed using `pacman`.",
      ),
      SearchHit(
        keyword: "Debian installation",
        heading: "Requirements",
        snippet:
            "On Debian-based systems, install the required development packages using `apt`.",
      ),
      SearchHit(
        keyword: "Build dependencies from source",
        heading: "Requirements",
        snippet:
            "`GTK4 Layer Shell` and `LibCYAML` can be built from source if not available in your distro repositories.",
      ),
      SearchHit(
        keyword: "Installation",
        heading: "Installation",
        snippet:
            "Clone the `WayVes` repository, build the project, and install it using `make`.",
      ),
      SearchHit(
        keyword: "make install",
        heading: "Installation",
        snippet:
            "`WayVes` can be installed system-wide using the `make install` command.",
      ),
    ],
  ),

  SearchEntry(
    route: '/getting-started/usage',
    pageTitle: "Usage",
    searchHits: [
      SearchHit(
        keyword: "Usage",
        heading: "Usage",
        snippet:
            "`WayVes` reads from a `YAML` file that specifies the layout and positioning of each `Shader` / `Visualiser` on the screen.",
      ),

      SearchHit(
        keyword: "config.yaml",
        heading: "Usage",
        snippet:
            "By default, the `config.yaml` file present in `\$XDG_CONFIG_HOME` is read when `WayVes` starts.",
      ),

      SearchHit(
        keyword: "-f",
        heading: "Usage",
        snippet:
            "You can specify a different `YAML configuration file` using the `-f` CLI argument.",
      ),

      SearchHit(
        keyword: "Fragment Shader",
        heading: "Usage",
        snippet:
            "Each Visualiser is an `OpenGL` program that primarily uses a `Fragment Shader` to display visuals.",
      ),

      SearchHit(
        heading: "Usage",
        keyword: "Runtime Environment Variables",
        snippet:
            "Newer GTK4 versions might require you to set `GSK_RENDERER=opengl` and `GDK_DEBUG=gl-prefer-gl` Environment Variables first.",
      ),

      SearchHit(
        keyword: ".glsl configuration",
        heading: "Usage",
        snippet:
            "Shader attributes are defined using `.glsl` files, which are parsed and fed into the `Shader Pipeline`.",
      ),

      SearchHit(
        keyword: "ShaderName.glsl",
        heading: "Usage",
        snippet:
            "By default, a `Shader` named `ShaderName` reads its configuration from `ShaderName.glsl` unless overridden.",
      ),

      SearchHit(
        keyword: "styles.css",
        heading: "Usage",
        snippet:
            "The `styles.css` file can be used to modify window properties or embed visualisers into the wallpaper.",
      ),

      SearchHit(
        keyword: "Starter Configuration",
        heading: "Starter Configuration",
        snippet:
            "Starter configuration files can be copied from `starter-configs/` to `\$XDG_CONFIG_HOME/WayVes/` to get started quickly.",
      ),

      SearchHit(
        keyword: "starter-configs",
        heading: "Starter Configuration",
        snippet:
            "Running `WayVes` with the starter configuration displays `Linear` and `Angular` Visualisers reacting to audio in real time.",
      ),
    ],
  ),

  SearchEntry(
    route: '/introduction/overview',
    pageTitle: "Shaders",
    searchHits: [
      SearchHit(
        keyword: "Shaders",
        heading: "Shaders",
        snippet:
            "This page provides a brief overview of `OpenGL Shaders` and how `WayVes` utilises them.",
      ),

      SearchHit(
        keyword: "OpenGL Shaders",
        heading: "Shaders",
        snippet:
            "`OpenGL` works using `Shaders`, which are programs that run on the GPU.",
      ),

      SearchHit(
        keyword: "Vertex Shader",
        heading: "Vertex Shader",
        snippet:
            "`Vertex Shaders` process vertex positions and determine how geometry is placed on the screen.",
      ),

      SearchHit(
        keyword: "coordinateRotation",
        heading: "Vertex Shader",
        snippet:
            "The `coordinateRotation` property determines the angle of the orthogonal coordinate system used to draw `Shaders`.",
      ),

      SearchHit(
        keyword: "Fragment Shader",
        heading: "Fragment Shader",
        snippet:
            "`Fragment Shaders` determine the color of each pixel and require a `Vertex Shader` to run first.",
      ),

      SearchHit(
        keyword: "gl_FragCoord",
        heading: "Fragment Shader",
        snippet:
            "`gl_FragCoord` provides fragment coordinates as a `vec4` containing `(x, y, z, 1 / w)`.",
      ),

      SearchHit(
        keyword: "Normalized Coordinates",
        heading: "Fragment Shader",
        snippet:
            "Fragment coordinates can be normalized to the range `[0, 1]` by dividing `gl_FragCoord.xy` by `resolution.xy`.",
      ),

      SearchHit(
        keyword: "FragColor",
        heading: "Fragment Shader",
        snippet:
            "`FragColor` is a `vec4` output that defines the final `RGBA` color of a fragment.",
      ),

      SearchHit(
        keyword: "Premultiplied Alpha",
        heading: "Fragment Shader",
        snippet:
            "`WayVes` uses `Premultiplied Alpha` instead of `glBlendFunc` to avoid mismatched outputs across `Shader Stages`.",
      ),

      SearchHit(
        keyword: "Fragment Shader Chain",
        heading: "Fragment Shader",
        snippet:
            "Multiple `Fragment Shaders` can be chained together to apply `Post-Processing` effects like Glow.",
      ),

      SearchHit(
        keyword: "Texture Sampling",
        heading: "Fragment Shader",
        snippet:
            "`Texture Sampling` allows `Fragment Shaders` to read pixel data from previous framebuffer outputs.",
      ),

      SearchHit(
        keyword: "Shader Pipeline",
        heading: "High-Level Overview of a Shader Pipeline",
        snippet:
            "A shader pipeline consists of a `Vertex Stage` followed by one or more `Fragment Shader Stages`.",
      ),
    ],
  ),

  SearchEntry(
    route: '/introduction/data-types',
    pageTitle: "Data Types",
    searchHits: [
      SearchHit(
        heading: "Data Types",
        keyword: "GLSL Data Types",
        snippet:
            "`WayVes` utilises OpenGL-driven Shaders written in `GLSL`, which supports several `scalar`, `vector`, and `matrix` data types.",
      ),

      // Scalars
      SearchHit(
        heading: "Scalars",
        keyword: "Scalar Data Types",
        snippet:
            "Fundamental `GLSL` data types such as `bool, int, float`, and `double`.",
      ),
      SearchHit(
        heading: "Scalars",
        keyword: "bool",
        snippet: "Specifies whether the value is true or false.",
      ),
      SearchHit(
        heading: "Scalars",
        keyword: "int",
        snippet: "Specifies a 32-bit integer number.",
      ),
      SearchHit(
        heading: "Scalars",
        keyword: "float",
        snippet:
            "Specifies a single-precision floating-point number with decimal places.",
      ),
      SearchHit(
        heading: "Scalars",
        keyword: "double",
        snippet:
            "Double-precision floating-point value (OpenGL 4.0 and above).",
      ),

      // Vectors
      SearchHit(
        heading: "Vectors",
        keyword: "Vector Data Types",
        snippet:
            "`GLSL` supports 2, 3, and 4-component vector equivalents of scalar types.",
      ),
      SearchHit(
        heading: "Vectors",
        keyword: "vec2 vec3 vec4",
        snippet:
            "Vectors of 2, 3, or 4 single-precision floating-point values.",
      ),
      SearchHit(
        heading: "Vectors",
        keyword: "bvec",
        snippet: "Boolean vector equivalents of scalar boolean types.",
      ),

      // Swizzling
      SearchHit(
        heading: "Vectors",
        keyword: "Swizzling",
        snippet:
            "Vector components can be accessed and rearranged using `x, y, z, and w` notation.",
      ),
      SearchHit(
        heading: "Vectors",
        keyword: "Vector Initialisation",
        snippet:
            "Initialising a vector with a single value assigns that value to all components.",
      ),

      // Matrices
      SearchHit(
        heading: "Matrices",
        keyword: "Matrix Data Types",
        snippet:
            "GLSL matrices are collections of vectors, represented as `matnxm` or `matn`.",
      ),
      SearchHit(
        heading: "Matrices",
        keyword: "Matrix Indexing",
        snippet:
            "Matrix elements can be accessed using `array syntax` instead of `swizzling`.",
      ),
      SearchHit(
        heading: "Matrices",
        keyword: "Matrix Swizzling",
        snippet:
            "`Swizzling` does not work on `matrices`, but it works on `vectors` obtained from `matrices`.",
      ),

      // Explicit Type Conversion
      SearchHit(
        heading: "Explicit Type Conversion",
        keyword: "Type Casting",
        snippet:
            "Data types can be explicitly cast using `datatype(variable)` syntax.",
      ),
      SearchHit(
        heading: "Explicit Type Conversion",
        keyword: "float(int)",
        snippet:
            "Explicit casting allows `integers` to be treated as `floats` before arithmetic operations.",
      ),
    ],
  ),

  SearchEntry(
    route: '/introduction/glsl-functions',
    pageTitle: "GLSL Functions",
    searchHits: [
      SearchHit(
        heading: "GLSL Functions",
        keyword: "GLSL Functions",
        snippet:
            "Common `GLSL` functions that can be used to obtain specific outputs inside `Shaders`.",
      ),

      // Interpolation & range helpers
      SearchHit(
        heading: "GLSL Functions",
        keyword: "step",
        snippet: "Returns 1.0 if `x <= y`, otherwise returns 0.0.",
      ),
      SearchHit(
        heading: "GLSL Functions",
        keyword: "smoothstep",
        snippet:
            "Performs `Smooth Hermite Interpolation` between `a` and `b` using `x`, producing values in the range `[0, 1]`.",
      ),
      SearchHit(
        heading: "GLSL Functions",
        keyword: "mix",
        snippet:
            "Linearly interpolates between `a` and `b` using `x` as the mixing factor.",
      ),
      SearchHit(
        heading: "GLSL Functions",
        keyword: "clamp",
        snippet:
            "Restricts a value to lie within a specified minimum and maximum range.",
      ),

      // Min / Max
      SearchHit(
        heading: "GLSL Functions",
        keyword: "min",
        snippet: "Returns the smaller of two values.",
      ),
      SearchHit(
        heading: "GLSL Functions",
        keyword: "max",
        snippet: "Returns the larger of two values.",
      ),

      // Trigonometric functions
      SearchHit(
        heading: "GLSL Functions",
        keyword: "sin",
        snippet: "Returns the sine of the given angle.",
      ),
      SearchHit(
        heading: "GLSL Functions",
        keyword: "cos",
        snippet: "Returns the cosine of the given angle.",
      ),
      SearchHit(
        heading: "GLSL Functions",
        keyword: "tan",
        snippet: "Returns the tangent of the given angle.",
      ),

      // Inverse trigonometric functions
      SearchHit(
        heading: "GLSL Functions",
        keyword: "asin",
        snippet:
            "Returns the angle whose sine is `x`. Result lies in the range `[-π/2, π/2]`.",
      ),
      SearchHit(
        heading: "GLSL Functions",
        keyword: "acos",
        snippet:
            "Returns the angle whose cosine is `x`. Result lies in the range `[0, π]`.",
      ),
      SearchHit(
        heading: "GLSL Functions",
        keyword: "atan",
        snippet:
            "Computes the arctangent using either `y / x` or separate `y` and `x` inputs, determining the correct quadrant.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/chain/overview',
    pageTitle: "Chain",
    searchHits: [
      SearchHit(
        heading: "Chain",
        keyword: "Chain",
        snippet:
            "Simple `Chain` Visualiser, as seen on `Panon`, a Visualiser for `KDE Plasma`",
      ),

      // Audio Settings
      SearchHit(
        heading: "Audio Settings",
        keyword: "Audio Settings",
        snippet:
            "Represents the various Audio-transformation properties for each side.",
      ),
      SearchHit(
        heading: "Audio Settings",
        keyword: "reverseLeft",
        snippet: "Specifies the reversal of the left audio channel.",
      ),
      SearchHit(
        heading: "Audio Settings",
        keyword: "reverseRight",
        snippet: "Specifies the reversal of the right audio channel.",
      ),
      SearchHit(
        heading: "Audio Settings",
        keyword: "mode",
        snippet: "0 for mirrored audio output, 1 for linear audio output.",
      ),
      SearchHit(
        heading: "Audio Settings",
        keyword: "combineChannels",
        snippet:
            "Specifies whether the audio values should be combined from the left and right channels.",
      ),

      // Audio
      SearchHit(
        heading: "Audio",
        keyword: "Audio",
        snippet: "Represents Audio Settings and captured Audio Data.",
      ),
      SearchHit(
        heading: "Audio",
        keyword: "value",
        snippet:
            "Stores the captured Audio Data's left channel data in x, and the right audio channel data in y.",
      ),
      SearchHit(
        heading: "Audio",
        keyword: "multiplier",
        snippet: "Amplification for the audio value.",
      ),

      // Chain struct
      SearchHit(
        heading: "Chain ",
        keyword: "Chain Object",
        snippet: "Represents the `Chain` Object.",
      ),
      SearchHit(
        heading: "Chain ",
        keyword: "heightRatio",
        snippet:
            "The extent of the height of the `Chain`, compared to the total height of the Window.",
      ),
      SearchHit(
        heading: "Chain ",
        keyword: "strength",
        snippet:
            "The overall visibility of the `Particles` within the `Chain`.",
      ),
      SearchHit(
        heading: "Chain ",
        keyword: "radius",
        snippet: "The radius of the `Chain`.",
      ),
      SearchHit(
        heading: "Chain ",
        keyword: "density",
        snippet: "The number of `Particles` within a section of the `Chain`.",
      ),
      SearchHit(
        heading: "Chain ",
        keyword: "color",
        snippet: "Color of the `Chain`.",
      ),
      SearchHit(
        heading: "Chain ",
        keyword: "interChannelDistance",
        snippet:
            "The vertical distance between the top and lower halves of the `Chain`.",
      ),
      SearchHit(
        heading: "Chain ",
        keyword: "verticalColorDropExtent",
        snippet:
            "Determines the color drop-off as `Particles` go vertically away from the `Chain's` center.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/chain/configuration',
    pageTitle: "Chain Configuration",
    searchHits: [
      // Trivial Working Structure
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "Trivial Working Structure",
        snippet:
            "Minimal working structure for a `Chain` shader using lifecycle functions.",
      ),
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "init",
        snippet:
            "`init()` is used to initialise properties that must be set before audio is processed.",
      ),
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "audioFetch",
        snippet:
            "`audioFetch()` is called after audio data is fetched, allowing transformation of the audio value.",
      ),
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "setProps",
        snippet:
            "`setProps()` is used to configure visual properties such as size, color, and offsets.",
      ),

      // coordinateRotation
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "coordinateRotation",
        snippet:
            "The relative angle of the Orthogonal Coordinate System used to draw the Shaders, from the center of the Window View.",
      ),
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "Orthogonal Coordinate System",
        snippet:
            "A coordinate-basis transform rather than a simple rotation about the Z-axis.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/chain/life-cycle',
    pageTitle: "Life Cycle",
    searchHits: [
      // Page overview
      SearchHit(
        heading: "Life Cycle",
        keyword: "Life Cycle",
        snippet:
            "Functions that are called at particular instances within the Chain Shader",
      ),

      // init()
      SearchHit(
        heading: "Life Cycle",
        keyword: "init()",
        snippet: "Called before the Shader starts taking in the Audio Data.",
      ),
      SearchHit(
        heading: "Life Cycle",
        keyword: "initialisation",
        snippet:
            "`init()` is used to set initial values such as `chain.density` and `audio.multiplier` before audio processing begins.",
      ),

      // audioFetch()
      SearchHit(
        heading: "Life Cycle",
        keyword: "audioFetch()",
        snippet:
            "Called just after the Audio Data has been fed into the Shader.",
      ),
      SearchHit(
        heading: "Life Cycle",
        keyword: "fetchedAudio",
        snippet:
            "Fetched Audio is provided in the normalised range `[0, 1]` and can be modified inside `audioFetch()`.",
      ),
      SearchHit(
        heading: "Life Cycle",
        keyword: "audio multiplier",
        snippet:
            "After `audioFetch()` returns, the fetched audio value gets multiplied by the configured multiplier.",
      ),

      // setProps()
      SearchHit(
        heading: "Life Cycle",
        keyword: "setProps()",
        snippet:
            "Sets various visual properties of the Shader, such as Strength and Color.",
      ),
      SearchHit(
        heading: "Life Cycle",
        keyword: "chain.color",
        snippet:
            "`setProps()` can dynamically control visual properties like `chain.color` based on audio input.",
      ),
      SearchHit(
        heading: "Life Cycle",
        keyword: "chain.channelLineHeight",
        snippet:
            "Controls geometry-related properties such as the center line height of the `Chain`.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/chain/examples',
    pageTitle: "Chain Examples",
    searchHits: [
      SearchHit(
        keyword: "Chain Examples",
        heading: "Dynamically-colored Chain",
        snippet:
            "Example configurations demonstrating how the `Chain` shader can be styled and modified using real GLSL code.",
      ),

      SearchHit(
        keyword: "Dynamically-colored Chain",
        heading: "Dynamically-colored Chain",
        snippet:
            "Chain with Hue interpolation that changes dynamically with Audio input.",
      ),

      SearchHit(
        keyword: "interpolateHue",
        heading: "Dynamically-colored Chain",
        snippet:
            "Uses `interpolateHue` to smoothly vary the `Chain` color based on audio-driven values.",
      ),

      SearchHit(
        keyword: "audio.multiplier",
        heading: "Dynamically-colored Chain",
        snippet:
            "Amplifies the captured Audio Data to influence the visual response of the `Chain`.",
      ),

      SearchHit(
        keyword: "chain.density",
        heading: "Dynamically-colored Chain",
        snippet:
            "Controls the number of `Particles` used to form the `Chain` structure.",
      ),

      SearchHit(
        keyword: "chain.color",
        heading: "Dynamically-colored Chain",
        snippet:
            "Sets the final color of the `Chain`, here driven by Audio values and spatial index.",
      ),

      SearchHit(
        keyword: "utils/colors.glsl",
        heading: "Dynamically-colored Chain",
        snippet:
            "Includes utility color functions such as `interpolateHue` for advanced color manipulation.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/linear/overview',
    pageTitle: "Linear",
    searchHits: [
      // Overview
      SearchHit(
        heading: "Linear",
        keyword: "Linear",
        snippet:
            "The `Linear` Visualiser represents the Set of `Bars`, `Particles` and `Particle Connectors` that can be drawn on a straight line.",
      ),

      // Core concepts
      SearchHit(
        heading: "Primitives",
        keyword: "Primitives",
        snippet: "A `Bar` or a `Particle` is referred to as a `Primitive`.",
      ),
      SearchHit(
        heading: "Fragments",
        keyword: "Fragments",
        snippet:
            "A `Fragment` is the division of the total Window View into different 'Columns'. This serves as the housing space for the `Primitives`.",
      ),
      SearchHit(
        heading: "Fragments",
        keyword: "fragmentWidth",
        snippet:
            "Each `Fragment` has a width that must be a constant throughout the current Frame of the Shader Program, and is represented by `fragmentWidth`.",
      ),

      // Working / pipeline
      SearchHit(
        heading: "Working",
        keyword: "Common GLSL Configuration File",
        snippet:
            "In the `Common GLSL Configuration File`, various variables and functions have been laid out that are essential for the `Shader` to Compile.",
      ),
      SearchHit(
        heading: "Working",
        keyword: "Primitive Types",
        snippet:
            "Type(s) of `Primitive` to display (`Bar`, `Particle`, or both) are specified in the configuration.",
      ),

      // ===== Audio Settings struct =====
      SearchHit(
        heading: "Audio Settings",
        keyword: "Audio Settings",
        snippet:
            "Represents the various Audio-transformation properties for each side.",
      ),
      SearchHit(
        heading: "Audio Settings",
        keyword: "reverseLeft",
        snippet:
            "Specifies the reversal of the left audio channel. Either 0 or 1.",
      ),
      SearchHit(
        heading: "Audio Settings",
        keyword: "reverseRight",
        snippet:
            "Specifies the reversal of the right audio channel. Either 0 or 1.",
      ),
      SearchHit(
        heading: "Audio Settings",
        keyword: "mode",
        snippet: "0 for mirrored audio output, 1 for linear audio output.",
      ),
      SearchHit(
        heading: "Audio Settings",
        keyword: "combineChannels",
        snippet:
            "Specifies whether the audio values should be combined from the left and right channels.",
      ),

      // ===== Audio struct =====
      SearchHit(
        heading: "Audio",
        keyword: "Audio",
        snippet: "Represents the captured Audio Data, and its multiplier.",
      ),
      SearchHit(
        heading: "Audio",
        keyword: "multiplier",
        snippet: "Amplification for the audio value.",
      ),
      SearchHit(
        heading: "Audio",
        keyword: "current",
        snippet:
            "Stores the `Current Fragment's` left audio channel data in x, and the right audio channel data in y.",
      ),
      SearchHit(
        heading: "Audio",
        keyword: "prev",
        snippet:
            "Stores the `Previous Fragment's` left audio channel data in x, and the right audio channel data in y.",
      ),
      SearchHit(
        heading: "Audio",
        keyword: "next",
        snippet:
            "Stores the `Next Fragment's` left audio channel data in x, and the right audio channel data in y.",
      ),

      // ===== Fragment struct =====
      SearchHit(
        heading: "Fragment",
        keyword: "Fragment",
        snippet:
            "Represents the underlying `Fragment` that can show one `Particle` and one `Bar`. None of the Attributes are meant to be modified.",
      ),
      SearchHit(
        heading: "Fragment",
        keyword: "n",
        snippet: "Number of the current `Fragment`. Ranges from 0 to `lastN`.",
      ),
      SearchHit(
        heading: "Fragment",
        keyword: "lastN",
        snippet: "Number of the last possible `Fragment`.",
      ),
      SearchHit(
        heading: "Fragment",
        keyword: "span",
        snippet:
            "Span of the `Fragment`. Lies in `[-fragmentWidth/2.,fragmentWidth/2.]`",
      ),
      SearchHit(
        heading: "Fragment",
        keyword: "coords",
        snippet:
            "Absolute Coordinates in the `Shader`, corresponding to `(x,y)`.",
      ),
      SearchHit(
        heading: "Fragment",
        keyword: "centerCoords",
        snippet: "Absolute Coordinates of the `Fragment's Center`.",
      ),

      // Bar
      SearchHit(heading: "Bar", keyword: "Bar", snippet: "Represents a `Bar`."),
      SearchHit(
        heading: "Bar",
        keyword: "mergeLeftBar",
        snippet: "Specifies merging of the `Bar` on the Left. Either 0 or 1.",
      ),
      SearchHit(
        heading: "Bar",
        keyword: "mergeRightBar",
        snippet: "Specifies merging of the `Bar` on the Right. Either 0 or 1.",
      ),

      // Particle
      SearchHit(
        heading: "Particle",
        keyword: "Particle",
        snippet: "Represents a `Particle`.",
      ),
      SearchHit(
        heading: "Particle",
        keyword: "setOffsets()",
        snippet: "Use `setOffsets()` to properly show connectors if enabled.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/linear/configuration',
    pageTitle: "Linear Configuration",
    searchHits: [
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "Trivial Working Structure",
        snippet:
            "Minimal GLSL configuration required to compile and run the `Linear` shader, including lifecycle functions and base defines.",
      ),

      // Base variables
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "coordinateRotation",
        snippet:
            "The relative angle of the Orthogonal Coordinate System used to draw the `Shaders`, from the center of the Window View. This is a Coordinate-Basis Transform.",
      ),
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "fragmentWidth",
        snippet: "The width of each `Fragment`, that stores a `Primitive`.",
      ),

      SearchHit(
        heading: "Left Padding",
        keyword: "leftPadding",
        snippet: "Amount of space that is reserved from the left side",
      ),
      SearchHit(
        heading: "Right Padding",
        keyword: "rightPadding",
        snippet: "Amount of space that is reserved from the right side",
      ),
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "visualiserDirections",
        snippet:
            "Controls the number of vertical directions for the `Primitives`: Up, Down, or both.",
      ),
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "visualiserMode",
        snippet:
            "Decides the type of `Primitives` to draw: `Particles`, `Bars`, or both.",
      ),

      // Lifecycle
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "init()",
        snippet:
            "Called before the shader starts taking in audio data. Used to initialise configuration values.",
      ),
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "audioFetch()",
        snippet:
            "Called after audio data is fetched. Allows modification of the normalised audio value before multipliers are applied.",
      ),
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "setOffsets()",
        snippet:
            "Applies synchronised offsets for particles and bars, ensuring connectors and merged primitives remain aligned.",
      ),
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "setProps()",
        snippet:
            "Sets visual properties for the `Linear` shader, such as sizes, colors, and strengths.",
      ),
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "setParticleDownProps()",
        snippet:
            "Overrides or adjusts properties specifically for the bottom particle layer.",
      ),
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "modifySDFs()",
        snippet:
            "Final stage to alter signed distance fields before colors are applied and the frame is rendered.",
      ),

      // Warning / best practice
      SearchHit(
        heading: "Trivial Working Structure",
        keyword: "gl_FragCoord",
        snippet:
            "Avoid directly using `gl_FragCoord` for querying coordinates. Use `bar.fragment.coords` or `particle.fragment.coords` instead.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/linear/life-cycle',
    pageTitle: "Linear Life Cycle",
    searchHits: [
      SearchHit(
        heading: "Life Cycle",
        keyword: "Life Cycle",
        snippet:
            "Functions that are called at particular instances within the Linear Shader.",
      ),

      SearchHit(
        heading: "Life Cycle",
        keyword: "Linear and Angular lifecycle",
        snippet:
            "Both Linear and Angular Visualisers have the same Life Cycle Functions.",
      ),

      SearchHit(
        heading: "Life Cycle",
        keyword: "init()",
        snippet: "Called before the Shader starts taking in the Audio Data.",
      ),

      SearchHit(
        heading: "Life Cycle",
        keyword: "audioFetch()",
        snippet:
            "Called just after the Audio Data has been fed into the Shader. Fetched Audio is in the normalised Range `[0, 1]`, and after the function returns, gets multiplied by the multiplier values.",
      ),

      SearchHit(
        heading: "Life Cycle",
        keyword: "setOffsets()",
        snippet:
            "Ensures proper Offset Synchronisation when `bar.mergeLeftBar` / `bar.mergeRightBar` or `particle.connector.left.enable` / `particle.connector.right.enable` is set to `1`.",
      ),

      SearchHit(
        heading: "Life Cycle",
        keyword: "setProps()",
        snippet:
            "Sets various visual properties of the Shader, such as Size, Softness, and Color.",
      ),

      SearchHit(
        heading: "Life Cycle",
        keyword: "setParticleDownProps()",
        snippet:
            "Can be used to change the properties of the Particles that move downwards.",
      ),

      SearchHit(
        heading: "Life Cycle",
        keyword: "modifySDFs()",
        snippet:
            "Can be used to change the shapes of all the objects that will be drawn via the Shader. Colors are applied just after this Function.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/linear/examples',
    pageTitle: "Linear Examples",
    searchHits: [
      SearchHit(
        heading: "Classic Bars",
        keyword: "Classic Bars",
        snippet:
            "Standard, Vertical `Bars` with Blue Inner Color and White Border Color.",
      ),

      SearchHit(
        heading: "Classic Bars",
        keyword: "`Bars` example",
        snippet:
            "Shows a basic Linear setup that renders only `Bars` using `visualiserMode = 1` and `visualiserDirections = 0`.",
      ),

      SearchHit(
        heading: "Classic Bars",
        keyword: "bar.size",
        snippet:
            "Defines the upwards height, width, and downwards height of each `Bar` using a `vec3`.",
      ),

      SearchHit(
        heading: "Classic Bars",
        keyword: "bar.borderSize",
        snippet:
            "Controls the border thickness of each `Bar` for the top, sides, and bottom edges.",
      ),

      SearchHit(
        heading: "Particles",
        keyword: "Particles",
        snippet: "`Particles` with Red Inner Color and Yellow Border Color.",
      ),

      SearchHit(
        heading: "Particles",
        keyword: "`Particles` example",
        snippet:
            "Demonstrates rendering only `Particles` using `visualiserMode = 0` and `visualiserDirections = 2`.",
      ),

      SearchHit(
        heading: "Particles",
        keyword: "particle.radius",
        snippet: "Controls the radius of each `Particle` in pixels.",
      ),

      SearchHit(
        heading: "Particles",
        keyword: "particle.borderSize",
        snippet:
            "Controls the thickness of the outer border of each `Particle`.",
      ),

      SearchHit(
        heading: "Merged Bars",
        keyword: "Merged Bars",
        snippet:
            "Vertically-downward `Bars` where groups are merged together and enhanced with `Caps` that follow Newtonian physics.",
      ),

      SearchHit(
        heading: "Merged Bars",
        keyword: "`mergeLeftBar` / mergeRightBar",
        snippet:
            "Controls grouping of adjacent `Bars` so that they visually merge into larger structures.",
      ),

      SearchHit(
        heading: "Merged Bars",
        keyword: "`Caps` physics",
        snippet:
            "`Caps` simulate acceleration, drag, elasticity, and launch velocity when Bars move vertically.",
      ),

      SearchHit(
        heading: "Merged Bars",
        keyword: "`audioFetch()` shaping",
        snippet:
            "Uses exponential and cosine-based transformations to reshape fetched Audio before visualisation.",
      ),

      SearchHit(
        heading: "Merged Bars",
        keyword: "`mix()` color interpolation",
        snippet:
            "Interpolates Bar colors based on fragment position and current audio value.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/angular/overview',
    pageTitle: "Angular",
    searchHits: [
      SearchHit(
        keyword: "Angular",
        heading: "Angular",
        snippet:
            "Angular counter-part of the Linear Visualiser, represents the set of `Bars`, `Particles` and `Particle Connectors` that can be drawn on a circular path.",
      ),

      // Reference to Linear docs
      SearchHit(
        keyword: "Angular vs Linear",
        heading: "Angular",
        snippet:
            "For information about `Fragments`, `Primitives` and internal working, refer to the Linear Visualiser documentation.",
      ),

      // Audio Settings
      SearchHit(
        keyword: "Audio Settings",
        heading: "Audio Settings",
        snippet:
            "Represents the various audio-transformation properties for each side, including channel reversal, output mode and channel combination.",
      ),
      SearchHit(
        keyword: "reverseLeft / reverseRight",
        heading: "Audio Settings",
        snippet:
            "Specifies the reversal of the left or right audio channel. Either `0` or `1`.",
      ),
      SearchHit(
        keyword: "audio mode",
        heading: "Audio Settings",
        snippet:
            "`0` for mirrored audio output and `1` for linear audio output that splits channels vertically.",
      ),

      // Audio
      SearchHit(
        keyword: "Audio",
        heading: "Audio",
        snippet:
            "Represents the captured audio data and its multiplier for amplification.",
      ),
      SearchHit(
        keyword: "audio.current / audio.prev / audio.next",
        heading: "Audio",
        snippet:
            "Stores left and right channel audio data for the current, previous and next `Fragment`.",
      ),
      SearchHit(
        keyword: "audio.multiplier",
        heading: "Audio",
        snippet: "Amplification factor applied to the fetched audio value.",
      ),

      // Fragment
      SearchHit(
        keyword: "Fragment",
        heading: "Fragment",
        snippet:
            "Represents the underlying `Fragment` that can show one `Particle` and one `Bar` in the Angular Visualiser.",
      ),
      SearchHit(
        keyword: "angular fragment coordinates",
        heading: "Fragment",
        snippet:
            "Includes angular properties such as `currentAngle`, `currentCenterAngle`, and vectors derived from the circle center.",
      ),

      // Circle
      SearchHit(
        keyword: "Circle",
        heading: "Circle",
        snippet:
            "Represents the `Circle` at the center, including radius, angle restriction, softness and colors.",
      ),
      SearchHit(
        keyword: "restrictCircleAngle",
        heading: "Circle",
        snippet:
            "Restricts the circle drawing when `maxAngle` is smaller than `360`.",
      ),

      // Cap
      SearchHit(
        keyword: "Cap",
        heading: "Cap",
        snippet:
            "Represents a `Cap` that can bounce over a `Primitive` (`Bar` or `Particle`) using physics-like properties.",
      ),
      SearchHit(
        keyword: "Angular Cap type",
        heading: "Cap",
        snippet:
            "`0` for angular caps that change width based on height, `1` for fixed-width caps.",
      ),

      // Connector Half
      SearchHit(
        keyword: "Connector Half",
        heading: "Connector Half",
        snippet:
            "Represents the left and right sides of a `Connector`, including size, softness and colors.",
      ),

      // Connector
      SearchHit(
        keyword: "Connector",
        heading: "Connector",
        snippet:
            "Represents the combination of left and right `ConnectorHalf`s, including joint modes and looping behaviour.",
      ),
      SearchHit(
        keyword: "connector looping",
        heading: "Connector",
        snippet:
            "Allows looping and merging of connectors between the first and last `Particles`.",
      ),

      // Bar
      SearchHit(
        keyword: "Bar",
        heading: "Bar",
        snippet:
            "Represents a `Bar` drawn along a circular path, supporting angular, rectangular and rounded types.",
      ),
      SearchHit(
        keyword: "angular bar merging",
        heading: "Bar",
        snippet:
            "Bars can be merged on the left and right, with optional clamping of border edges.",
      ),

      // Particle
      SearchHit(
        keyword: "Particle",
        heading: "Particle",
        snippet:
            "Represents a `Particle` positioned on a circular path, supporting connectors, caps and audio-driven motion.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/angular/configuration',
    pageTitle: "Angular Configuration",
    searchHits: [
      SearchHit(
        keyword: "Trivial Working Structure",
        heading: "Trivial Working Structure",
        snippet:
            "Minimal working `Angular` shader structure showing required includes, base defines, and lifecycle function entry points.",
      ),

      // Base configuration variables
      SearchHit(
        keyword: "coordinateRotation",
        heading: "Trivial Working Structure",
        snippet:
            "Defines the relative angle of the orthogonal coordinate system used to draw the `Shaders`, relative to the window center.",
      ),
      SearchHit(
        keyword: "fragmentAngle",
        heading: "Trivial Working Structure",
        snippet:
            "Defines the angular width of each `Fragment` in degrees for the Angular visualiser.",
      ),
      SearchHit(
        keyword: "angleOffset",
        heading: "Trivial Working Structure",
        snippet:
            "Specifies an angular offset applied to all `Fragments`, rotating the entire Angular layout.",
      ),
      SearchHit(
        keyword: "maxAngle",
        heading: "Trivial Working Structure",
        snippet:
            "Specifies the maximum angular extent (in degrees) over which `Bars` and `Particles` are drawn.",
      ),
      SearchHit(
        keyword: "restrictCircleAngle",
        heading: "Trivial Working Structure",
        snippet:
            "Controls whether the central `Circle` should be restricted when `maxAngle` is less than 360 degrees.",
      ),
      SearchHit(
        keyword: "centerCoords",
        heading: "Trivial Working Structure",
        snippet:
            "Defines the absolute center coordinates of the Angular visualiser, typically set to `vec2(resolution / 2.)`.",
      ),

      // Visualiser behaviour
      SearchHit(
        keyword: "visualiserMode",
        heading: "Trivial Working Structure",
        snippet:
            "Decides which `Primitives` to draw: `Particles`, `Bars`, or both.",
      ),
      SearchHit(
        keyword: "visualiserDirections",
        heading: "Trivial Working Structure",
        snippet:
            "Controls whether `Primitives` are drawn in the upward direction, downward direction, or both.",
      ),

      // Lifecycle hooks
      SearchHit(
        keyword: "init()",
        heading: "Trivial Working Structure",
        snippet:
            "Called before the Angular shader begins processing audio data.",
      ),
      SearchHit(
        keyword: "audioFetch()",
        heading: "Trivial Working Structure",
        snippet:
            "Called after audio data is captured and normalised, allowing transformation of the fetched audio value.",
      ),
      SearchHit(
        keyword: "setOffsets()",
        heading: "Trivial Working Structure",
        snippet:
            "Allows dynamic modification of particle and bar offsets based on audio and fragment position.",
      ),
      SearchHit(
        keyword: "primitiveProps()",
        heading: "Trivial Working Structure",
        snippet:
            "Sets visual properties of Angular `Primitives`, such as size, softness, and color.",
      ),
      SearchHit(
        keyword: "setParticleDownProps()",
        heading: "Trivial Working Structure",
        snippet:
            "Used to override properties of particles rendered in the downward direction.",
      ),
      SearchHit(
        keyword: "modifySDFs()",
        heading: "Trivial Working Structure",
        snippet:
            "Allows direct modification of signed distance fields before final color application.",
      ),

      // Best practices
      SearchHit(
        keyword: "Fragment Coordinates",
        heading: "Trivial Working Structure",
        snippet:
            "Avoid directly using `gl_FragCoord`; instead access coordinates via `bar.fragment.coords` or `particle.fragment.coords`.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/angular/life-cycle',
    pageTitle: "Life Cycle",
    searchHits: [
      SearchHit(
        heading: "Life Cycle",
        keyword: "Angular Life Cycle",
        snippet:
            "Functions that are called at particular instances within the Angular Shader.",
      ),
      SearchHit(
        heading: "Life Cycle",
        keyword: "init()",
        snippet:
            "Called before the Shader starts taking in the Audio Data. Used to initialise Audio settings, multipliers, connectors, and Circle properties.",
      ),
      SearchHit(
        heading: "Life Cycle",
        keyword: "audioFetch()",
        snippet:
            "Called just after the Audio Data has been fed into the Shader. Fetched Audio is in the normalised Range `[0, 1]`, and after the function returns, gets multiplied by the multiplier values.",
      ),
      SearchHit(
        heading: "Life Cycle",
        keyword: "setOffsets()",
        snippet:
            "Ensures proper Offset Synchronisation when `bar.mergeLeftBar` / `bar.mergeRightBar` or `particle.connector.left.enable` / `particle.connector.right.enable` is set to `1`.",
      ),
      SearchHit(
        heading: "Life Cycle",
        keyword: "setProps()",
        snippet:
            "Sets various visual properties of the Shader, such as Size, Softness, Color, and Circle parameters.",
      ),
      SearchHit(
        heading: "Life Cycle",
        keyword: "setParticleDownProps()",
        snippet:
            "Can be used to change the properties of the Particles that move downwards.",
      ),
      SearchHit(
        heading: "Life Cycle",
        keyword: "modifySDFs()",
        snippet:
            "Can be used to change the shapes of all the objects that will be drawn via the Shader. Colors are applied just after this Function.",
      ),
      SearchHit(
        heading: "Life Cycle",
        keyword: "Linear and Angular Life Cycle",
        snippet:
            "Both Linear and Angular Visualisers have the same Life Cycle Functions.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/angular/examples',
    pageTitle: "Examples",
    searchHits: [
      SearchHit(
        heading: "Classic Bars",
        keyword: "Classic Bars",
        snippet:
            "Creates standard, vertical `Bars` with Blue Inner Color and White Border Color using the Angular Shader.",
      ),
      SearchHit(
        heading: "Classic Bars",
        keyword: "bar.audio.multiplier",
        snippet:
            "Sets the audio multiplier for `Bars`, controlling how strongly the captured Audio Data affects their height.",
      ),
      SearchHit(
        heading: "Classic Bars",
        keyword: "bar.size",
        snippet:
            "Defines the size of each `Bar`, where `x` is the upward height, `y` is the width (in degrees), and `z` is the downward height.",
      ),
      SearchHit(
        heading: "Classic Bars",
        keyword: "bar.borderSize",
        snippet:
            "Controls the Border size of each `Bar` for the top, sides, and bottom edges.",
      ),
      SearchHit(
        heading: "Particles",
        keyword: "Particles",
        snippet:
            "Creates Angular `Particles` with Red Inner Color and Yellow Border Color, rendered in both upward and downward directions.",
      ),
      SearchHit(
        heading: "Particles",
        keyword: "particle.audio.multiplier",
        snippet:
            "Sets the audio multiplier for `Particles`, determining their responsiveness to Audio Data.",
      ),
      SearchHit(
        heading: "Particles",
        keyword: "particle.radius",
        snippet: "Specifies the radius of each `Particle` in pixels.",
      ),
      SearchHit(
        heading: "Particles",
        keyword: "particle.borderSize",
        snippet:
            "Specifies the size of the outer Border surrounding each `Particle`.",
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/ncs/overview',
    pageTitle: 'NCS',
    searchHits: [
      SearchHit(
        keyword: 'NCS',
        snippet:
            'Visualiser that represents a `Particle Field` displaced by `4-Dimensional Perlin Noise`.',
        heading: 'NCS',
      ),
      SearchHit(
        keyword: 'NoCopyrightSounds',
        snippet: 'Used in `NoCopyrightSounds` Music Videos on YouTube.',
        heading: 'NCS',
      ),

      SearchHit(
        keyword: 'NCS Audio Settings',
        snippet:
            'Using default PipeWire and Audio Settings is recommended, while capturing at a Sample Rate of 11000 Hz.',
        heading: 'NCS',
      ),

      SearchHit(
        keyword: 'NCS Atomic Texture',
        snippet:
            'Requires 1 Atomic Texture if Color Tracking is disabled, and 5 if it is enabled.',
        heading: 'NCS',
      ),

      // ───────────────── Base Form ─────────────────
      SearchHit(
        keyword: 'Base Form',
        snippet: 'Represents the `Grid` of the `Particles`.',
        heading: 'Base Form',
      ),
      SearchHit(
        keyword: 'type',
        snippet:
            'Type of the `Grid` to use. 0 for `Rectangular`, and 1 for `Spherical Grid` arranged as `Concentric Circles`.',
        heading: 'Base Form',
      ),
      SearchHit(
        keyword: 'scale',
        snippet: 'The overall Scaling Factor for the displayed `Grid`.',
        heading: 'Base Form',
      ),

      SearchHit(
        keyword: 'zSize',
        snippet: 'The size of the Window in the Z Axis.',
        heading: 'Base Form',
      ),
      SearchHit(
        keyword: 'numParticles',
        snippet:
            'The number of `Particles` to render. Maximum number of `Particles` in each Dimension is the size of the window in that dimension.',
        heading: 'Base Form',
      ),
      SearchHit(
        keyword: 'rotations',
        snippet: 'The rotations to apply to the `BaseForm`.',
        heading: 'Base Form',
      ),

      // ─────────────── Particle Properties ───────────────
      SearchHit(
        keyword: 'Particle Properties',
        snippet: 'Represents individual `Particles`.',
        heading: 'Particle Properties',
      ),
      SearchHit(
        keyword: 'color',
        snippet: 'Color of the `Particles`.',
        heading: 'Particle Properties',
      ),
      SearchHit(
        keyword: 'opacityMultiplier',
        snippet:
            'Use this value to affect the Particle\'s opacity with various parameters.',
        heading: 'Particle Properties',
      ),
      SearchHit(
        keyword: 'size',
        snippet: 'Size of the `Particles`.',
        heading: 'Particle Properties',
      ),
      SearchHit(
        keyword: 'feather',
        snippet: 'Feathering or Smoothing of the `Particles`. Between 0 and 1.',
        heading: 'Particle Properties',
      ),
      SearchHit(
        keyword: 'colorIntensityAddStrength',
        snippet:
            'Uses `Add Color Blend mode` to mix colors when `Particles` overlap. Between 0 and 1.',
        heading: 'Particle Properties',
      ),
      SearchHit(
        keyword: 'antiAlias',
        snippet:
            'Change this value in case some color combination produces jagged spherical edges. Greater than 0.',
        heading: 'Particle Properties',
      ),
      SearchHit(
        keyword: 'position',
        snippet: 'The position of the `Particle`.',
        heading: 'Particle Properties',
      ),

      // ───────────────── Audio Controls ─────────────────
      SearchHit(
        keyword: 'Audio Controls',
        snippet: 'Represents various Audio Settings and captured Audio Data.',
        heading: 'Audio Controls',
      ),
      SearchHit(
        keyword: 'multiplier',
        snippet:
            'Determines the strength by which the audio stream affects the inner `Fractal Field` displacements.',
        heading: 'Audio Controls',
      ),
      SearchHit(
        keyword: 'bassMultiplier',
        snippet:
            'Determines the `Sphere\'s` size change by the audio\'s lower frequencies.',
        heading: 'Audio Controls',
      ),
      SearchHit(
        keyword: 'mixing',
        snippet:
            'Between 0 and 1. Greater value means stronger reaction to beats or tonal changes in audio.',
        heading: 'Audio Controls',
      ),
      SearchHit(
        keyword: 'bass',
        snippet:
            'Audio value corresponding to the lower frequencies is stored here.',
        heading: 'Audio Controls',
      ),
      SearchHit(
        keyword: 'exponentiationFactor',
        snippet:
            'Used to raise the power of the intermediate Audio Data Points for quicker reactions.',
        heading: 'Audio Controls',
      ),
      SearchHit(
        keyword: 'samplePoints',
        snippet:
            'Normalised Points at which Audio Samples are taken to derive the final Audio output value.',
        heading: 'Audio Controls',
      ),
      SearchHit(
        keyword: 'intermediateAudios',
        snippet:
            'Intermediate Audio Values stored in ascending order of frequency intensity.',
        heading: 'Audio Controls',
      ),
      SearchHit(
        keyword: 'value',
        snippet:
            'The Final Audio Value derived from the Intermediate Audio Values.',
        heading: 'Audio Controls',
      ),

      // ─────────────── Fractal Field Controls ───────────────
      SearchHit(
        keyword: 'Fractal Field Controls',
        snippet: 'Represents the Underlying `Noise Field`.',
        heading: 'Fractal Field Controls',
      ),
      SearchHit(
        keyword: 'octaveMultiplier',
        snippet:
            'Multiplier value with which a `Noise Octave` gets added to the final output.',
        heading: 'Fractal Field Controls',
      ),
      SearchHit(
        keyword: 'complexity',
        snippet:
            'Defines the number of `Octaves` that add up in the final `Noise Output`.',
        heading: 'Fractal Field Controls',
      ),
      SearchHit(
        keyword: 'fScale',
        snippet: 'Scale of the overall noise-displaced `Particle Grid`.',
        heading: 'Fractal Field Controls',
      ),
      SearchHit(
        keyword: 'displacementType',
        snippet: '0 for `Normal Displacement`, 1 for `Radial Displacement`.',
        heading: 'Fractal Field Controls',
      ),
      SearchHit(
        keyword: 'flows',
        snippet:
            '`Flow` of the `Fractal Field` in spatial directions and time.',
        heading: 'Fractal Field Controls',
      ),

      // ───────────────── Sphere Controls ─────────────────
      SearchHit(
        keyword: 'Sphere Controls',
        snippet:
            'Represents the `Sphere` that can displace the `Particles` Radially.',
        heading: 'Sphere Controls',
      ),
      SearchHit(
        keyword: 'radius',
        snippet: 'Radius of the `Sphere`.',
        heading: 'Sphere Controls',
      ),
      SearchHit(
        keyword: 'feather',
        snippet:
            'Determines the size of the band around the `Sphere`. Between 0 and 1.',
        heading: 'Sphere Controls',
      ),
      SearchHit(
        keyword: 'strength',
        snippet:
            'Strength with which the particles are pushed or pulled from the center.',
        heading: 'Sphere Controls',
      ),
      SearchHit(
        keyword: 'center',
        snippet: 'Coordinates of the Center of the `Sphere`.',
        heading: 'Sphere Controls',
      ),
      SearchHit(
        keyword: 'scale',
        snippet: 'Scale of the `Sphere` in each direction.',
        heading: 'Sphere Controls',
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/ncs/configuration',
    pageTitle: 'NCS Configuration',
    searchHits: [
      SearchHit(
        keyword: 'NCS Configuration',
        snippet:
            'Configuration file that defines lifecycle entry points for the `NCS` Shader.',
        heading: 'Trivial Working Structure',
      ),

      SearchHit(
        keyword: 'Trivial Working Structure',
        snippet:
            'Minimal `.glsl` structure required for the `NCS` Shader to compile and run.',
        heading: 'Trivial Working Structure',
      ),

      SearchHit(
        keyword: '#include "ncs/primitives.glsl"',
        snippet:
            'Includes all required `structs`, noise utilities and primitive definitions for the `NCS` Shader.',
        heading: 'Trivial Working Structure',
      ),

      SearchHit(
        keyword: '#define colorTracking 0',
        snippet:
            'Required if tracking color information for the `Particles` is needed',
        heading: 'Trivial Working Structure',
      ),

      SearchHit(
        keyword: 'init()',
        snippet:
            'Called before the Shader starts processing audio or noise-driven displacements.',
        heading: 'Trivial Working Structure',
      ),

      SearchHit(
        keyword: 'setProps()',
        snippet:
            'Used to set visual properties of `Particles`, such as color, size and opacity.',
        heading: 'Trivial Working Structure',
      ),

      SearchHit(
        keyword: 'setPropsWithNoise()',
        snippet:
            'Used to set properties that depend on the evaluated `Fractal Field` noise.',
        heading: 'Trivial Working Structure',
      ),

      SearchHit(
        keyword: 'modifyNoiseCoordinates()',
        snippet:
            'Allows modification of the `Noise` sampling coordinates before the `Fractal Field` is evaluated.',
        heading: 'Trivial Working Structure',
      ),

      SearchHit(
        keyword: 'modifySphericalDisplacement()',
        snippet:
            'Allows final modification of parameters, after Spherical Displacement has been applied.',
        heading: 'Trivial Working Structure',
      ),

      SearchHit(
        keyword: 'Fractal Field',
        snippet:
            '`NCS` uses a `4-Dimensional Perlin Noise` field to displace `Particles`.',
        heading: 'Trivial Working Structure',
      ),

      SearchHit(
        keyword: 'Noise Coordinates',
        snippet:
            'Noise coordinates can be altered to affect flow, looping, and spatial distortion.',
        heading: 'Trivial Working Structure',
      ),

      SearchHit(
        keyword: 'colorTracking',
        snippet:
            'Set to 1 to use 4 separate Atomic Textures to store the Color Information per Particle. Very expensive.',
        heading: 'Trivial Working Structure',
      ),
    ],
  ),

  SearchEntry(
    route: '/shaders/ncs/life-cycle',
    pageTitle: "Life Cycle",
    searchHits: [
      SearchHit(
        keyword: "init()",
        heading: "Life Cycle",
        snippet:
            "Called before the Shader starts taking in the Audio Data. Set `audio.multiplier`, `audio.bassMultiplier`, `baseForm.type`, `baseForm.numParticles` and `baseForm.zSize` here.",
      ),
      SearchHit(
        keyword: "setProps()",
        heading: "Life Cycle",
        snippet:
            "Sets various visual properties of the Shader and the underlying Fractal Noise Field.",
      ),
      SearchHit(
        keyword: "modifyNoiseCoordinates()",
        heading: "Life Cycle",
        snippet:
            "Changes the coordinates that get passed to the Fractal Noise Function.",
      ),
      SearchHit(
        keyword: "setPropsWithNoise()",
        heading: "Life Cycle",
        snippet:
            "Adjusts various parameters after the Noise value has been calculated (stored in `fractalField.noise`).",
      ),
      SearchHit(
        keyword: 'modifySphericalDisplacement()',
        snippet:
            'Allows final modification of parameters, after Spherical Displacement has been applied.',
        heading: 'Life Cycle',
      ),
    ],
  ),

  SearchEntry(
    pageTitle: "NCS Examples",
    route: '/shaders/ncs/examples',
    searchHits: [
      SearchHit(
        keyword: "Standard NCS Visualiser",
        heading: "Standard NCS Visualiser",
        snippet:
            "Standard NCS Visualiser with Blue Color. Demonstrates a complete NCS setup including audio multipliers, particle styling, fractal field configuration, sphere displacement, and glow post-processing.",
      ),
      SearchHit(
        keyword: "Glow",
        heading: "Standard NCS Visualiser",
        snippet:
            "Post-processing glow configuration using Glow primitives. Includes coords, blendMode, intensity, size, directions, quality, color, brightnessOffset, and lightStrength.",
      ),
      SearchHit(
        keyword: "Fractal Field",
        heading: "Standard NCS Visualiser",
        snippet:
            "Fractal noise configuration via octaveMultiplier, octaveScale, complexity, fScale, gamma, minVal, maxVal, flows, and displacements.",
      ),
      SearchHit(
        keyword: "Sphere",
        heading: "Standard NCS Visualiser",
        snippet:
            "Radial particle displacement using a Sphere. Controlled by sphere.radius and sphere.feather, scaled relative to resolution.",
      ),
      SearchHit(
        keyword: "Audio",
        heading: "Standard NCS Visualiser",
        snippet:
            "Audio-driven visual response using audio.multiplier and audio.bassMultiplier to influence particle behavior and noise displacement.",
      ),
    ],
  ),

  SearchEntry(
    pageTitle: "Colors",
    route: '/shaders/advanced/colors',
    searchHits: [
      SearchHit(
        keyword: "Colors",
        heading: "Colors",
        snippet:
            "Utility functions for working with colors in GLSL using RGB, RGBA, HSV, and HSVA formats, along with hue interpolation helpers.",
      ),
      SearchHit(
        keyword: "rgb",
        heading: "rgb()",
        snippet:
            "Specify colors using RGB values in the 0–255 range and convert them to normalized vec3 values in GLSL.",
      ),
      SearchHit(
        keyword: "rgba",
        heading: "rgba()",
        snippet:
            "Specify colors using RGBA values in the 0–255 range, including alpha transparency, returning a vec4 color.",
      ),
      SearchHit(
        keyword: "hsv",
        heading: "hsv()",
        snippet:
            "Create colors using the HSV color model with hue in degrees and saturation/value in the 0–100 range.",
      ),
      SearchHit(
        keyword: "hsva",
        heading: "hsva()",
        snippet:
            "HSVA variant of hsv(), allowing opacity control alongside hue, saturation, and value.",
      ),
      SearchHit(
        keyword: "interpolateHue",
        heading: "interpolateHue(vec3)",
        snippet:
            "Interpolates hue starting from a vec3 color across a band range using a normalized interpolation factor.",
      ),
      SearchHit(
        keyword: "interpolateHue",
        heading: "interpolateHue(vec4)",
        snippet:
            "vec4 counterpart of interpolateHue(), supporting alpha while interpolating hue values.",
      ),
    ],
  ),

  SearchEntry(
    pageTitle: "Extras",
    route: '/shaders/advanced/extras',
    searchHits: [
      SearchHit(
        keyword: "Noise Functions",
        heading: "Noise Functions",
        snippet:
            "Collection of GLSL noise and math utilities sourced from the lygia library, including generative and mathematical noise helpers.",
      ),
      SearchHit(
        keyword: "Lygia",
        heading: "Noise Functions",
        snippet:
            "The NCS shader uses 4-D tileable Perlin noise from the lygia generative library.",
      ),
      SearchHit(
        keyword: "NCS Noise",
        heading: "Noise Functions",
        snippet:
            "NCS visualiser relies on 4-dimensional tileable Perlin noise for particle field displacement.",
      ),
      SearchHit(
        keyword: "coordinateRotation",
        heading: "Coordinate System Rotation",
        snippet:
            "Defines the rotation angle of the coordinate system used by Linear, Angular, and Chain shaders.",
      ),
      SearchHit(
        keyword: "Rotated Coordinates",
        heading: "Coordinate System Rotation",
        snippet:
            "Uses a rotated vertex shader to expose r_gl_FragCoord and r_resolution for consistent rendering at arbitrary angles.",
      ),
      SearchHit(
        keyword: "r_gl_FragCoord",
        heading: "Coordinate System Rotation",
        snippet:
            "Rotated counterpart of gl_FragCoord, derived in the fragment shader to avoid rasterisation artifacts.",
      ),
      SearchHit(
        keyword: "r_resolution",
        heading: "Coordinate System Rotation",
        snippet:
            "Resolution vector corresponding to the rotated coordinate system, paired with r_gl_FragCoord.",
      ),
      SearchHit(
        keyword: "Bars Left to Right",
        heading: "Coordinate System Rotation",
        snippet:
            "Set coordinateRotation to 90 degrees to make Linear bars and particles flow from left to right.",
      ),
    ],
  ),

  SearchEntry(
    pageTitle: "Special Directives",
    route: '/shaders/advanced/special-directives',
    searchHits: [
      SearchHit(
        keyword: "Special Directives",
        heading: "Special Directives",
        snippet:
            "WayVes supports special GLSL directives similar to GLava to manage shader configuration composition and static expansion.",
      ),
      SearchHit(
        keyword: "#include",
        heading: "Include",
        snippet:
            "Used to include other GLSL configuration files into the current shader file at compile time.",
      ),
      SearchHit(
        keyword: "Include Directive",
        heading: "Include",
        snippet:
            "Supports relative paths, absolute paths from the config root using ':', and special CONFIGFILE inclusion.",
      ),
      SearchHit(
        keyword: "CONFIGFILE",
        heading: "Include",
        snippet:
            "Use :\$CONFIGFILE to include the user-supplied main configuration GLSL file regardless of its filename.",
      ),
      SearchHit(
        keyword: "#expand",
        heading: "Expand",
        snippet:
            "Statically unrolls looping function calls so the compiler can optimize repeated operations.",
      ),
      SearchHit(
        keyword: "Expand Directive",
        heading: "Expand",
        snippet:
            "Replaces loop constructs by generating repeated function calls at compile time.",
      ),
      SearchHit(
        keyword: "Static Loop Unrolling",
        heading: "Expand",
        snippet:
            "Useful when accumulating values or modifying zOrders where manual loop expansion improves performance and predictability.",
      ),
    ],
  ),

  SearchEntry(
    pageTitle: "Creating your own Shaders",
    route: '/shaders/advanced/creating-your-own-shaders',
    searchHits: [
      SearchHit(
        keyword: "Creating your own Shaders",
        heading: "Creating your own Shaders",
        snippet:
            "Explains how WayVes discovers, compiles, and executes custom shaders using an ordered vertex/fragment hierarchy.",
      ),
      SearchHit(
        keyword: "Shader Folder Structure",
        heading: "Creating your own Shaders",
        snippet:
            "Shaders are organised into vertex and fragment folders, with files executed sequentially based on numbering.",
      ),
      SearchHit(
        keyword: "Multiple Shader Passes",
        heading: "Creating your own Shaders",
        snippet:
            "Later shader passes can consume the output of previous passes, enabling post-processing effects.",
      ),
      SearchHit(
        keyword: "Default Vertex Shader",
        heading: "Creating your own Shaders",
        snippet:
            "When fragment shaders outnumber vertex shaders, WayVes automatically uses the default vertex shader.",
      ),
      SearchHit(
        keyword: "Uniforms",
        heading: "Uniforms",
        snippet:
            "WayVes exposes several built-in uniforms such as time, resolution, audio samplers, and image bindings.",
      ),
      SearchHit(
        keyword: "GLSL Uniforms",
        heading: "Uniforms",
        snippet:
            "Includes audio textures, atomic image textures, and image buffers usable inside fragment shaders.",
      ),
      SearchHit(
        keyword: "Minimal Fragment Shader",
        heading: "Minimal Fragment Shader Example; all Uniforms",
        snippet:
            "Shows a complete fragment shader declaring all available uniforms and output variables.",
      ),
      SearchHit(
        keyword: "FragColor",
        heading: "Minimal Fragment Shader Example; all Uniforms",
        snippet:
            "Fragment shaders must write output color values to FragColor.",
      ),
      SearchHit(
        keyword: "gl_FragCoord",
        heading: "Minimal Fragment Shader Example; all Uniforms",
        snippet:
            "gl_FragCoord provides fragment position input for custom shader logic.",
      ),
    ],
  ),

  SearchEntry(
    route: '/main-configuration/yaml-specification',
    pageTitle: "YAML Specification",
    searchHits: [
      // --- High-level structure ---
      SearchHit(
        keyword: "audios",
        heading: "Configuration File",
        snippet:
            "Top-level list defining one or more Audio objects. Each Audio object owns its own capture settings, overrides, and shaders.",
      ),
      SearchHit(
        keyword: "shaders",
        heading: "Configuration File",
        snippet:
            "Each Audio object contains a list of Shader objects that consume the transformed audio data.",
      ),

      // --- PipeWire ---
      SearchHit(
        keyword: "pipewire-settings",
        heading: "PipeWire Settings",
        snippet:
            "Audio capture configuration consumed by PipeWire, including sample rate, channels, FFT usage, and buffer sizes.",
      ),
      SearchHit(
        keyword: "sample-rate",
        heading: "PipeWire Settings",
        snippet:
            "Sample rate used for capturing audio input. Higher values improve frequency resolution at the cost of performance.",
      ),
      SearchHit(
        keyword: "fragment-size",
        heading: "PipeWire Settings",
        snippet:
            "Number of audio samples sent to shaders after processing. Determines visual resolution of the audio data.",
      ),
      SearchHit(
        keyword: "apply-fft",
        heading: "PipeWire Settings",
        snippet:
            "Controls whether FFT is applied to captured audio. Disable for waveform-style visualisation.",
      ),

      // --- Channel mapping ---
      SearchHit(
        keyword: "channels-map",
        heading: "Channels Map",
        snippet:
            "Maps captured audio channels to shader inputs, allowing swapping or duplicating left and right channels.",
      ),
      SearchHit(
        keyword: "left channel",
        heading: "Channels Map",
        snippet:
            "Specifies which captured channel is routed to the left audio channel used by shaders.",
      ),
      SearchHit(
        keyword: "right channel",
        heading: "Channels Map",
        snippet:
            "Specifies which captured channel is routed to the right audio channel used by shaders.",
      ),

      // --- Smoothing ---
      SearchHit(
        keyword: "smooth-settings",
        heading: "Smooth Settings",
        snippet:
            "Controls how raw audio samples are smoothed before being passed to shaders.",
      ),
      SearchHit(
        keyword: "smooth-factor",
        heading: "Smooth Settings",
        snippet:
            "Higher values increase smoothing but are more expensive to compute.",
      ),
      SearchHit(
        keyword: "sample-mode",
        heading: "Smooth Settings",
        snippet:
            "Determines how audio samples are combined: averaged, peak-based, or hybrid.",
      ),

      // --- Gravity ---
      SearchHit(
        keyword: "gravity-settings",
        heading: "Gravity Settings",
        snippet:
            "Controls decay and latency of audio values, affecting how quickly visuals respond to drops in intensity.",
      ),
      SearchHit(
        keyword: "gravity-step",
        heading: "Gravity Settings",
        snippet: "Higher values cause faster drops in audio-driven visuals.",
      ),
      SearchHit(
        keyword: "average-frames",
        heading: "Gravity Settings",
        snippet:
            "Number of frames used for averaging audio input. Higher values increase smoothness but add latency.",
      ),

      // --- Audio overrides ---
      SearchHit(
        keyword: "audio-overrides",
        heading: "Audio Overrides",
        snippet:
            "Per-audio or per-shader overrides that modify frequency ranges, smoothing, and channel mapping.",
      ),
      SearchHit(
        keyword: "min-frequency",
        heading: "Audio Overrides",
        snippet: "Lower bound of the frequency range passed to shaders.",
      ),
      SearchHit(
        keyword: "max-frequency",
        heading: "Audio Overrides",
        snippet:
            "Upper bound of the frequency range. Must be less than or equal to sample-rate / 2.",
      ),

      // --- Shader object ---
      SearchHit(
        keyword: "shader object",
        heading: "Shader Object",
        snippet:
            "Defines window layout, rendering FPS, layer placement, overrides, and post-processing for a shader.",
      ),
      SearchHit(
        keyword: "layer",
        heading: "Shader Object",
        snippet:
            "Specifies Z-axis placement using the Wayland Layer Shell protocol (Background, Bottom, Top, Overlay).",
      ),
      SearchHit(
        keyword: "overrides",
        heading: "Shader Object",
        snippet: "Allows replacing GLSL #define values using key=value syntax.",
      ),

      // --- Paintables ---
      SearchHit(
        keyword: "paintables",
        heading: "Paintable Object",
        snippet:
            "Creates additional windows that mirror the output of an existing shader.",
      ),
      SearchHit(
        keyword: "exclusive-layer",
        heading: "Paintable Object",
        snippet:
            "Enables exclusive access to a Wayland layer for the paintable window.",
      ),

      // --- Post-processing ---
      SearchHit(
        keyword: "post-processing",
        heading: "Post-Processing Object",
        snippet:
            "Defines a sequence of post-processing shaders applied after the main shader pass.",
      ),
      SearchHit(
        keyword: "passes",
        heading: "Post-Processing Object",
        snippet:
            "Number of times a post-processing effect is applied consecutively.",
      ),

      // --- Audio object ---
      SearchHit(
        keyword: "audio object",
        heading: "Audio Object",
        snippet:
            "Top-level configuration grouping PipeWire settings, audio overrides, and associated shaders.",
      ),
      SearchHit(
        keyword: "audio name",
        heading: "Audio Object",
        snippet:
            "Name of the audio capture thread, used to associate shaders with an audio source.",
      ),

      SearchHit(
        keyword: "fft-scale",
        heading: "PipeWire Settings",
        snippet:
            "Scaling factor applied to higher frequencies after FFT. Helps distribute frequency energy more evenly.",
      ),

      SearchHit(
        keyword: "fft-cutOff",
        heading: "PipeWire Settings",
        snippet:
            "Bass cut-off used when scaling frequencies. Higher values skip more low-frequency data.",
      ),

      SearchHit(
        keyword: "sample-size",
        heading: "PipeWire Settings",
        snippet:
            "Number of raw audio samples captured per PipeWire read cycle.",
      ),

      SearchHit(
        keyword: "capture-mic",
        heading: "PipeWire Settings",
        snippet:
            "Enables microphone input capture instead of system audio output.",
      ),

      SearchHit(
        keyword: "target-object",
        heading: "PipeWire Settings",
        snippet:
            "Specifies the Target Object to which the PipeWire Stream will be connected. Consumed by PipeWire.",
      ),

      SearchHit(
        keyword: "audio-format",
        heading: "PipeWire Settings",
        snippet:
            "Specifies the audio format PipeWire should use when capturing samples.",
      ),

      // --- Shader layout & windowing ---
      SearchHit(
        keyword: "class-name",
        heading: "Shader Object",
        snippet:
            "CSS-style identifier used for styling and targeting shader windows.",
      ),

      SearchHit(
        keyword: "fps",
        heading: "Shader Object",
        snippet: "Target frame rate for the shader rendering loop.",
      ),

      SearchHit(
        keyword: "atomic-textures",
        heading: "Shader Object",
        snippet:
            "The number of Atomic Image Textures that should be enabled for this Shader.",
      ),

      SearchHit(
        keyword: "image-textures",
        heading: "Shader Object",
        snippet:
            "The number of Image Textures that should be enabled for this Shader.",
      ),

      SearchHit(
        keyword: "width",
        heading: "Shader Object",
        snippet: "Explicit width of the shader window in pixels.",
      ),

      SearchHit(
        keyword: "height",
        heading: "Shader Object",
        snippet: "Explicit height of the shader window in pixels.",
      ),

      SearchHit(
        keyword: "anchors",
        heading: "Shader Object",
        snippet:
            "Specifies which screen edges the shader window should anchor to.",
      ),

      SearchHit(
        keyword: "margins",
        heading: "Shader Object",
        snippet: "Pixel offsets applied relative to anchored edges.",
      ),

      SearchHit(
        keyword: "exclusive-layer",
        heading: "Shader Object",
        snippet:
            "Requests exclusive ownership of a Wayland layer, preventing overlap.",
      ),

      // --- Overrides ---
      SearchHit(
        keyword: "#define override",
        heading: "Overrides",
        snippet:
            "Overrides allow replacing GLSL #define values using variable=value syntax.",
      ),

      SearchHit(
        keyword: "visualiserMode override",
        heading: "Overrides",
        snippet:
            "Example of overriding a shader define to switch visualiser modes without editing GLSL.",
      ),

      SearchHit(
        keyword: "audio override precedence",
        heading: "Audio Overrides",
        snippet:
            "Shader-level audio overrides take precedence over parent Audio object overrides.",
      ),

      // --- Paintables ---
      SearchHit(
        keyword: "paintable object",
        heading: "Paintable Object",
        snippet:
            "Paintables are secondary windows that mirror a shader's output.",
      ),

      SearchHit(
        keyword: "paintable layout",
        heading: "Paintable Object",
        snippet:
            "Paintables support independent size, layer, anchors, and margins.",
      ),

      // --- Structural / conceptual ---
      SearchHit(
        keyword: "config.yaml",
        heading: "Configuration File",
        snippet:
            "Primary configuration file defining audio sources, shaders, layout, and processing.",
      ),

      SearchHit(
        keyword: "multiple audio objects",
        heading: "Configuration File",
        snippet:
            "WayVes supports multiple independent audio capture pipelines in a single configuration.",
      ),

      SearchHit(
        keyword: "shader inheritance",
        heading: "Configuration File",
        snippet:
            "Shaders inherit audio settings from their parent Audio object unless explicitly overridden.",
      ),
    ],
  ),

  SearchEntry(
    route: '/main-configuration/styling',
    pageTitle: "Styling",
    searchHits: [
      SearchHit(
        keyword: "styles.css",
        heading: "Styling",
        snippet:
            "The styles.css file controls visual styling of shader windows and their GL output.",
      ),
      SearchHit(
        keyword: "shader window styling",
        heading: "Styling",
        snippet:
            "CSS rules can modify background color, transforms, padding, and margins of shader windows.",
      ),
      SearchHit(
        keyword: "class name styling",
        heading: "Styling",
        snippet:
            "Shader window class names come from the main configuration YAML file and are used as CSS selectors.",
      ),
      SearchHit(
        keyword: ". selector",
        heading: "Styling",
        snippet:
            "The '.' selector targets the underlying GL drawing area inside a shader window.",
      ),
      SearchHit(
        keyword: "# selector",
        heading: "Styling",
        snippet:
            "The '#' selector targets the shader window itself rather than the GL area.",
      ),
      SearchHit(
        keyword: "invert shader output",
        heading: "Examples",
        snippet:
            "Use CSS transforms like scaleX(-1) to invert shader output horizontally.",
      ),
      SearchHit(
        keyword: "rotate shader output",
        heading: "Examples",
        snippet:
            "CSS transform functions can rotate shader output in 3D space.",
      ),
      SearchHit(
        keyword: "transform scaleX",
        heading: "Examples",
        snippet:
            "scaleX(-1) flips the rendered shader output along the X axis.",
      ),
      SearchHit(
        keyword: "rotateX rotateY rotateZ",
        heading: "Examples",
        snippet:
            "Multiple rotation transforms can be combined to achieve complex orientation effects.",
      ),
      SearchHit(
        keyword: "chain_paintable",
        heading: "Examples",
        snippet:
            "Example class selector used to target paintable shader outputs for styling.",
      ),
      SearchHit(
        keyword: "angular shader styling",
        heading: "Examples",
        snippet:
            "Angular shaders can be styled using their class name to apply rotations and transforms.",
      ),
      SearchHit(
        keyword: "GL area padding",
        heading: "Styling",
        snippet:
            "CSS padding and margin rules affect spacing inside the shader rendering area.",
      ),
      SearchHit(
        keyword: "window background color",
        heading: "Styling",
        snippet:
            "The shader window background can be styled independently from the GL output.",
      ),
    ],
  ),

  SearchEntry(
    pageTitle: "Piping Data",
    route: '/updating-properties/piping-data',
    searchHits: [
      SearchHit(
        keyword: "Piping Data",
        heading: "Piping Data",
        snippet:
            "WayVes supports supplying dynamic values to shaders using named pipes by declaring uniforms.",
      ),
      SearchHit(
        keyword: "Named Pipes",
        heading: "Piping Data",
        snippet:
            "Dynamic shader values can be supplied using named pipes located at /tmp/WayVes/<ShaderClass>.",
      ),
      SearchHit(
        keyword: "uniform",
        heading: "Piping Data",
        snippet:
            "Only variables declared as uniforms can receive dynamic values through piping.",
      ),
      SearchHit(
        keyword: "visualiserDirections",
        heading: "Piping Data",
        snippet:
            "Convert #define visualiserDirections into a uniform to allow dynamic updates via pipes.",
      ),
      SearchHit(
        keyword: "dynamicColor",
        heading: "Piping Data",
        snippet:
            "Uniform vec4 values such as dynamicColor can be piped in and consumed directly by shaders.",
      ),
      SearchHit(
        keyword: "vec4 color piping",
        heading: "Piping Data",
        snippet:
            "Colors can be piped using vec4 or rgba formats when declared as uniforms.",
      ),
      SearchHit(
        keyword: "pipe format",
        heading: "Piping Data",
        snippet:
            "Pipe input must follow variableName = value format, one entry per line.",
      ),
      SearchHit(
        keyword: "newline escape",
        heading: "Piping Data",
        snippet:
            "Use the \\n escape sequence when writing multiple values to the pipe.",
      ),
      SearchHit(
        keyword: "hsv uniform",
        heading: "Supported Data Types",
        snippet:
            "hsv and hsva cannot be used as uniforms and therefore cannot be piped.",
      ),
      SearchHit(
        keyword: "Supported Data Types",
        heading: "Supported Data Types",
        snippet:
            "WayVes supports piping bool, int, float, double, vec2, vec3, vec4, rgb and rgba values.",
      ),
      SearchHit(
        keyword: "bool",
        heading: "Supported Data Types",
        snippet: "Boolean data type supported for piping dynamic values.",
      ),
      SearchHit(
        keyword: "int",
        heading: "Supported Data Types",
        snippet: "Integer data type supported for piping dynamic values.",
      ),
      SearchHit(
        keyword: "float",
        heading: "Supported Data Types",
        snippet: "Float data type supported for piping dynamic values.",
      ),
      SearchHit(
        keyword: "double",
        heading: "Supported Data Types",
        snippet: "Double precision values can be piped into uniforms.",
      ),
      SearchHit(
        keyword: "vec2",
        heading: "Supported Data Types",
        snippet:
            "Vector of 2 values; all components must be explicitly supplied.",
      ),
      SearchHit(
        keyword: "vec3",
        heading: "Supported Data Types",
        snippet:
            "Vector of 3 values; partial initialization such as vec3(1) is not accepted.",
      ),
      SearchHit(
        keyword: "vec4",
        heading: "Supported Data Types",
        snippet:
            "Vector of 4 values commonly used for colors and positions in piping.",
      ),
      SearchHit(
        keyword: "rgb",
        heading: "Supported Data Types",
        snippet: "8-bit RGB representation supported for piping color values.",
      ),
      SearchHit(
        keyword: "rgba",
        heading: "Supported Data Types",
        snippet:
            "8-bit RGBA representation supported for piping color values with alpha.",
      ),

      SearchHit(
        keyword: "reloading configurations",
        heading: "Reloading Configurations",
        snippet:
            "WayVes supports reloading shader configurations at runtime using named instances.",
      ),
      SearchHit(
        keyword: "instance reload",
        heading: "Reloading Configurations",
        snippet:
            "Named instances allow grouping shaders so they can be targeted together for reloads.",
      ),
      SearchHit(
        keyword: "reload shaders",
        heading: "Reloading Configurations",
        snippet:
            "Reloading replaces all shaders for an instance using a new YAML specification file.",
      ),
      SearchHit(
        keyword: "-i flag",
        heading: "Reloading Configurations",
        snippet:
            "Supply an instance name using the -i flag when launching WayVes to identify a shader group.",
      ),
      SearchHit(
        keyword: "instance name",
        heading: "Reloading Configurations",
        snippet:
            "Instances are used to group shaders so they can be controlled and reloaded together.",
      ),
      SearchHit(
        keyword: "audio object names",
        heading: "Reloading Configurations",
        snippet: "All Audio object names within an instance must be unique.",
      ),
      SearchHit(
        keyword: "multiple invocations",
        heading: "Reloading Configurations",
        snippet:
            "You can run multiple invocations of the same instance as long as their Audio object names do not conflict.",
      ),
      SearchHit(
        keyword: "instance pipe",
        heading: "Reloading Configurations",
        snippet:
            "Each instance exposes a named pipe used to trigger configuration reloads.",
      ),

      SearchHit(
        keyword: "reload yaml",
        heading: "Reloading Configurations",
        snippet:
            "Piping a new YAML filename into the instance pipe replaces the shader specification.",
      ),

      SearchHit(
        keyword: "instance",
        heading: "Reloading Configurations",
        snippet:
            "Example: reload the desktop instance using a new shader specification file.",
      ),
      SearchHit(
        keyword: "echo reload",
        heading: "Reloading Configurations",
        snippet:
            "echo \"reload = newShaderSpec\" >> /tmp/WayVes/instance_desktop",
      ),
      SearchHit(
        keyword: "reload warning",
        heading: "Reloading Configurations",
        snippet:
            "Instance reloading should be used sparingly to avoid inconsistent runtime states.",
      ),
      SearchHit(
        keyword: "spamming reloads",
        heading: "Reloading Configurations",
        snippet:
            "Spamming too many reloads for a single instance may lead to inconsistencies.",
      ),
    ],
  ),

  SearchEntry(
    pageTitle: "Tips",
    route: '/recommendations/tips',
    searchHits: [
      SearchHit(
        keyword: "Tips",
        heading: "Tips",
        snippet:
            "General recommendations to reduce clutter and ensure good performance while running WayVes.",
      ),

      // ───────────────── Audio Configuration ─────────────────
      SearchHit(
        keyword: "Audio Configuration",
        heading: "Audio Configuration",
        snippet:
            "WayVes captures audio from the default PipeWire sink and can be synced using virtual sinks.",
      ),
      SearchHit(
        keyword: "Virtual Sink",
        heading: "Audio Configuration",
        snippet:
            "PipeWire virtual sinks can be used to route audio and adjust latency for better visual sync.",
      ),
      SearchHit(
        keyword: "PipeWire latency",
        heading: "Audio Configuration",
        snippet:
            "Adjusting sink latency helps sync audio output with visualisers.",
      ),
      SearchHit(
        keyword: "YouTube stable volume",
        heading: "Audio Configuration",
        snippet:
            "Disable YouTube's stable volume setting to ensure proper audio reactivity.",
      ),

      // ───────────────── Configuration Overrides ─────────────────
      SearchHit(
        keyword: "Configuration Overrides",
        heading: "Configuration Overrides",
        snippet:
            "YAML overrides can replace #define constants in shader configuration files.",
      ),
      SearchHit(
        keyword: "overrides",
        heading: "Configuration Overrides",
        snippet:
            "Overrides allow changing shader behavior without duplicating shader files.",
      ),
      SearchHit(
        keyword: "visualiserMode override",
        heading: "Configuration Overrides",
        snippet:
            "Overrides can dynamically switch between particles and bars using visualiserMode.",
      ),
      SearchHit(
        keyword: "YAML shader overrides",
        heading: "Configuration Overrides",
        snippet:
            "Overrides are supplied per shader entry inside the YAML configuration file.",
      ),

      // ───────────────── Shader Specification Structure ─────────────────
      SearchHit(
        keyword: "Shader Specification Structure",
        heading: "Shader Specification Structure",
        snippet:
            "The first shader in an Audio Object drives audio updates for subsequent shaders.",
      ),
      SearchHit(
        keyword: "Audio-driving shader",
        heading: "Shader Specification Structure",
        snippet:
            "Only shaders without audio overrides receive audio data from the driving shader.",
      ),
      SearchHit(
        keyword: "Overlay layer shader",
        heading: "Shader Specification Structure",
        snippet:
            "Overlay shaders should be placed first to ensure audio updates propagate correctly.",
      ),
      SearchHit(
        keyword: "shader FPS audio variance",
        heading: "Shader Specification Structure",
        snippet:
            "The FPS of the audio-driving shader affects audio update variance in chained shaders.",
      ),

      // ───────────────── Branchless Conditions ─────────────────
      SearchHit(
        keyword: "Making Conditions Branchless",
        heading: "Making Conditions Branchless",
        snippet:
            "Reducing branching in GLSL improves GPU performance and avoids execution stalls.",
      ),
      SearchHit(
        keyword: "GLSL branching",
        heading: "Making Conditions Branchless",
        snippet:
            "Conditional branches may stall GPU execution due to parallel processing.",
      ),
      SearchHit(
        keyword: "branchless GLSL",
        heading: "Making Conditions Branchless",
        snippet:
            "Branchless logic can be implemented using step() and mix() functions.",
      ),
      SearchHit(
        keyword: "step()",
        heading: "Making Conditions Branchless",
        snippet: "step(a, b) returns 1 when a <= b and 0 otherwise.",
      ),
      SearchHit(
        keyword: "mix()",
        heading: "Making Conditions Branchless",
        snippet: "mix(x, y, a) interpolates between x and y based on factor a.",
      ),
      SearchHit(
        keyword: "branchless color switch",
        heading: "Making Conditions Branchless",
        snippet:
            "step() and mix() can replace if-else blocks for switching colors efficiently.",
      ),
    ],
  ),
];
