import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';

import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/angular/angular_examples_screen.dart';
import 'package:wayves_wiki/screens/shaders/ncs/ncs_configuration_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/markdown_file_loader.dart';

class NcsScreen extends StatefulWidget {
  const NcsScreen({super.key});
  static const routeName = '/shaders/ncs/overview';

  @override
  State<NcsScreen> createState() => _NcsScreenState();
}

class _NcsScreenState extends State<NcsScreen> {
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
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(child: MarkdownFileLoader(fileName: NcsScreen.routeName)),

          BottomNavigation(
            nextNavItem: NavItem(
              title: "Configuration",
              route: NcsConfigurationScreen.routeName,
            ),
            prevNavItem: NavItem(
              title: "Angular - Examples",
              route: AngularExamplesScreen.routeName,
            ),
          ),
        ],
      ),
    );
  }
}
