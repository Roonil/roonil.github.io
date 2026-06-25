import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/constants/linear_descriptions.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/chain/chain_examples_screen.dart';
import 'package:wayves_wiki/screens/shaders/linear/linear_config_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/images_viewer.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';
import 'package:wayves_wiki/widgets/types_list.dart';

class LinearOverviewScreen extends StatefulWidget {
  const LinearOverviewScreen({super.key});

  static const routeName = '/shaders/linear/overview';

  @override
  State<LinearOverviewScreen> createState() => _LinearOverviewScreenState();
}

class _LinearOverviewScreenState extends State<LinearOverviewScreen> {
  final saturationValue = 1.5;

  @override
  void didChangeDependencies() {
    Beamer.of(context).addListener(
      () => mounted
          ? Navigator.of(context, rootNavigator: true).canPop()
                ? Navigator.of(context, rootNavigator: true).pop()
                : null
          : null,
    );
    super.didChangeDependencies();
  }

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
              key: heading!["Linear"],
              "Linear",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: RichTextFromTicks(
                text:
                    "The `Linear` Visualiser represents the Set of `Bars`, `Particles` and `Particle Connectors` that can be drawn on a straight line.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ImagesViewer(
                    height: 140,

                    images: [
                      Image.asset(
                        'assets/images/bars_merged_frame0.webp',

                        fit: BoxFit.scaleDown,

                        filterQuality: FilterQuality.high,
                        // alignment: AlignmentGeometry.directional(12, -12),
                        width: 200,
                        height: 100,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              return wasSynchronouslyLoaded || frame != null
                                  ? child
                                  : const Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.loose,
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ],
                                    );
                            },
                      ),
                      Image.asset(
                        'assets/images/particles_frame0.webp',

                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fitHeight,

                        width: 570,
                        height: 130,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              return wasSynchronouslyLoaded || frame != null
                                  ? child
                                  : const Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.loose,
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ],
                                    );
                            },
                      ),
                      Image.asset(
                        'assets/images/sawtooth_frame0.webp',

                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fitWidth,
                        width: 620,

                        height: 64,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              return wasSynchronouslyLoaded || frame != null
                                  ? child
                                  : const Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.loose,
                                      children: [
                                        SizedBox(
                                          width: 30,
                                          height: 30,
                                          child: CircularProgressIndicator(),
                                        ),
                                      ],
                                    );
                            },
                      ),
                    ],
                    animatedImages: [
                      Image.asset(
                        'assets/images/bars_merged.webp',

                        fit: BoxFit.fitHeight,

                        filterQuality: FilterQuality.high,
                        // alignment: AlignmentGeometry.directional(12, -12),
                        width: 200,
                        height: 260,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              return wasSynchronouslyLoaded || frame != null
                                  ? child
                                  : const Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.loose,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(120.0),
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ],
                                    );
                            },
                      ),
                      Image.asset(
                        'assets/images/particles.webp',

                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fitWidth,

                        width: 570,
                        height: 130,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              return wasSynchronouslyLoaded || frame != null
                                  ? child
                                  : const Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.loose,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(120.0),
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ],
                                    );
                            },
                      ),
                      Image.asset(
                        'assets/images/sawtooth.webp',

                        filterQuality: FilterQuality.high,
                        fit: BoxFit.fitWidth,
                        width: 620,

                        height: 64,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              return wasSynchronouslyLoaded || frame != null
                                  ? child
                                  : const Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.loose,
                                      children: [
                                        Padding(
                                          padding: EdgeInsets.all(120.0),
                                          child: SizedBox(
                                            width: 30,
                                            height: 30,
                                            child: CircularProgressIndicator(),
                                          ),
                                        ),
                                      ],
                                    );
                            },
                      ),
                    ],
                  ),
                ),
                // const Spacer(flex: 1),
              ],
            ),

            const Divider(),
            Text(
              key: heading["Primitives"],
              "Primitives",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SpacedLines(
                text:
                    """A `Bar` or a `Particle` is referred to as a `Primitive`.
A `Primitive` resides in a `Fragment` (this is different from the Fragment in a `Vertex / Fragment Shader`), and has properties that define its size and appearance""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const Divider(),
            Text(
              key: heading["Fragments"],
              "Fragments",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SpacedLines(
                text:
                    """A `Fragment` is the division of the total Window View into different 'Columns'. This serves as the housing space for the `Primitives`.
Each `Fragment` has a width that must be a constant throughout the current Frame of the Shader Program, and is represented by `fragmentWidth`.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const InfoCard(
              textString:
                  "Although both types of `Primitives` have a child structure that represents the `Fragment`, they are essentially the same. They're supplied so for ease of reference.",
            ),
            const InfoCard(
              textString:
                  """Window View : divided into `Fragments` that have a fixed width, `Fragment` : Houses `Bars` and `Particles`""",
              // style: Theme.of(context).textTheme.titleMedium,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SpacedLines(
                text:
                    """If a `Primitive`'s width exceeds that of the `Fragment`, then the `Primitive` appears as if it's been clipped or cut-off. This is intended, as no two `Primitives` from different `Fragments` can overlap.
This is because `Linear` Shader's logic divides the screen in different sections (`Fragments`) and treats them independently.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider(),
            Text(
              key: heading["Working"],
              "Working",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SpacedLines(
                text:
                    """In the `Common GLSL Configuration File`, various variables and functions have been laid out that are essential for the `Shader` to Compile.
The variables primarily define:
• The `width` of the `Fragment`,
• The vertical directions of the `Primitives` (Up, Down, or both), and
• Type(s) of `Primitive` to display (`Bar`, `Particle`, or both)
The functions serve as concrete stages in the processing of the `Shader`, and hence allow the specification of different values that affect the `Primitives'` Visuals.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const Divider(),

            RoundedExpansionTile(
              key: heading["Audio Settings"],
              titleString: "Audio Settings",
              subtitleString: linearAudioSettingsStructDescription,
              children: [
                TypesList(
                  parameters: linearAudioSettingsParameters,
                  dataDescriptions: linearAudioSettingsParametersDescriptions,
                  dataTypes: linearAudioSettingsDataTypes,
                  examples: linearAudioSettingsExamples,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Audio"],
              titleString: "Audio",
              subtitleString: linearAudioStructDescription,
              children: [
                TypesList(
                  parameters: linearAudioParameters,
                  dataDescriptions: linearAudioParametersDescriptions,
                  dataTypes: linearAudioDataTypes,
                  examples: linearAudioExamples,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Fragment"],
              titleString: "Fragment",
              subtitleString: linearFragmentStructDescription,
              children: [
                TypesList(
                  parameters: linearFragmentParameters,
                  dataDescriptions: linearFragmentParametersDescriptions,
                  dataTypes: linearFragmentDataTypes,
                  examples: linearFragmentExamples,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Cap"],
              titleString: "Cap",
              subtitleString: linearCapStructDescription,
              children: [
                TypesList(
                  parameters: linearCapParameters,
                  dataDescriptions: linearCapParametersDescriptions,
                  dataTypes: linearCapDataTypes,
                  examples: linearCapExamples,
                ),
              ],
            ),
            const Divider(),

            RoundedExpansionTile(
              key: heading["Connector Half"],
              titleString: "Connector Half",
              subtitleString: linearConnectorHalfStructDescription,
              children: [
                TypesList(
                  parameters: linearConnectorHalfParameters,
                  dataDescriptions: linearConnectorHalfParametersDescriptions,
                  dataTypes: linearConnectorHalfDataTypes,
                  examples: linearConnectorHalfExamples,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Connector"],
              titleString: "Connector",
              subtitleString: linearConnectorStructDescription,
              children: [
                TypesList(
                  parameters: linearConnectorParameters,
                  dataDescriptions: linearConnectorParametersDescriptions,
                  dataTypes: linearConnectorDataTypes,
                  examples: linearConnectorExamples,
                ),
              ],
            ),
            const Divider(),

            RoundedExpansionTile(
              key: heading["Bar"],
              titleString: "Bar",
              subtitleString: linearBarStructDescription,
              children: [
                TypesList(
                  parameters: linearBarParameters,
                  dataDescriptions: linearBarParametersDescriptions,
                  dataTypes: linearBarDataTypes,
                  examples: linearBarExamples,
                ),
              ],
            ),
            const Divider(),

            RoundedExpansionTile(
              key: heading["Particle"],
              titleString: "Particle",
              subtitleString: linearParticleStructDescription,
              children: [
                TypesList(
                  parameters: linearParticleParameters,
                  dataDescriptions: linearParticleParametersDescriptions,
                  dataTypes: linearParticleDataTypes,
                  examples: linearParticleExamples,
                ),
              ],
            ),

            BottomNavigation(
              prevNavItem: NavItem(
                title: "Chain - Examples",
                route: ChainExamplesScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Configuration",
                route: LinearConfigScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
