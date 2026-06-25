import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/chain/chain_life_cycle_screen.dart';
import 'package:wayves_wiki/screens/shaders/linear/linear_overview_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';

class ChainExamplesScreen extends StatefulWidget {
  const ChainExamplesScreen({super.key});
  static const routeName = '/shaders/chain/examples';

  @override
  State<ChainExamplesScreen> createState() => _ChainExamplesScreenState();
}

class _ChainExamplesScreenState extends State<ChainExamplesScreen> {
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
            RoundedExpansionTile(
              titleString: "Dynamically-colored Chain",
              subtitleString:
                  "Chain with Hue interpolation that changes with Audio",
              key: heading!["Dynamically-colored Chain"],
              children: [
                const CodeSnippetCard(
                  textString: """#include ":chain/structs.glsl"

#include ":utils/colors.glsl"

#define coordinateRotation 0.

void init()
{
    chain.density = 256;
    audio.multiplier = 1.2;
}

void audioFetch(inout float fetchedAudio, float n, float lastN)
{
}

void setProps()
{
    chain.color = interpolateHue(vec4(0, 0.4, 1, 0.03), .05, 15 * (resolution.x - chain.index) * audio.value.x, resolution.x);
}""",
                ),
              ],
            ),

            BottomNavigation(
              prevNavItem: NavItem(
                title: "Life Cycle",
                route: ChainLifeCycleScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Linear - Overview",
                route: LinearOverviewScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
