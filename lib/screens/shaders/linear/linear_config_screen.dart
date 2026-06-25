import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/constants/variable_descriptions.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/linear/linear_overview_screen.dart';
import 'package:wayves_wiki/screens/shaders/linear/linear_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';

import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/types_list.dart';

class LinearConfigScreen extends StatefulWidget {
  const LinearConfigScreen({super.key});
  static const routeName = '/shaders/linear/configuration';

  @override
  State<LinearConfigScreen> createState() => _LinearConfigScreenState();
}

class _LinearConfigScreenState extends State<LinearConfigScreen> {
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
              key: heading!["Trivial Working Structure"],
              titleString: "Trivial Working Structure",
              children: [
                const CodeSnippetCard(
                  textString: """
#include "linear/structs.glsl"

#define coordinateRotation 0
#define fragmentWidth 10

#define leftPadding 0
#define rightPadding 0

#define visualiserDirections 0
#define visualiserMode 0

void init()
{
}

void audioFetch(inout float fetchedAudio, int n, int lastN)
{
    // fetchedAudio = the value of the fetched audio sample
    // n = the current audio sample index being processed
    // lastN = the last audio sample index being processed
}

void setOffsets(float direction, inout vec2 particleOffset, inout vec2 barOffset, inout vec2 barSizeOffset, vec2 barAudio, vec2 particleAudio, float xCoordinate, float n, float lastN)
{  
    // direction = 0 for top Particles, 1 for bottom Particles
    // particleOffset = the offset that will be applied to the particle's position
    // barOffset = the offset that will be applied to the bar's position
    // barSizeOffset = the size offset that will be applied to the bar's size (Upward / Downward height)
    // barAudio = the audio value for the current bar being processed
    // particleAudio = the audio value for the current particle being processed
    // xCoordinate = the x coordinate of the current fragment being processed
    // n = the current bar / particle index
    // lastN = the last bar / particle index
}

void setProps()
{
}

void setParticleDownProps()
{
}

void modifySDFs()
{
}""",
                ),
              ],
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),

            TypesList(
              parameters: baseVariables,
              dataDescriptions: baseVariablesDescriptions,
              dataTypes: null,
              examples: null,
            ),
            const InfoCard(
              textString:
                  "Avoid directly using gl_FragCoord for querying coordinates. Instead use `bar.fragment.coords`, or `particle.fragment.coords`",
              isWarning: true,
            ),

            BottomNavigation(
              prevNavItem: NavItem(
                title: "Overview",
                route: LinearOverviewScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Life Cycle",
                route: LinearScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
