import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/getting_started/installation_screen.dart';
import 'package:wayves_wiki/screens/introduction/overview_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';

class UsageScreen extends StatefulWidget {
  const UsageScreen({super.key});
  static const routeName = '/getting-started/usage';

  @override
  State<UsageScreen> createState() => _UsageScreenState();
}

class _UsageScreenState extends State<UsageScreen> {
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
              key: heading!["Usage"],
              "Usage",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const InfoCard(
              textString:
                  "Newer GTK4 versions might require you to set `GSK_RENDERER=opengl` and `GDK_DEBUG=gl-prefer-gl` Environment Variables first.",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichTextFromTicks(
                text:
                    """`WayVes` reads from a `YAML` file that specifies the layout and positioning of each `Shader` / `Visualiser` on the Screen, along with the Audio Properties that alter the behaviour of the Visualisers' Reactions to the captured Audio Data.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const InfoCard(
              textString:
                  "By default, `config.yaml` file present in `\$XDG_CONFIG_HOME/WayVes` is read. You can specify the name of a different `.yaml` file (also present in `\$XDG_CONFIG_HOME/WayVes`) by specifiying the `-f` CLI Argument, followed by the file name (without the extension)",
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SpacedLines(
                text:
                    """• Each Visualiser is an `OpenGL` Program that (primarily) uses a `Fragment` Shader to display Visuals, based on the attributes that are supplied to the `Shader`
• The attributes can be specified using a `.glsl` file. The `.glsl` file is parsed and then the assigned properties are fed into the `Shader Pipeline`""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const InfoCard(
              textString:
                  "By default, for a `Shader` with the name `ShaderName`, the file `ShaderName.glsl` is read. This behaviour can be overriden by specifying the desired name in the `YAML Configuration file`",
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichTextFromTicks(
                text:
                    """To further transform the final output on the Screen, or to modify various Window Properties for the `Shader`, you can use the `styles.css` file. This can be used to rotate and 'embed' a Visualiser onto the Wallpaper, for instance""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider(),
            Text(
              key: heading["Starter Configuration"],
              "Starter Configuration",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichTextFromTicks(
                text:
                    """Copy the files located at `starter-configs/` to the `\$XDG_CONFIG_HOME/WayVes/` directory. Execute `WayVes` by typing in `WayVes` in the terminal. You should see some bars on the bottom-left side of the screen, and the angular counter-part of the bars on the bottom-left of the screen. Play any audio on your Desktop, and you should see the Visualisers react to the Audio in Real-Time!""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Installation",
                route: InstallationScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Introduction - Overview",
                route: OverviewScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
