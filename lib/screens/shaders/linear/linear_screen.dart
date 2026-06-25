import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/constants/lifecycle_functions.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/linear/linear_config_screen.dart';
import 'package:wayves_wiki/screens/shaders/linear/linear_examples_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/function_describer.dart';
import 'package:wayves_wiki/widgets/info_card.dart';

class LinearScreen extends StatefulWidget {
  const LinearScreen({super.key});
  static const routeName = '/shaders/linear/life-cycle';

  @override
  State<LinearScreen> createState() => _LinearScreenState();
}

class _LinearScreenState extends State<LinearScreen> {
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
              key: heading["Life Cycle"],
              "Life Cycle",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                "Functions that are called at particular instances within the Linear Shader",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const InfoCard(
              textString:
                  "Both Linear and Angular Visualisers have the same Life Cycle Functions",
            ),
            const Divider(),
            Column(
              children: [
                ListView.separated(
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                  shrinkWrap: true,

                  itemBuilder: (context, index) => Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 24.0, right: 8),
                        child: Text(
                          "${index + 1}.",
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                      Expanded(
                        child: FunctionDescriber(
                          index: index,
                          functions: linearLifeCycleFunctions,
                          functionsDescriptions:
                              linearLifeCycleFunctionsDescriptions,
                          sampleCodes: linearSampleCodes,
                        ),
                      ),
                    ],
                  ),
                  itemCount: linearLifeCycleFunctions.length,
                ),
                BottomNavigation(
                  prevNavItem: NavItem(
                    title: "Configuration",
                    route: LinearConfigScreen.routeName,
                  ),
                  nextNavItem: NavItem(
                    title: "Examples",
                    route: LinearExamplesScreen.routeName,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
