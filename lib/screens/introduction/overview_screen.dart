import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/getting_started/usage_screen.dart';
import 'package:wayves_wiki/screens/introduction/data_types_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';

import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';

class OverviewScreen extends StatefulWidget {
  const OverviewScreen({super.key});
  static const routeName = '/introduction/overview';

  @override
  State<OverviewScreen> createState() => _OverviewScreenState();
}

class _OverviewScreenState extends State<OverviewScreen> {
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
                key: heading!["Shaders"],
                "Shaders",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 12),
              child: RichTextFromTicks(
                text:
                    """This is meant to be a brief overview of `OpenGL` Shaders, and how `WayVes` utilises them.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4, left: 12),
              child: SpacedLines(
                text:
                    """• `OpenGL` works using `Shaders`, that are programs that run on the GPU.
• A `Shader` can be of different types, such as a `Vertex Shader`, `Fragment Shader`, `Geometry Shader` and such. 
• `WayVes` primarily utilises `Vertex` and `Fragment Shaders` to render the Visuals.
• Both `Vertex` and `Fragment Shaders` utilise the `main()` function as the entry function to carry out their respective tasks.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(bottom: 12.0, left: 12),
              child: RichTextFromTicks(
                text:
                    """`WayVes` uses a full-view Quad to draw the `Vertex Shader`, and the Visualisers themselves are achieved by `Fragment Shader` Programs.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Vertex Shader"],
              titleString: "Vertex Shader",
              subtitleString:
                  "Used to process the Vertices and their placements on the screen. You can transform the Vertices as well.",
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 4.0,
                    horizontal: 12,
                  ),
                  child: RichTextFromTicks(
                    text:
                        """`Vertex` Shaders are pretty much used in this context within `WayVes` without any alterations, except for the `coordinateRotation` property, that can be used to determine the relative angle of the Orthogonal Coordinate System used to draw the `Shaders`, from the center of the Window View.""",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),

            const Divider(),
            RoundedExpansionTile(
              key: heading["Fragment Shader"],
              titleString: "Fragment Shader",
              subtitleString:
                  """Used to determine the color of each "pixel" (or "fragment"), and thus requires a `Vertex Shader` Program to run first.""",
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 12,
                  ),
                  child: RichTextFromTicks(
                    text:
                        """• Gets `gl_FragCoord` as an input from the `Vertex Shader`, which is a `vec4` type, containing the `(x, y, z, 1 / w)` values. """,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: InfoCard(
                    textString:
                        """No `depth buffer` is used, and hence we'll be restricting ourselves to the usage of (x, y) Coordinates to determine the "location" of the current "position" within the Fragment Shader from now on.""",
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InfoCard(
                    formattedTextWidget: Column(
                      children: [
                        RichTextFromTicks(
                          text:
                              "`gl_FragCoord` is not normalised, and hence lies in the range [vec2(0, 0), vec2(resolution.xy)]. To normalise the result in the range [vec2(0), vec2(1)], we can use a vec2 variable to store the normalised coordinates as such:",
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                        const CodeSnippetCard(
                          textString:
                              """vec2 uv = gl_FragCoord.xy / resolution.xy;
                              
// To change the range to [vec2(-1), vec2(1)], we can then use something like:
uv = 2 * uv - 1;

// It's all Vector Math!""",
                        ),
                      ],
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 12,
                  ),
                  child: RichTextFromTicks(
                    text:
                        """• Outputs `FragColor`, a `vec4` that contains the color of the current fragment in its `4 Channels` - `Red`, `Green`, `Blue` and `Alpha`.""",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: InfoCard(
                    formattedTextWidget: Text.rich(
                      TextSpan(
                        children: [
                          WidgetSpan(
                            child: RichTextFromTicks(
                              text:
                                  """`WayVes` doesn't use `glBlendFunc`, a property that can handle the `Alpha` Channel and hence display the expected `RGBA` Color, since that might cause mismatched outputs when utilising more than one `Fragment Stage` Passes. Instead, We use a concept called `Premultiplying` the colors, in which the `R`, `G` and `B` Channels get multiplied by the `Alpha` Channel, that produces the expected behaviour.""",
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary,
                                  ),
                            ),
                          ),
                          const WidgetSpan(
                            child: CodeSnippetCard(
                              textString:
                                  "FinalColor = vec4(Color.xyz * Color.w, Color.w);",
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: InfoCard(
                    isWarning: true,
                    textString:
                        """Don't directly assign values to `FragColor` within the provided Shaders!""",
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 12.0,
                    horizontal: 12,
                  ),
                  child: RichTextFromTicks(
                    text:
                        """•  Multiple `Fragment Shaders` can be used in a "chain", where the output of the previous can be read by the current `Shader Stage` in the chain. We can use this to apply `Post-Processing Effects`, such as the `Glow Effect` Shader. """,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 6.0, left: 40, bottom: 6),
                  child: SpacedLines(
                    text:
                        """• This is called `Texture Sampling`, and can be used to even "read" the pixels from Images.
• Except for the last `Shader Stage` in the chain, each `Fragment Stage` outputs its color to a `FrameBuffer` instead of the Screen. This FrameBuffer can then be read from in the next Stage using the `texture()` function, that takes in 2 arguments:
    • The `Sampler` variable to read the data from.
    • Coordinates at which to read the data from, in normalised format `[vec2(0), vec2(1)]`""",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(top: 6.0, left: 40, bottom: 6),
                  child: RichTextFromTicks(
                    text:
                        """• For Example, To read the color data from the previous `Fragment Output Stage` at `(0.5, 0.6)` normalised coordinates, we can invoke the `texture()` method like so:""",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 6.0, horizontal: 40),
                  child: CodeSnippetCard(
                    textString: "vec4 color = texture(prev, vec2(0.5, 0.6));",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(
                    top: 2.0,
                    bottom: 4,
                    left: 12,
                    right: 12,
                  ),
                  child: InfoCard(
                    textString:
                        "`WayVes` does not support reading from user-input images yet.",
                  ),
                ),
              ],
            ),

            const Divider(),

            RoundedExpansionTile(
              key: heading["High-Level Overview of a Shader Pipeline"],
              titleString: "High-Level Overview of a Shader Pipeline",
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: SpacedLines(
                    text: """1. `Vertex Shader Stage` completes
2. `Fragment Shader Stage` receives `(x, y)` Coordinates
    • In `main()`:
          i. utilise the current coordinates to determine various properties
          ii. set `FragColor` equal to the Final Output Color `((r, g, b, a) OR (x, y, z, w))`
      (Multiple `Fragment Shader Stages` can be chained)
      .
      .
      .
    • set `FragColor` equal to the `Post-Processed Color`""",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
              ],
            ),
            BottomNavigation(
              nextNavItem: NavItem(
                title: "Data Types",
                route: DataTypesScreen.routeName,
              ),
              prevNavItem: NavItem(
                title: "Getting Started - Usage",
                route: UsageScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
