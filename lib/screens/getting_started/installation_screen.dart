import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/getting_started/usage_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';

class InstallationScreen extends StatefulWidget {
  const InstallationScreen({super.key});

  static const routeName = '/getting-started/installation';

  @override
  State<InstallationScreen> createState() => _InstallationScreenState();
}

class _InstallationScreenState extends State<InstallationScreen> {
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
              key: heading!["Requirements"],
              "Requirements",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SpacedLines(
                text:
                    """`WayVes` runs on `Wayland`, and needs `GTK4`, `GTK4 Layer Shell`, `DBus`, `LibCYAML` and `PipeWire` packages to be installed on your system.
You can install the required packages by specifying the appropriate installation commands for your distro.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 12.0),
              child: InfoCard(
                textString:
                    "`WayVes` will fall back to displaying Shaders in a normal Window in case the Layer Shell Protocol is not supported.",
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                "For Arch:",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            const CodeSnippetCard(
              language: "bash",
              textString:
                  "pacman -S gtk4 gtk4-layer-shell dbus libcyaml-git pipewire",
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                "For Debian:",
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),

            const CodeSnippetCard(
              language: "bash",
              textString:
                  "apt install libgtk-4-dev libdbus-1-dev libpipewire-0.3-dev",
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichTextFromTicks(
                text:
                    "Especially for Debian-based distros, `GTK4 Layer Shell` and `LibCYAML` Packages might either not be available for your System, or provide an older version (the packages are `libgtk4-layer-shell-dev` and `libcyaml-dev`). It is recommended to build and install these from their respective Sources",
                endSpan: [
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: TextButton(
                        onPressed: () async {
                          await launchUrl(
                            Uri.parse(
                              'https://github.com/wmww/gtk4-layer-shell',
                            ),
                          );
                        },
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text("here"),
                      ),
                    ),
                  ),
                  const TextSpan(text: 'and'),
                  WidgetSpan(
                    alignment: PlaceholderAlignment.middle,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 4.0),
                      child: TextButton(
                        onPressed: () async {
                          await launchUrl(
                            Uri.parse('https://github.com/tlsa/libcyaml'),
                          );
                        },
                        style: TextButton.styleFrom(
                          visualDensity: VisualDensity.compact,
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text("here"),
                      ),
                    ),
                  ),
                ],

                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider(),
            Text(
              key: heading["Installation"],
              "Installation",
              style: Theme.of(context).textTheme.displaySmall,
            ),

            const CodeSnippetCard(
              language: "bash",
              textString: """git clone https://github.com/Roonil/WayVes
cd WayVes
mkdir -p build/objects
make
make install""",
            ),
            SpacedLines(
              text:
                  "After installation, copy the contents of the `shaders` directory to `\$XDG_CONFIG_HOME/WayVes/` as such: (Assuming `\$XDG_CONFIG_HOME` is `~/.config`). ",

              style: Theme.of(context).textTheme.titleMedium,
            ),
            const CodeSnippetCard(
              textString: """mkdir -p ~/.config/WayVes/
cp -r shaders/* ~/.config/WayVes/""",
            ),
            BottomNavigation(
              nextNavItem: NavItem(
                title: "Usage",
                route: UsageScreen.routeName,
              ),
              prevNavItem: null,
            ),
          ],
        ),
      ),
    );
  }
}
