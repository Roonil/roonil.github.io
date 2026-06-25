import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/constants/variable_descriptions.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/advanced/colors_screen.dart';
import 'package:wayves_wiki/screens/shaders/ncs/ncs_examples_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';
import 'package:wayves_wiki/widgets/types_list.dart';

class PostProcessingScreen extends StatefulWidget {
  const PostProcessingScreen({super.key});
  static const routeName = '/shaders/advanced/post-processing';

  @override
  State<PostProcessingScreen> createState() => _PostProcessingScreenState();
}

class _PostProcessingScreenState extends State<PostProcessingScreen> {
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
              key: heading!["Post-Processing"],
              "Post-Processing",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SpacedLines(
              text:
                  """Each `Shader` can have one or more `Post-Processing` Shaders that can affect the final output of that `Shader`.
Define the chain of the `Post-Processing Effects` for a `Shader` as such in the `Main Configuration File`:""",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const CodeSnippetCard(
              textString: """      - name: linear
        .
        .
        .
        window-width: 300
        window-height: 100
        post-processing:
          - name: glow
            passes: 2""",
              language: "yaml",
            ),

            SpacedLines(
              text:
                  """This will insert 2 Passes of the `Glow` Effect at the end of the Render Stage of the `Shader`.
• Each `Post-Processing Effect` is defined as a `Struct` in its corresponding `Primitive` file
• Since each 'pass' of the `Post-Processing` Shader can have different values for the required attributes, `WayVes` uses the `#expand` directive to specify variable names suffixed by the `number of the currently-ongoing pass - 1`.
• Each instance of the `Struct Primitive` for each 'pass' of the `Post-Processing` Shader is controlled by the `set<PostProcessingShaderName><PassNumber-1>(inout <PostProcessingShaderName> variableName)` function 
• For example, if `Glow` has 4 passes defined in the Main YAML Spec, the necessary functions that need to be defined are `void setGlow0(inout Glow glow){}`, `void setGlow1(inout Glow glow){}`, and so on.
• Even if the same effect is encountered in a Chain as such, the effective pass number is still one greater than the last pass encountered. So after 2 passes of a `Post-Processing` Shader, whenever that `Shader` is involved again in the same chain, then the variable suffix will correspond to the 3rd pass (`glow2.blurAmount`)
By default, `Glow` and `Rotate` Post-Processing Effects have been provided.""",
              style: Theme.of(context).textTheme.titleMedium,
            ),

            const Divider(),

            RoundedExpansionTile(
              key: heading["Glow"],
              titleString: "Glow",
              subtitleString:
                  "Adds a Glowing effect to the final output of the Shader.",
              children: [
                TypesList(
                  parameters: glowVariables,
                  dataDescriptions: glowDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
              ],
            ),

            const Divider(),

            RoundedExpansionTile(
              key: heading["Rotate"],
              titleString: "Rotate",
              subtitleString: "Rotates the final output of the Shader.",
              children: [
                TypesList(
                  parameters: rotateVariables,
                  dataDescriptions: rotateVariablesDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
              ],
            ),

            const Divider(),
            RoundedExpansionTile(
              key: heading["Examples"],
              titleString: "Examples",
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: Text(
                    "Glow with 2 Passes",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                RichTextFromTicks(
                  text:
                      "The following code needs to be placed in the common `Shader Configuration file` for which 2 Glow passes have been enabled:",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const CodeSnippetCard(
                  textString:
                      """#include ":utils/post-processing/glow/structs.glsl"

// 1st Pass
void setGlow0(inout Glow glow) {
    glow.blendMode = 0;
    glow.mixAlpha = 0.;
    glow.offsetAngle = 0.;
    glow.size = 9.0;
    glow.intensity = 4.5 ;
    glow.directions = 4.0;
    glow.quality = 3.0;
    glow.color = vec4(0.2392, 0.0745, 0.6196, 1.0);
    glow.brightnessOffset = 0.2;
    glow.lightStrength = 0.7;
}

// 2nd Pass
void setGlow1(inout Glow glow) {
    glow.blendMode = 0;
    glow.mixAlpha = 0.;
    glow.offsetAngle = 0.;
    glow.size = 3.0;
    glow.intensity = 4.5;
    glow.directions = 16.0;
    glow.quality = 3.0;
    glow.color = vec4(0.2392, 0.0745, 0.6196, 1.0);
    glow.brightnessOffset = .2;
    glow.lightStrength = 0.7;
}""",
                ),

                const Divider(),
                Padding(
                  padding: const EdgeInsets.only(bottom: 8.0),
                  child: Text(
                    "Rotate at lower Audio Frequencies",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                RichTextFromTicks(
                  text:
                      "Setting  `rotate.angle` to Audio data sampled at lower values will add rotation whenever lower Frequencies are active",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const CodeSnippetCard(
                  textString:
                      """#include ":utils/post-processing/rotate/structs.glsl"

void setRotate0(inout Rotate rotate) {
    rotate.angle = (-10 * abs(sin(3.5 * (clamp(texture(audioR,.1).x - .01, 0.1, .8)))));
    rotate.center = resolution / 2.;
}
""",
                ),
              ],
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "NCS - Examples",
                route: NcsExamplesScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Colors",
                route: ColorsScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
