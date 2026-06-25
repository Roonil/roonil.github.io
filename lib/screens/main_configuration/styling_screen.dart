import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/advanced/piping_screen.dart';
import 'package:wayves_wiki/screens/main_configuration/main_config_overview_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';

class StylingScreen extends StatefulWidget {
  const StylingScreen({super.key});
  static const routeName = '/main-configuration/styling';

  @override
  State<StylingScreen> createState() => _StylingScreenState();
}

class _StylingScreenState extends State<StylingScreen> {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                key: heading!["Styling"],
                "Styling",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 12),
              child: SpacedLines(
                text:
                    """• The styles.css file can be used to specify various aspects for the Shader Windows.
• You can use it to :-
      Specify an overall background color to the Window
      Rotate the final output
      Specify the padding / margins of the GL Area within the Window
The class name of a Shader Window is the class name you specify within the main configuration yaml file.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const InfoCard(
              textString:
                  "The `.` selector is used for styling the underlying GL Area within the Window that displays the Shader. The `#` selector is used for styling the Window itself",
            ),
            const Divider(),
            RoundedExpansionTile(
              titleString: "Examples",
              key: heading["Examples"],
              children: [
                SpacedLines(
                  text:
                      "Inverts the final Shader Output on the X Axis for all Shaders with the Class name as `chain_paintable`",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const CodeSnippetCard(
                  language: "css",
                  textString: """.chain_paintable {
    transform: scaleX(-1);
}""",
                ),

                SpacedLines(
                  text:
                      "Rotates the final Shader Output on the Screen for all Shaders with the Class name as `angular`",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const CodeSnippetCard(
                  language: "css",
                  textString: """.angular {
    transform: rotateX(-5deg) rotateY(140deg) rotateZ(170deg);
}""",
                ),
              ],
            ),
            BottomNavigation(
              nextNavItem: NavItem(
                title: "Updating Properties - Piping Data",
                route: PipingScreen.routeName,
              ),
              prevNavItem: NavItem(
                title: "YAML Specification",
                route: YAMLSpecificationScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
