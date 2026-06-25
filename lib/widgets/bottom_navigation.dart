import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/models/nav_item.dart';

class BottomNavigation extends StatelessWidget {
  const BottomNavigation({
    super.key,
    required this.prevNavItem,
    required this.nextNavItem,
  });
  final NavItem? prevNavItem, nextNavItem;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Padding(padding: EdgeInsets.only(bottom: 20), child: Divider()),
        Padding(
          padding: const EdgeInsets.only(top: 16.0, bottom: 36),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 12,
                  direction: Axis.horizontal,
                  children: [
                    prevNavItem != null
                        ? TextButton.icon(
                            icon: const Icon(
                              Icons.keyboard_arrow_left_rounded,
                              size: 30,
                            ),
                            onPressed: () => Beamer.of(
                              context,
                            ).beamToNamed(prevNavItem!.route!),
                            label: Text(
                              prevNavItem!.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          )
                        : const SizedBox(),
                    nextNavItem != null
                        ? TextButton.icon(
                            icon: const Icon(
                              Icons.keyboard_arrow_right_rounded,
                              size: 30,
                            ),
                            onPressed: () => Beamer.of(
                              context,
                            ).beamToNamed(nextNavItem!.route!),
                            iconAlignment: IconAlignment.end,
                            label: Text(
                              nextNavItem!.title,
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          )
                        : const SizedBox(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
