import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/chain/chain_life_cycle_screen.dart';
import 'package:wayves_wiki/screens/shaders/chain/chain_overview_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/types_list.dart';

class ChainConfigurationScreen extends StatefulWidget {
  const ChainConfigurationScreen({super.key});
  static const routeName = '/shaders/chain/configuration';

  @override
  State<ChainConfigurationScreen> createState() =>
      _ChainConfigurationScreenState();
}

class _ChainConfigurationScreenState extends State<ChainConfigurationScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, GlobalKey<State<StatefulWidget>>> heading =
        headings[Beamer.of(context).configuration.uri.path]!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RoundedExpansionTile(
              key: heading["Trivial Working Structure"],
              titleString: "Trivial Working Structure",
              children: [
                const CodeSnippetCard(
                  textString: """#include "chain/structs.glsl"

#define coordinateRotation 0.

void init()
{
}

void audioFetch(inout float fetchedAudio, float n, float lastN)
{
    // fetchedAudio = the value of the fetched audio sample
    // n = the current audio sample index being processed
    // lastN = the last audio sample index being processed
}

void setProps()
{
}""",
                ),
              ],
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),

            const TypesList(
              parameters: ["coordinateRotation"],
              dataDescriptions: [
                "The relative angle of the Orthogonal Coordinate System used to draw the Shaders, from the center of the Window View. This is different from a simple Rotation about the Z-Axis, as this is a Coordinate-Basis Transform",
              ],
              dataTypes: null,
              examples: null,
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Overview",
                route: ChainOverviewScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Life Cycle",
                route: ChainLifeCycleScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
