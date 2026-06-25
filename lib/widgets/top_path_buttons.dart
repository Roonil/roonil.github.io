import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/nav_items.dart';
import 'package:wayves_wiki/models/nav_item.dart';

class TopPathButtons extends StatelessWidget {
  const TopPathButtons({super.key, required this.pathSegments});

  final List<String> pathSegments;

  @override
  Widget build(BuildContext context) {
    final List<String> topPathTitles = [];

    topPathTitles.addAll(
      pathSegments.indexed.map(
        (pathSegment) => pathSegment.$2
            .split('-')
            .map((e) => "${e[0].toUpperCase()}${e.substring(1)}")
            .join(' '),
      ),
    );

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            MenuBuilder(
              pathTitle: "Index",
              offset: null,
              parentMenuControllers: [],
              menuController: MenuController(),
            ),
            ...topPathTitles.indexed.map(
              (topPathTitle) => Builder(
                builder: (context) {
                  MenuController menuController = MenuController();
                  return MenuBuilder(
                    menuController: menuController,
                    pathTitle: topPathTitle.$2,
                    parentMenuControllers: [],
                    offset: null,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuBuilder extends StatelessWidget {
  const MenuBuilder({
    super.key,
    required this.pathTitle,
    required this.offset,
    required this.menuController,
    required this.parentMenuControllers,
  });
  final String pathTitle;

  final Offset? offset;
  final MenuController menuController;
  final List<MenuController> parentMenuControllers;

  bool checkPath(BuildContext context, NavItem navItem) {
    return (navItem.children == null)
        ? navItem.route!.toLowerCase() ==
              Beamer.of(context).currentConfiguration?.uri.path.toLowerCase()
        : navItem.children!.any(
            (NavItem navChild) => checkPath(context, navChild),
          );
  }

  NavItem getNavItemForTitle(
    String pathTitle,
    List<NavItem> searchableNavItems,
  ) {
    String lowerCasePathTitle = pathTitle.toLowerCase();
    for (NavItem navItem in searchableNavItems) {
      if (lowerCasePathTitle == navItem.title.toLowerCase()) return navItem;
      if (navItem.children == null) continue;

      NavItem childNavItem = getNavItemForTitle(pathTitle, navItem.children!);
      if (childNavItem.title.isNotEmpty) return childNavItem;
    }

    return NavItem(title: "");
  }

  @override
  Widget build(BuildContext context) {
    return Builder(
      builder: (context) {
        NavItem navItem = getNavItemForTitle(pathTitle, [rootNavItem]);

        return navItem.children == null
            ? TextButton.icon(
                onPressed: null,

                style: TextButton.styleFrom(
                  padding: const EdgeInsets.only(
                    top: 4,
                    bottom: 4,
                    left: 12,
                    right: 2,
                  ),
                  shape: null,

                  visualDensity: VisualDensity.compact,
                ),

                icon: const Icon(
                  Icons.keyboard_arrow_right,
                  size: 20,
                  color: Colors.transparent,
                ),

                iconAlignment: IconAlignment.end,
                label: Text(
                  pathTitle,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(
                      context,
                    ).textTheme.titleMedium?.color?.withAlpha(180),
                  ),
                ),
              )
            : MenuAnchor(
                controller: menuController,

                alignmentOffset:
                    const Offset(0, 4) + (offset ?? const Offset(0, 0)),
                style: MenuStyle(
                  shape: WidgetStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadiusGeometry.circular(12),
                    ),
                  ),
                ),
                menuChildren: navItem.children!
                    .map(
                      (NavItem navChild) => Builder(
                        builder: (context) {
                          MenuController navChildMenuController =
                              MenuController();
                          return navChild.children != null
                              ? MenuBuilder(
                                  pathTitle: navChild.title,
                                  offset: offset ?? const Offset(4, 0),
                                  parentMenuControllers: [
                                    ...parentMenuControllers,
                                    menuController,
                                  ],
                                  menuController: navChildMenuController,
                                )
                              : Padding(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 4.0,
                                    vertical: 2,
                                  ),
                                  child: TextButton(
                                    style: TextButton.styleFrom(
                                      backgroundColor:
                                          checkPath(context, navChild)
                                          ? Theme.of(
                                              context,
                                            ).colorScheme.secondaryContainer
                                          : null,
                                    ),
                                    onPressed: () => {
                                      Beamer.of(
                                        context,
                                      ).beamToNamed(navChild.route!),
                                      menuController.close(),
                                      for (MenuController parentMenuController
                                          in parentMenuControllers)
                                        {parentMenuController.close()},
                                    },

                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Expanded(child: Text(navChild.title)),
                                      ],
                                    ),
                                  ),
                                );
                        },
                      ),
                    )
                    .toList(),
                builder: (context, controller, child) => Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4.0,
                    vertical: 2,
                  ),
                  child: TextButton.icon(
                    onPressed: () => controller.isOpen
                        ? controller.close()
                        : controller.open(),
                    style: TextButton.styleFrom(
                      padding: const EdgeInsets.only(
                        top: 4,
                        bottom: 4,
                        left: 12,
                        right: 2,
                      ),
                      backgroundColor: offset == null
                          ? null
                          : checkPath(context, navItem)
                          ? Theme.of(context).colorScheme.secondaryContainer
                          : null,
                      shape: offset != null
                          ? null
                          : RoundedRectangleBorder(
                              borderRadius: BorderRadiusGeometry.circular(20),
                              side: BorderSide(
                                width: 0.5,
                                color: Theme.of(context).colorScheme.primary,
                              ),
                            ),

                      visualDensity: VisualDensity.compact,
                    ),

                    icon: const Icon(Icons.keyboard_arrow_right, size: 20),

                    iconAlignment: IconAlignment.end,
                    label: offset != null
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(child: Text(pathTitle)),
                              const SizedBox(),
                            ],
                          )
                        : Text(
                            pathTitle,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                  ),
                ),
              );
      },
    );
  }
}
