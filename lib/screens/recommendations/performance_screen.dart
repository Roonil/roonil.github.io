import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/recommendations/tips_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';

class PerformanceScreen extends StatefulWidget {
  const PerformanceScreen({super.key});
  static const routeName = '/recommendations/performance';

  @override
  State<PerformanceScreen> createState() => _PerformanceScreenState();
}

class _PerformanceScreenState extends State<PerformanceScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, GlobalKey<State<StatefulWidget>>>? heading =
        headings[Beamer.of(context).configuration.uri.path];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key: heading!["Performance"],
              "Performance",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SpacedLines(
                text:
                    """• `WayVes` utilises the `Wayland Layer Shell Protocol` to display Windows as `Layers`. Since some GTK-specific features such as styling via `.css` files and support of Paintables was desired, `WayVes` uses GTK4 to draw and display the Windows. Hence, the `GTK4 Wayland Layer Shell Protocol` dependency is necessary.
• `WayVes` runs an instance of a GTK4 Application for each `Audio Object` in a new forked Process. These instances then drive the underlying `Shaders`. Rendering is handled asynchronously, but ultimately the render commands get queued to the Main GTK4 Application Thread, as UI updates are handled via the Main Thread in GTK.
• As the GTK Main Loop is responsible for 'updating' the UI, too many `Shaders` under a single `Audio Object` (and therefore under a single GTK4 Application instance) can lead to performance issues.
• For this reason, it is recommended to 'split' the `Shaders` among different `Audio Objects`. Too many `Shaders` under a single `Audio Object` WILL lead to stutters and performance drops.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const InfoCard(
              textString:
                  """It is also recommended to disable Blur from the Compositor settings in case any Shader lies below a Blurred element, as that might massively impact Performance.""",
            ),
            const Divider(),
            Text(
              key: heading["New GTK GL Renderer"],
              "New GTK GL Renderer",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SpacedLines(
                text:
                    """• GTK4 recently introduced the New GL Renderer, along with Vulkan. As of the latest stable GTK4 release version (4.20.2), the New Renderers seem to offer sub-par performance as compared to the 'Old' GL Renderer (Such as in GTK4.12).
• If you encounter severe performance issues, even after 'splitting' the `Shaders` among different `Audio Objects` as discussed above, you can try to use an Older GTK4 version and see if that fixes the issues.
• You'll be building a minimal version of the `GTK4` library and then linking it to the `WayVes` Executable, so the rest of the sytem won't be affected.
• As `WayVes` needs only the underlying Windowing and Styling Logic, you need not include other GTK functionalities during the build, such as `demos`, `examples` and `tests`.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider(),
            Text(
              key: heading["Using the Old GTK Renderer"],
              "Using the Old GTK Renderer",
              style: Theme.of(context).textTheme.displaySmall,
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SpacedLines(
                text:
                    """1. Get the Source Code for an older GTK4 Version (`GTK 4.12.5 / 4.12.0` produced no performance drops; it is suggested to use either one of these.)
2. Toggle the dependencies that we won't be needing besides bare-bones GTK.
We'll be using an installation directory named `prefixDir` in which the actual installation of GTK4 will take place. Also assuming that build directory is `buildDir` in which the relevant build files will be generated.
For example, using `meson`, and supplying parameters to disable building examples, demos and such:""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const CodeSnippetCard(
              textString:
                  """meson setup -Dintrospection=disabled -Dprefix=\$PWD/prefixDir -Dbuildtype=release -Ddocumentation=false -Dmedia-gstreamer=disabled  -Dcloudproviders=disabled -Dcolord=disabled -Dman-pages=false -Dbuild-demos=false  -Dtracker=disabled -Dsysprof=disabled -Dbuild-examples=false -Dbuild-tests=false -Dbuild-testsuite=false -Dbuild-demos=false -Dmacos-backend=false -Dwin32-backend=false -Dbuildtype=release buildDir""",
              language: 'bash',
            ),

            Padding(
              padding: const EdgeInsets.only(top: 8.0, bottom: 8),
              child: RichTextFromTicks(
                text:
                    """To see all the available options you can toggle, then after running `meson setup`, run:""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const CodeSnippetCard(
              textString: "meson configure buildDir",
              language: 'bash',
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichTextFromTicks(
                text: "3. Install GTK4 to `prefixDir`:",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const CodeSnippetCard(
              textString: """ninja -C buildDir
ninja -C buildDir install""",
              language: 'bash',
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SpacedLines(
                text:
                    """4. Before running `WayVes`, ensure that the older version overrides the new one by running:""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const CodeSnippetCard(
              textString:
                  """export LD_LIBRARY_PATH="/path/to/prefixDir:\$LD_LIBRARY_PATH"
export GSETTINGS_SCHEMA_DIR="/path/to/prefixDir/share/glib-2.0/schemas"                                                                                               
export GTK_PATH="/path/to/prefixDir\"""",
              language: 'bash',
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichTextFromTicks(
                text: """Check if the linking was correct by running:""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            //TODO: Might have to correct the below script after installing system-wide
            const CodeSnippetCard(
              textString: "ldd \$(which WayVes) | grep -i 'gtk'",
              language: 'bash',
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SpacedLines(
                text:
                    """You should see 2 entries, one corresponding to the `gtk4-layer-shell` library, and the other (`libgtk-4.so.1`) should point to your prefixed directory.   
• If you don't see the library from your `prefix` directory, then you'll have to explicitly load the `libgtk-4.so.1` library using `LD_PRELOAD`. The library should be present in `prefixDir/lib`, or in `prefixDir/x86_64-linux-gnu` directory.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const CodeSnippetCard(
              textString:
                  'export LD_PRELOAD=/path/to/prefixDir/lib/x86_64-linux-gnu/libgtk-4.so.1 ',
              language: 'bash',
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichTextFromTicks(
                text:
                    """`WayVes` should now use the older GTK version while running. Verify by running the `ldd` command again""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            BottomNavigation(
              prevNavItem: NavItem(title: "Tips", route: TipsScreen.routeName),
              nextNavItem: null,
            ),
          ],
        ),
      ),
    );
  }
}
