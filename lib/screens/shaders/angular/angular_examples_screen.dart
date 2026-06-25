import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/angular/angular_screen.dart';
import 'package:wayves_wiki/screens/shaders/ncs/ncs_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';

class AngularExamplesScreen extends StatefulWidget {
  const AngularExamplesScreen({super.key});
  static const routeName = '/shaders/angular/examples';

  @override
  State<AngularExamplesScreen> createState() => _AngularExamplesScreenState();
}

class _AngularExamplesScreenState extends State<AngularExamplesScreen> {
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
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(20),
              child: ExpansionTile(
                initiallyExpanded: true,
                expandedCrossAxisAlignment: CrossAxisAlignment.start,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
                title: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    key: heading["Classic Bars"],
                    "Classic Bars",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),

                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 4.0, left: 4),
                    child: Text(
                      "The following .glsl snippet creates standard, vertical Bars with Blue Inner Color and White Border Color",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ),
                  const CodeSnippetCard(
                    textString: """
#include "angular/structs.glsl"

#define coordinateRotation 0
#define fragmentAngle 10                                    // Fragment Angle is 10 degrees

#define visualiserMode 1                  // Show only Bars
#define visualiserDirections 0        // Show only the Top Direction

void init()
{
    // Set audio multiplier for Bars
    bar.audio.multiplier = 50;
}

void audioFetch(inout float fetchedAudio, int n, int lastN)
{
}

void setOffsets(float direction, inout vec2 particleOffset, inout vec2 barOffset, inout vec2 barSizeOffset, vec2 barAudio, vec2 particleAudio, float xCoordinate, float n, float lastN)
{  
}

void setProps()
{
    // Each Bar will have a starting height in vertically-up direction with a value of 12 Pixels, width of 5 Pixels and no vertically-downwards height
    bar.size = vec3(12, 5, 0);

    // The Outer Border of each Bar (Top, Left & Right, and Downwards) will respectively be of sizes 5, 1, and 2 Pixels 
    bar.borderSize = vec3(5, 1, 2);

    // The Inner Color of each Bar will be Blue with Opacity 1
    bar.color = vec4(0, 0, 1, 1); 

    // The Border or Outer Color of each Bar will be White with Opacity 1
    bar.borderColor = vec4(1);
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
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: Divider(),
            ),
            RoundedExpansionTile(
              key: heading["Particles"],
              titleString: "Particles",
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 4.0, left: 4),
                  child: Text(
                    "The following .glsl snippet creates Particles with Red Inner Color and Yellow Border Color",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const CodeSnippetCard(
                  textString: """#include "angular/structs.glsl"

#define coordinateRotation 0
#define fragmentAngle 15                                    // Fragment Angle is 15

#define visualiserMode 0                  // Show only Particles
#define visualiserDirections 2         // Show Particles in both Directions


void init()
{
    // Set audio multiplier for Particles
    particle.audio.multiplier = 50;
}

void audioFetch(inout float fetchedAudio, int n, int lastN)
{
}

void setOffsets(float direction, inout vec2 particleOffset, inout vec2 barOffset, inout vec2 barSizeOffset, vec2 barAudio, vec2 particleAudio, float xCoordinate, float n, float lastN)
{  
}

void setProps()
{
    // Each Particle will have a radius of 4 Pixels, and an outer Border of 2 Pixels
    particle.radius = 4;
    particle.borderSize = 2;

    // Each Particle will have Red Inner Color with Full Opacity
    particle.color = vec4(1, 0, 0, 1);
    
    // Each Particle will have Yellow Border Color with Full Opacity
    particle.borderColor = vec4(1, 1, 0, 1);
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
            BottomNavigation(
              nextNavItem: NavItem(
                title: "NCS - Overview",
                route: NcsScreen.routeName,
              ),
              prevNavItem: NavItem(
                title: "Life Cycle",
                route: AngularScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
