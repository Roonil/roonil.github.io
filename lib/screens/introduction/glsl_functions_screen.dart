import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/glsl_functions.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/introduction/data_types_screen.dart';
import 'package:wayves_wiki/screens/shaders/shaders_overview_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';
import 'package:wayves_wiki/widgets/types_list.dart';

class GlslFunctionsScreen extends StatefulWidget {
  const GlslFunctionsScreen({super.key});
  static const routeName = '/introduction/glsl-functions';
  @override
  State<GlslFunctionsScreen> createState() => _GlslFunctionsScreenState();
}

class _GlslFunctionsScreenState extends State<GlslFunctionsScreen> {
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
                key: heading!["GLSL Functions"],
                "GLSL Functions",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, bottom: 8, left: 12),
              child: SpacedLines(
                text:
                    """Listed are some common `GLSL Functions` that can be used to obtain specific outputs.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            TypesList(
              parameters: functions,
              dataDescriptions: functionsDescriptions,
              dataTypes: null,
              examples: null,
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Data Types",
                route: DataTypesScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Shaders - Overview",
                route: ShadersOverviewScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
