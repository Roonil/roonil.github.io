import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/advanced/extras_screen.dart';
import 'package:wayves_wiki/screens/shaders/advanced/post_processing_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';

class ColorsScreen extends StatefulWidget {
  const ColorsScreen({super.key});
  static const routeName = '/shaders/advanced/colors';

  @override
  State<ColorsScreen> createState() => _ColorsScreenState();
}

class _ColorsScreenState extends State<ColorsScreen> {
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
              key: heading!["Colors"],
              "Colors",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: RichTextFromTicks(
                text:
                    "By Default, `GLSL` uses `vec4` data type to represent `RGBA` Colors, and `vec3` to represent `RGB`. All the individual components in the `vectors` are normalized in the range `[0, 1]`. To use a more familiar format for specifying colors, you can include the `colors.glsl` file from the `utils` directory, and use the specified functions to get Colors in a more suitable format.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["rgb()"],
              titleString: "rgb(float r, float g, float b)",
              textStyle: Theme.of(context).textTheme.titleLarge,
              subtitleString:
                  "Can be used to specify Colors in the `RGB (0 - 255)` range",
              children: [
                const CodeSnippetCard(
                  textString: """#include ":utils/colors.glsl"

vec3 color = rgb(0, 255, 255); // Cyan

// Each channel value gets divided by 255. You may use float values for finer control""",
                ),
              ],
            ),
            RoundedExpansionTile(
              key: heading["rgba()"],
              titleString: "rgba(float r, float g, float b, float a)",
              textStyle: Theme.of(context).textTheme.titleLarge,
              subtitleString:
                  "Can be used to specify Colors in the `RGBA (0 - 255)` range",
              children: [
                const CodeSnippetCard(
                  textString: """#include ":utils/colors.glsl"

vec4 color = rgba(0, 255, 255, 255); // Cyan

// Each channel value gets divided by 255. You may use float values for finer control
color = rgba(0, 255, 255, 127.5); // Cyan at 50% Transparency""",
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["hsv()"],
              titleString: "hsv(float h, float s, float v)",
              textStyle: Theme.of(context).textTheme.titleLarge,
              subtitleString:
                  "Can be used to specify Colors in the `HSV (0 - 360, 0 - 100, 0 - 100)` range",
              children: [
                const CodeSnippetCard(
                  textString: """#include ":utils/colors.glsl"

vec3 color = hsv(128, 100, 100); // Green

// You may use float values for finer control""",
                ),
              ],
            ),
            RoundedExpansionTile(
              key: heading["hsva()"],
              titleString: "hsva(float h, float s, float v, float a)",
              textStyle: Theme.of(context).textTheme.titleLarge,
              subtitleString:
                  "Can be used to specify Colors in the `HSVA (0 - 360, 0 - 100, 0 - 100, 0 - 100)` range",
              children: [
                const CodeSnippetCard(
                  textString: """#include ":utils/colors.glsl"

vec4 color = hsva(128, 100, 100, 50); // Green at 50% Opacity

// You may use float values for finer control""",
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["interpolateHue(vec3)"],
              titleString:
                  "interpolateHue(vec3 startColor, float hueInterpolation, float bandIndex, float lastBandIndex)",
              textStyle: Theme.of(context).textTheme.titleLarge,
              subtitleString:
                  "Can be used to specify Interpolated Hue value, starting from `startColor`, and interpolating the value from `bandIndex` to `lastBandIndex`, using `hueInterpolation` (in range `[0, 1]`) as the modifier",
              children: [
                const CodeSnippetCard(
                  textString: """#include ":utils/colors.glsl"

vec3 color = interpolateHue(vec3(0.2, 1.0, 0.0), 1, gl_FragCoord.x, resolution.x);""",
                ),
              ],
            ),

            RoundedExpansionTile(
              key: heading["interpolateHue(vec4)"],
              titleString:
                  "interpolateHue(vec4 startColor, float hueInterpolation, float bandIndex, float lastBandIndex)",
              textStyle: Theme.of(context).textTheme.titleLarge,
              subtitleString:
                  "`vec4` counter-part of the `interpolateHue()` function",
              children: [
                const CodeSnippetCard(
                  textString: """#include ":utils/colors.glsl"

vec4 color = interpolateHue(vec4(0.2, 1.0, 0.0, 0.5), 1, gl_FragCoord.x, resolution.x);""",
                ),
              ],
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Post-Processing",
                route: PostProcessingScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Extras",
                route: ExtrasScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
