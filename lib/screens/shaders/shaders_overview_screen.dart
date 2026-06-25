import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/introduction/glsl_functions_screen.dart';
import 'package:wayves_wiki/screens/shaders/chain/chain_overview_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';

class ShadersOverviewScreen extends StatefulWidget {
  const ShadersOverviewScreen({super.key});
  static const routeName = '/shaders/overview';

  @override
  State<ShadersOverviewScreen> createState() => _ShadersOverviewScreenState();
}

class _ShadersOverviewScreenState extends State<ShadersOverviewScreen> {
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
              key: heading!["Overview"],
              "Overview",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SpacedLines(
                text:
                    """• This section contains the Visualisers that are Shader Programs that you can enable via the Main Configuration File.
• The documentation that is built for the primary `Structures` within these Shaders is taken from the `structs.glsl` file that is stored in the respective Shader folder.
• It is encouraged to go through these files yourself, as they provide all the information and customisability you might need.
• Note that whenever an Example value contains `-`, then that value is not meant to be modified, but rather used elsewhere in the program.
• The entity that holds the captured Audio data is meant to be consumed and not modified, for example.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Introduction - GLSL Functions",
                route: GlslFunctionsScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Chain - Overview",
                route: ChainOverviewScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
