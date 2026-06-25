import 'package:flutter/material.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/ncs/ncs_life_cycle_screen.dart';
import 'package:wayves_wiki/screens/shaders/ncs/ncs_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/markdown_file_loader.dart';

class NcsConfigurationScreen extends StatefulWidget {
  const NcsConfigurationScreen({super.key});
  static const routeName = '/shaders/ncs/configuration';

  @override
  State<NcsConfigurationScreen> createState() => _NcsConfigurationScreenState();
}

class _NcsConfigurationScreenState extends State<NcsConfigurationScreen> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            MarkdownFileLoader(fileName: NcsConfigurationScreen.routeName),

            BottomNavigation(
              prevNavItem: NavItem(
                title: "Overview",
                route: NcsScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Life Cycle",
                route: NcsLifeCycleScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
