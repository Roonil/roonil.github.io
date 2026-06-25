import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/advanced/colors_screen.dart';
import 'package:wayves_wiki/screens/shaders/advanced/z_orders_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';

class ExtrasScreen extends StatefulWidget {
  const ExtrasScreen({super.key});
  static const routeName = '/shaders/advanced/extras';

  @override
  State<ExtrasScreen> createState() => _ExtrasScreenState();
}

class _ExtrasScreenState extends State<ExtrasScreen> {
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
              key: heading!["Noise Functions"],
              "Noise Functions",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text.rich(
                TextSpan(
                  children: [
                    WidgetSpan(
                      child: RichTextFromTicks(
                        text:
                            """You can find many noise function implementations within the `utils/lygia/generative` folder, and some other math functions within the `utils/lygia/math` folder originally created by `lygia`, check """,
                        style: Theme.of(context).textTheme.titleMedium,
                        endSpan: [
                          WidgetSpan(
                            child: TextButton(
                              onPressed: () async {
                                launchUrl(Uri.parse('https://lygia.xyz/'));
                              },
                              child: const Text("here"),
                            ),
                            alignment: PlaceholderAlignment.middle,
                          ),
                        ],
                      ),
                      // alignment: PlaceholderAlignment.top,
                    ),
                  ],
                ),
              ),
            ),
            RichTextFromTicks(
              text:
                  """The `NCS` Shader utilises the `4-D Tileable Perlin Noise` implementation from this library.""",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const Divider(),
            Text(
              key: heading["Coordinate System Rotation"],
              "Coordinate System Rotation",
              style: Theme.of(context).textTheme.displaySmall,
            ),

            SpacedLines(
              text:
                  """`Angular`, `Linear`, and `Chain` Shaders have a `coordinateRotation` property, that represents the `angle` of the Coordinate System.
This is useful when you want the `Bars` to go from left to right instead of from down to up, for instance.
This effect is achieved within the `Vertex Shader`. The Vertex Shader File `rotatedCoordinatesVertex.vert` present in the `utils` directory is used as the `Vertex Shader`.
This `Vertex Shader` exposes `r_ngl_FragCoord` (normalised in range `[vec4(0), vec4(1)]`) and `r_resolution` attributes that are essentially the rotated counter-parts of `gl_FragCoord` and `resolution` parameters.
From `r_ngl_FragCoord`, `r_gl_FragCoord` is derived within the `Fragment Shader`. This has to be done in the `Fragment Shader` as otherwise the `Shader Rasterisation` can lead to weird artifacts if this step is done within the `Vertex Shader` itself.
In the `GLSL Configuration Files`, you can use `r_gl_FragCoord` and `r_resolution` instead of `gl_FragCoord` and `resolution` to ensure that the outputs stay consistent with any arbitrary `coordinateRotation` angles.
For example, to make the `Bars` and `Particles` in `Linear` go from left to right, use:""",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const CodeSnippetCard(
              textString: """#define coordinateRotation 90""",
            ),
            const InfoCard(
              textString:
                  """`fragment.coords` in `Linear` and `Angular` automatically resolve to `r_gl_FragCoord`""",
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Colors",
                route: ColorsScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Z Orders",
                route: ZOrdersScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
