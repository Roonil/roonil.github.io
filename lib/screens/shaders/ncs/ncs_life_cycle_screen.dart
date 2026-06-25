import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/constants/lifecycle_functions.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/ncs/ncs_configuration_screen.dart';
import 'package:wayves_wiki/screens/shaders/ncs/ncs_examples_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/function_describer.dart';

class NcsLifeCycleScreen extends StatefulWidget {
  const NcsLifeCycleScreen({super.key});
  static const routeName = '/shaders/ncs/life-cycle';

  @override
  State<NcsLifeCycleScreen> createState() => _NcsLifeCycleScreenState();
}

class _NcsLifeCycleScreenState extends State<NcsLifeCycleScreen> {
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
              key: heading!["Life Cycle"],
              "Life Cycle",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                "Functions that are called at particular instances within the NCS Shader",
                style: Theme.of(context).textTheme.titleMedium,
              ),
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

                          functions: ncsLifeCycleFunctions,
                          functionsDescriptions:
                              ncsLifeCycleFunctionsDescriptions,
                          sampleCodes: ncsSampleCodes,
                        ),
                      ),
                    ],
                  ),
                  itemCount: ncsLifeCycleFunctions.length,
                ),
                BottomNavigation(
                  prevNavItem: NavItem(
                    title: "Configuration",
                    route: NcsConfigurationScreen.routeName,
                  ),
                  nextNavItem: NavItem(
                    title: "Examples",
                    route: NcsExamplesScreen.routeName,
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
