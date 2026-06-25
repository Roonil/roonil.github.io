import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/constants/angular_descriptions.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/angular/angular_config_screen.dart';
import 'package:wayves_wiki/screens/shaders/linear/linear_examples_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/images_viewer.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/types_list.dart';

class AngularOverviewScreen extends StatefulWidget {
  const AngularOverviewScreen({super.key});

  static const routeName = '/shaders/angular/overview';

  @override
  State<AngularOverviewScreen> createState() => _AngularOverviewScreenState();
}

class _AngularOverviewScreenState extends State<AngularOverviewScreen> {
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
    final Map<String, GlobalKey<State<StatefulWidget>>> heading =
        headings[Beamer.of(context).configuration.uri.path]!;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key: heading["Angular"],
              "Angular",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Text(
                "Angular Counter-part of the Linear Visualiser, represents the Set of Bars, Particles and Particle Connectors that can be drawn on a circular Path.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                  child: ImagesViewer(
                    height: 360,

                    animatedImages: [
                      Image.asset(
                        ('assets/images/angular.webp'),
                        fit: BoxFit.scaleDown,
                        width: 360,
                        height: 360,
                        cacheHeight: 360,
                        cacheWidth: 360,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              return wasSynchronouslyLoaded || frame != null
                                  ? child
                                  : const Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.loose,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsGeometry.all(120),
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
                        ('assets/images/angular_webbed.webp'),
                        fit: BoxFit.scaleDown,
                        width: 360,
                        height: 360,
                        cacheHeight: 360,
                        cacheWidth: 360,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              return wasSynchronouslyLoaded || frame != null
                                  ? child
                                  : const Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.loose,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsGeometry.all(120),
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
                        ('assets/images/angular_hexagon.webp'),
                        fit: BoxFit.scaleDown,
                        width: 360,
                        height: 360,
                        cacheHeight: 360,
                        cacheWidth: 360,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              return wasSynchronouslyLoaded || frame != null
                                  ? child
                                  : const Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.loose,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsGeometry.all(120),
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
                    images: [
                      Image.asset(
                        ('assets/images/angular_frame0.webp'),
                        fit: BoxFit.scaleDown,
                        width: 360,
                        height: 360,
                        cacheHeight: 360,
                        cacheWidth: 360,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              return wasSynchronouslyLoaded || frame != null
                                  ? child
                                  : const Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.loose,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsGeometry.all(120),
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
                        ('assets/images/angular_webbed_frame0.webp'),
                        fit: BoxFit.scaleDown,
                        width: 360,
                        height: 360,
                        cacheHeight: 360,
                        cacheWidth: 360,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              return wasSynchronouslyLoaded || frame != null
                                  ? child
                                  : const Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.loose,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsGeometry.all(120),
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
                        ('assets/images/angular_hexagon_frame0.webp'),
                        fit: BoxFit.scaleDown,
                        width: 360,
                        height: 360,
                        cacheHeight: 360,
                        cacheWidth: 360,
                        frameBuilder:
                            (context, child, frame, wasSynchronouslyLoaded) {
                              return wasSynchronouslyLoaded || frame != null
                                  ? child
                                  : const Stack(
                                      alignment: Alignment.center,
                                      fit: StackFit.loose,
                                      children: [
                                        Padding(
                                          padding: EdgeInsetsGeometry.all(120),
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
            const InfoCard(
              textString:
                  "For Information about Fragments, Primitives and internal Working, refer to the Linear Visualiser Documentation",
            ),
            const Divider(),

            RoundedExpansionTile(
              key: heading["Audio Settings"],
              titleString: "Audio Settings",
              subtitleString: angularAudioSettingsStructDescription,
              children: [
                TypesList(
                  parameters: angularAudioSettingsParameters,
                  dataDescriptions: angularAudioSettingsParametersDescriptions,
                  dataTypes: angularAudioSettingsDataTypes,
                  examples: angularAudioSettingsExamples,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Audio"],
              titleString: "Audio",
              subtitleString: angularAudioStructDescription,
              children: [
                TypesList(
                  parameters: angularAudioParameters,
                  dataDescriptions: angularAudioParametersDescriptions,
                  dataTypes: angularAudioDataTypes,
                  examples: angularAudioExamples,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Fragment"],
              titleString: "Fragment",
              subtitleString: angularFragmentStructDescription,
              children: [
                TypesList(
                  parameters: angularFragmentParameters,
                  dataDescriptions: angularFragmentParametersDescriptions,
                  dataTypes: angularFragmentDataTypes,
                  examples: angularFragmentExamples,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Circle"],
              titleString: "Circle",
              subtitleString: angularCircleStructDescription,
              children: [
                TypesList(
                  parameters: angularCircleParameters,
                  dataDescriptions: angularCircleParametersDescriptions,
                  dataTypes: angularCircleDataTypes,
                  examples: angularCircleExamples,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Cap"],
              titleString: "Cap",
              subtitleString: angularCapStructDescription,
              children: [
                TypesList(
                  parameters: angularCapParameters,
                  dataDescriptions: angularCapParametersDescriptions,
                  dataTypes: angularCapDataTypes,
                  examples: angularCapExamples,
                ),
              ],
            ),
            const Divider(),

            RoundedExpansionTile(
              key: heading["Connector Half"],
              titleString: "Connector Half",
              subtitleString: angularConnectorHalfStructDescription,
              children: [
                TypesList(
                  parameters: angularConnectorHalfParameters,
                  dataDescriptions: angularConnectorHalfParametersDescriptions,
                  dataTypes: angularConnectorHalfDataTypes,
                  examples: angularConnectorHalfExamples,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Connector"],
              titleString: "Connector",
              subtitleString: angularConnectorStructDescription,
              children: [
                TypesList(
                  parameters: angularConnectorParameters,
                  dataDescriptions: angularConnectorParametersDescriptions,
                  dataTypes: angularConnectorDataTypes,
                  examples: angularConnectorExamples,
                ),
              ],
            ),
            const Divider(),

            RoundedExpansionTile(
              key: heading["Bar"],
              titleString: "Bar",
              subtitleString: angularBarStructDescription,
              children: [
                TypesList(
                  parameters: angularBarParameters,
                  dataDescriptions: angularBarParametersDescriptions,
                  dataTypes: angularBarDataTypes,
                  examples: angularBarExamples,
                ),
              ],
            ),
            const Divider(),

            RoundedExpansionTile(
              key: heading["Particle"],
              titleString: "Particle",
              subtitleString: angularParticleStructDescription,
              children: [
                TypesList(
                  parameters: angularParticleParameters,
                  dataDescriptions: angularParticleParametersDescriptions,
                  dataTypes: angularParticleDataTypes,
                  examples: angularParticleExamples,
                ),
              ],
            ),
            BottomNavigation(
              nextNavItem: NavItem(
                title: "Configuration",
                route: AngularConfigScreen.routeName,
              ),
              prevNavItem: NavItem(
                title: "Linear - Examples",
                route: LinearExamplesScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
