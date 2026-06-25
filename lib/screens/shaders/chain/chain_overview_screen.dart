import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/chain_descriptions.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/chain/chain_configuration_screen.dart';
import 'package:wayves_wiki/screens/shaders/shaders_overview_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/images_viewer.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/types_list.dart';

class ChainOverviewScreen extends StatefulWidget {
  const ChainOverviewScreen({super.key});
  static const routeName = '/shaders/chain/overview';

  @override
  State<ChainOverviewScreen> createState() => _ChainOverviewScreenState();
}

class _ChainOverviewScreenState extends State<ChainOverviewScreen> {
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
              key: heading!["Chain"],
              "Chain",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: RichTextFromTicks(
                text:
                    "Simple `Chain` Visualiser, as seen on `Panon`, a Visualiser for `KDE Plasma`",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ImagesViewer(
                    height: 150,
                    images: [
                      Image.asset(
                        ('assets/images/chain_frame_0.webp'),
                        fit: BoxFit.scaleDown,
                        height: 150,
                        cacheHeight: 150,
                        cacheWidth: 880,
                        width: 880,
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
                        ('assets/images/chain.webp'),
                        fit: BoxFit.scaleDown,
                        height: 150,
                        cacheHeight: 150,
                        cacheWidth: 880,
                        width: 880,
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
                  ),
                ),
                // const Spacer(flex: 1),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Audio Settings"],
              titleString: "Audio Settings",
              subtitleString: chainAudioSettingsStructDescription,
              children: [
                TypesList(
                  parameters: chainAudioSettingsParameters,
                  dataDescriptions: chainAudioSettingsParametersDescriptions,
                  dataTypes: chainAudioSettingsDataTypes,
                  examples: chainAudioSettingsExamples,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Audio"],
              titleString: "Audio",
              subtitleString: chainAudioStructDescription,
              children: [
                TypesList(
                  parameters: chainAudioParameters,
                  dataDescriptions: chainAudioParametersDescriptions,
                  dataTypes: chainAudioDataTypes,
                  examples: chainAudioExamples,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Chain "],
              titleString: "Chain",
              subtitleString: chainChainStructDescription,
              children: [
                TypesList(
                  parameters: chainChainParameters,
                  dataDescriptions: chainChainParametersDescriptions,
                  dataTypes: chainChainDataTypes,
                  examples: chainChainExamples,
                ),
              ],
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Shaders - Overview",
                route: ShadersOverviewScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Configuration",
                route: ChainConfigurationScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
