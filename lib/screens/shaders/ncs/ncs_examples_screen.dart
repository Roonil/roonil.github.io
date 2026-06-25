import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/advanced/post_processing_screen.dart';
import 'package:wayves_wiki/screens/shaders/ncs/ncs_life_cycle_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';

class NcsExamplesScreen extends StatefulWidget {
  const NcsExamplesScreen({super.key});
  static const routeName = '/shaders/ncs/examples';

  @override
  State<NcsExamplesScreen> createState() => _NcsExamplesScreenState();
}

class _NcsExamplesScreenState extends State<NcsExamplesScreen> {
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
              titleString: "Standard NCS Visualiser",
              subtitleString: "NCS Visualiser with Blue Color",
              key: heading!["Standard NCS Visualiser"],
              children: [
                const CodeSnippetCard(
                  textString: """#include "ncs/structs.glsl"
#include ":utils/post-processing/glow/structs.glsl"

#define colorTracking 0

void init()
{
    audio.multiplier = 6.4;
    audio.bassMultiplier = .5263 * resolution.x;
}

void setProps()
{

    particle.color = vec4(0.0353, 0.5647, 0.9725, 0.336);
    particle.size = 3;

    particle.feather = 1;

    particle.colorIntensityAddStrength = 0.35;
    particle.antiAlias = 6.0;

    fractalField.octaveMultiplier = 0.25;
    fractalField.octaveScale = 1.0;
    fractalField.complexity = 3;
    fractalField.fScale = 9.473;
    fractalField.gamma = 1.0;
    fractalField.minVal = -5.0;
    fractalField.maxVal = 5.0;

    fractalField.flows = vec4(0, 3.8, 0, 1.3);
    fractalField.displacements = vec3(.3884 * resolution.x, .3884 * resolution.x - 20, .3884 * resolution.x - 5);

    sphere.radius = .7236 * resolution.x;
    sphere.feather = 0.45;
}

void modifyNoiseCoordinates(inout vec4 coords)
{
}

void setPropsWithNoise()
{
}

void modifySphericalDisplacement()
{
}

void setGlow0(inout Glow glow)
{
    glow.blendMode = 1;
    glow.mixAlpha = 1;
    glow.intensity = 1.0;
    glow.size = 18;
    glow.directions = 16.0;
    glow.quality = 6.0;
    glow.color = vec4(0.0275, 0.0392, 0.6471, 1.0);
    glow.brightnessOffset = .0;
    glow.lightStrength = .5;
}""",
                ),
              ],
            ),

            BottomNavigation(
              prevNavItem: NavItem(
                title: "Life Cycle",
                route: NcsLifeCycleScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Advanced - Post-Processing",
                route: PostProcessingScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
