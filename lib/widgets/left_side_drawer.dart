import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayves_wiki/constants/nav_items.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/widgets/custom_search_bar.dart';

class LeftSideDrawer extends StatefulWidget {
  final bool showBackButton;
  final GlobalKey<BeamerState> beamerKey;

  const LeftSideDrawer({
    super.key,
    required this.showBackButton,
    required this.beamerKey,
  });

  @override
  State<LeftSideDrawer> createState() => _LeftSideDrawerState();
}

class _LeftSideDrawerState extends State<LeftSideDrawer> {
  String currentRoute = "";
  final List<NavItem> navItems = rootNavItem.children!;
  @override
  Widget build(BuildContext context) {
    void changePage(String route) {
      setState(() {
        currentRoute = route;

        widget.beamerKey.currentState?.routerDelegate.beamToNamed(route);
      });

      Scaffold.of(context).closeDrawer();
    }

    final path = (context.currentBeamLocation.state as BeamState).uri.path;

    return Scaffold(
      appBar: widget.showBackButton
          ? AppBar(
              scrolledUnderElevation: 0,
              elevation: widget.showBackButton ? 5 : 0,
              backgroundColor: widget.showBackButton
                  ? Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).colorScheme.inversePrimary
                        : null
                  : Colors.transparent,
              titleSpacing: 0,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 8,
                      ),
                      child: Text(
                        "WayVes",
                        style: GoogleFonts.audiowideTextTheme(
                          Theme.of(context).textTheme,
                        ).headlineMedium,
                      ),
                    ),
                  ),
                  widget.showBackButton
                      ? IconButton(
                          onPressed: Scaffold.of(context).closeDrawer,
                          icon: const Icon(Icons.arrow_back),
                        )
                      : const SizedBox(),
                ],
              ),
            )
          : null,
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget.showBackButton
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CustomSearchBar(
                      theme: Theme.of(context),
                      isLargeScreen: !widget.showBackButton,
                    ),
                  )
                : const SizedBox(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: ListView.separated(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context, index) =>
                    navItems[index].children == null
                    ? TextButton(
                        style: TextButton.styleFrom(
                          backgroundColor: path == (navItems[index].route!)
                              ? Theme.of(context).colorScheme.secondaryContainer
                              : null,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                navItems[index].title,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                        ),

                        onPressed: () => changePage(navItems[index].route!),
                      )
                    : NavigationExpansionTile(
                        navItem: navItems[index],
                        path: path,
                        isLargeScreen: !widget.showBackButton,
                        changePage: (innerIndex) => changePage(innerIndex),
                      ),
                separatorBuilder: (context, index) => const SizedBox(height: 8),
                itemCount: navItems.length,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class NavigationExpansionTile extends StatefulWidget {
  const NavigationExpansionTile({
    super.key,
    required this.navItem,
    required this.changePage,
    required this.path,
    required this.isLargeScreen,
  });

  final NavItem navItem;
  final String path;
  final bool isLargeScreen;
  final Function(String) changePage;

  @override
  State<NavigationExpansionTile> createState() =>
      _NavigationExpansionTileState();
}

class _NavigationExpansionTileState extends State<NavigationExpansionTile> {
  bool switcher = false;

  late List<NavItem> currentNavItems;
  String currentNavItemTitle = "";

  @override
  void initState() {
    super.initState();
    currentNavItems = widget.navItem.children == null
        ? []
        : widget.navItem.children!;
  }

  Widget getItems(List<NavItem> navItems) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: navItems
          .map(
            (NavItem navItem) => Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: IntrinsicHeight(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: VerticalDivider(
                            thickness: 0.5,

                            color: Theme.of(
                              context,
                            ).colorScheme.onPrimaryContainer,
                            width: 0.5,
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 10,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              visualDensity: VisualDensity.compact,

                              backgroundColor: navItem.children == null
                                  ? (widget.path == (navItem.route!) ||
                                            (navItem.children != null &&
                                                navItem.children!.any(
                                                  (nestedNavItem) =>
                                                      widget.path ==
                                                      nestedNavItem.route!,
                                                ))
                                        ? Theme.of(
                                            context,
                                          ).colorScheme.secondaryContainer
                                        : null)
                                  : navItem.children!.any(
                                      (nestedNavItem) =>
                                          widget.path == (nestedNavItem.route!),
                                    )
                                  ? Theme.of(
                                      context,
                                    ).colorScheme.secondaryContainer
                                  : null,
                            ),
                            onPressed: () => navItem.children == null
                                ? widget.changePage(navItem.route!)
                                : setState(() {
                                    switcher = true;
                                    currentNavItemTitle = navItem.title;
                                    currentNavItems = navItem.children ?? [];
                                  }),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 32.0),
                                    child: Text(
                                      navItem.title,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.titleSmall,
                                    ),
                                  ),
                                ),
                                navItem.children == null
                                    ? const SizedBox()
                                    : const Icon(
                                        Icons.arrow_forward_ios,
                                        size: 15,
                                      ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  final expansibleController = ExpansibleController();

  @override
  Widget build(BuildContext context) {
    final path = (context.currentBeamLocation.state as BeamState).uri.path;
    final bool shouldExpandTile =
        widget.navItem.children?.any(
          (NavItem nestedNavItem) => nestedNavItem.route == null
              ? nestedNavItem.children == null
                    ? false
                    : nestedNavItem.children!.any(
                        (nestedNavItemChild) =>
                            path == nestedNavItemChild.route,
                      )
              : path == (nestedNavItem.route!),
        ) ??
        false;
    shouldExpandTile ? expansibleController.expand() : null;

    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(20),
      child: ExpansionTile(
        onExpansionChanged: (value) {},

        controller: expansibleController,
        tilePadding: const EdgeInsets.symmetric(horizontal: 12),
        expandedAlignment: Alignment.centerLeft,
        dense: true,

        initiallyExpanded: shouldExpandTile,
        collapsedBackgroundColor: shouldExpandTile
            ? Theme.of(context).colorScheme.secondaryContainer
            : null,

        visualDensity: VisualDensity.compact,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
        ),
        title: Text(
          widget.navItem.title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        children: [
          Row(
            children: [
              Expanded(
                child: Stack(
                  fit: StackFit.passthrough,
                  children: [
                    AnimatedCrossFade(
                      crossFadeState: switcher
                          ? CrossFadeState.showSecond
                          : CrossFadeState.showFirst,

                      duration: const Duration(milliseconds: 300),
                      firstChild: getItems(widget.navItem.children ?? []),
                      secondChild: Opacity(
                        opacity: 0,
                        child: NestedNavigationCard(
                          navigationItemsColumn: Padding(
                            padding: const EdgeInsets.only(
                              bottom: 8.0,
                              left: 4,
                              right: 4,
                            ),
                            child: getItems(currentNavItems),
                          ),
                          title: currentNavItemTitle,
                          onPressed: () => setState(() {
                            switcher = false;
                          }),
                        ),
                      ),
                    ),
                    AnimatedPositioned(
                      curve: Curves.easeIn,
                      left: switcher
                          ? 0
                          : MediaQuery.of(context).size.width *
                                (widget.isLargeScreen ? (-4 / 11) : -2),
                      right: switcher
                          ? 0
                          : MediaQuery.of(context).size.width *
                                (widget.isLargeScreen ? (2 / 11) : 1),
                      top: 0,

                      duration: const Duration(milliseconds: 300),
                      child: NestedNavigationCard(
                        navigationItemsColumn: getItems(currentNavItems),
                        title: currentNavItemTitle,
                        onPressed: () => setState(() {
                          switcher = false;
                        }),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class NestedNavigationCard extends StatelessWidget {
  final Widget navigationItemsColumn;
  final String title;
  final Function() onPressed;
  const NestedNavigationCard({
    super.key,
    required this.navigationItemsColumn,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4.0),
              child: TextButton.icon(
                style: ButtonStyle(
                  side: WidgetStatePropertyAll(
                    BorderSide(
                      width: 0.5,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
                icon: const Icon(Icons.arrow_back_ios, size: 15),

                onPressed: onPressed,
                label: Text(
                  title,
                  style: Theme.of(context).textTheme.titleSmall,
                ),
              ),
            ),
          ),
          navigationItemsColumn,
        ],
      ),
    );
  }
}
