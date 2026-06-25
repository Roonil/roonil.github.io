import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/advanced/creating_your_own_shaders_screen.dart';
import 'package:wayves_wiki/screens/shaders/advanced/z_orders_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';

class SpecialDirectivesScreen extends StatefulWidget {
  const SpecialDirectivesScreen({super.key});
  static const routeName = '/shaders/advanced/special-directives';

  @override
  State<SpecialDirectivesScreen> createState() =>
      _SpecialDirectivesScreenState();
}

class _SpecialDirectivesScreenState extends State<SpecialDirectivesScreen> {
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
              key: heading!["Special Directives"],
              "Special Directives",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SpacedLines(
                text:
                    """`WayVes` parses the relevant `Shader Files` to process the graphical outputs.
Since the files are split to better segragate the configurations, `WayVes` uses 2 Special Directives similar to `GLava`:
  1. `#include`, and 
  2. `#expand`
that can be used to include other `GLSL Configuration Files`, or to statically place loop function calls respectively.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            RoundedExpansionTile(
              key: heading["Include"],
              titleString: "Include",
              subtitleString: "Used to include other configuration files.",
              children: [
                SpacedLines(
                  text:
                      """It is recommended to place any includes at the top of the file you are placing the directive in.
Imports can be relative, or from the root of the Configuration directory (marked by a prefixed `:`)
If a file named `externalFile.glsl` has the following contents:""",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const CodeSnippetCard(
                  textString: """#define color vec4(1)
#define radius 7""",
                ),
                SpacedLines(
                  text:
                      """Then, after including the file in another Shader file, the contents of 'externalFile.glsl' will be placed at the '#include' directive call within that Shader file.
If `externalFile.glsl` is in the same directory as the file that is including it, you can include it like so:""",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const CodeSnippetCard(
                  textString:
                      """#include "externalFile.glsl"     // You can also use '../' to import from the previous directory
// Will compile to the following:
// #define color vec4(1)
// #define radius 7 """,
                ),
                SpacedLines(
                  text:
                      """If `externalFile.glsl` is to be imported from another directory that is present in `\$XDG_CONFIG_HOME` directory :""",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const CodeSnippetCard(
                  textString: """#include ":path/to/externalFile.glsl"     
// Will compile to the following:
// #define color vec4(1)
// #define radius 7 """,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: RichTextFromTicks(
                    text:
                        """As WayVes supports supplying any other common configuration .glsl file via the main config.yaml file, to include the config file regardless of the name, use the `:\$CONFIGFile` syntax. """,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),

                const CodeSnippetCard(
                  textString: """#include ":\$CONFIGFILE"
// Will include the contents of the supplied .glsl file regardless of the name specified """,
                ),
              ],
            ),
            RoundedExpansionTile(
              key: heading["Expand"],
              titleString: "Expand",
              subtitleString:
                  "Used to statically-unroll looping function calls",
              children: [
                Text(
                  """Although looping functionality is quite performant in OpenGL, it is often better to manually call each iteration of the loop, so the compiler can make some improvements.

This can be especially useful in scenarios when you need to add some values over (such as in the provided zOrders files for Linear and Angular Shaders)

The syntax for the directive is as follows:""",
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const CodeSnippetCard(
                  textString: "#expand FunctionName numberOfIterations",
                ),
                const InfoCard(
                  textString:
                      "numberOfIterations should be an integer value, or should be a #define variable having an integer value, either in an included file or declared previously within the same file",
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    "Example:",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const CodeSnippetCard(
                  textString: """
uniform sampler2D tex;
uniform vec2 resolution;

vec4 averageValue = vec4(0);

void main()
{

#define getValueAtHorizontalOffset(i) averageValue += texture(tex, vec2(i, gl_FragCoord.y) / resolution);
#expand getValueAtHorizontalOffset 5 // Compiles to the following:
// getValueAtHorizontalOffset(0);
// getValueAtHorizontalOffset(1);
// getValueAtHorizontalOffset(2);
// getValueAtHorizontalOffset(3);
// getValueAtHorizontalOffset(4);

// Similar to the loop: for (int i=0; i < 5; i++) getValueAtHorizontalOffset(i);

}""",
                ),
              ],
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Z Orders",
                route: ZOrdersScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Creating your own Shaders",
                route: CreatingYourOwnShadersScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
