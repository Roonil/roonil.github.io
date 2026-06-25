import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/cli_args.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/advanced/piping_screen.dart';
import 'package:wayves_wiki/screens/recommendations/tips_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/types_list.dart';

class CliArgsScreen extends StatefulWidget {
  const CliArgsScreen({super.key});
  static const routeName = '/updating-properties/cli-arguments';

  @override
  State<CliArgsScreen> createState() => _CliArgsScreenState();
}

class _CliArgsScreenState extends State<CliArgsScreen> {
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
              key: heading!["CLI Arguments"],
              "CLI Arguments",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: RichTextFromTicks(
                text:
                    "`WayVes` supports passing in CLI Arguments to modify various aspects of the underlying Window that displays a `Shader`, that you pass in via the `YAML Configuration file`. You can change `Margins`, `Anchors`, or the `Layer` of a particular `Shader` by supplying its class name, or dispatch them to all `Shaders` without supplying any class name. You can even specify the name of a different `.yaml` file to read the configuration from.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            TypesList(
              parameters: letterArgs,
              dataDescriptions: argsDescriptions,
              dataTypes: null,
              examples: null,
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Piping Data",
                route: PipingScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Recommendations - Tips",
                route: TipsScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
