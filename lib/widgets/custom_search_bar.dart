import 'dart:ui';

import 'package:beamer/beamer.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wayves_wiki/bloc/search_bloc.dart';
import 'package:wayves_wiki/bloc/search_events.dart';
import 'package:wayves_wiki/bloc/search_states.dart';
import 'package:wayves_wiki/constants/search_entries.dart';
import 'package:wayves_wiki/helper_functions/rich_text_from_ticks.dart';
import 'package:wayves_wiki/models/search_entry.dart';
import 'package:wayves_wiki/widgets/debouncer.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({
    super.key,
    required this.theme,
    required this.isLargeScreen,
  });
  final ThemeData theme;
  final bool isLargeScreen;
  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController outerTextEditingController =
      TextEditingController();
  final TextEditingController innerTextEditingController =
      TextEditingController();

  final OverlayPortalController overlayPortalController =
      OverlayPortalController();
  final FocusNode outerSearchBarFocusNode = FocusNode();
  final FocusNode innerSearchBarFocusNode = FocusNode();

  final SearchController searchController = SearchController();

  String currentSearchText = "";

  final _debouncer = Debouncer(milliseconds: 200);

  @override
  void initState() {
    outerSearchBarFocusNode.addListener(
      () => outerSearchBarFocusNode.hasFocus
          ? outerSearchBarFocusNode.unfocus()
          : null,
    );

    searchController.text = (BlocProvider.of<SearchBloc>(
      context,
    ).state).searchString;

    outerTextEditingController.text = (BlocProvider.of<SearchBloc>(
      context,
    ).state).searchString;

    innerTextEditingController.text = (BlocProvider.of<SearchBloc>(
      context,
    ).state).searchString;

    super.initState();
  }

  @override
  void dispose() {
    outerSearchBarFocusNode.removeListener(
      () => outerSearchBarFocusNode.hasFocus
          ? outerSearchBarFocusNode.unfocus()
          : null,
    );

    _debouncer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    void handleTap(SearchEntry searchEntry) {
      Beamer.of(context).beamToNamed(searchEntry.route);
    }

    return SizedBox(
      height: 48,
      child: !widget.isLargeScreen
          ? SearchAnchor.bar(
              barHintText: "Enter Search Text",
              searchController: searchController,

              barLeading: searchController.text.isEmpty
                  ? const Icon(Icons.search)
                  : const Text("Searched for:"),
              viewHintText: "Enter Search Text",
              viewBackgroundColor: Theme.of(context).scaffoldBackgroundColor,
              isFullScreen: true,
              viewTrailing: [
                IconButton(
                  onPressed: () {
                    BlocProvider.of<SearchBloc>(context).add(
                      InitiateSearchEvent(
                        searchString: "",
                        currentSearchEntries: searchEntries,
                      ),
                    );
                    setState(() {
                      innerTextEditingController.text = "";
                      currentSearchText = "";
                      searchController.text = "";
                    });
                  },
                  tooltip: "Clear text",
                  icon: const Icon(Icons.close),
                ),
              ],
              onChanged: (value) {
                _debouncer.run(() {
                  BlocProvider.of<SearchBloc>(context).add(
                    InitiateSearchEvent(
                      currentSearchEntries: searchEntries,
                      searchString: value,
                    ),
                  );
                });
              },

              viewBuilder: (suggestions) {
                return SearchResultsView(
                  searchController: searchController,
                  widget: widget,
                  handleTap: handleTap,
                  innerSearchBarFocusNode: innerSearchBarFocusNode,
                  overlayPortalController: overlayPortalController,
                );
              },
              suggestionsBuilder:
                  (BuildContext context, SearchController controller) {
                    return [];
                  },
            )
          : OverlayPortal(
              controller: overlayPortalController,
              overlayLocation: OverlayChildLocation.nearestOverlay,

              overlayChildBuilder: (context) {
                return TapRegion(
                  onTapOutside: (event) => overlayPortalController.hide(),
                  behavior: HitTestBehavior.opaque,
                  child: ClipRRect(
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 6.0, sigmaY: 6.0),
                      child: Stack(
                        children: [
                          Positioned.fill(
                            left: 300,
                            right: 300,
                            top: 130,
                            bottom: 130,
                            child: TapRegion(
                              onTapOutside: (event) =>
                                  overlayPortalController.hide(),
                              child: FocusScope(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.stretch,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(
                                        bottom: 8.0,
                                      ),
                                      child: BlocConsumer<SearchBloc, SearchState>(
                                        listener: (context, state) {},
                                        buildWhen: (previous, current) =>
                                            previous != current,
                                        builder: (context, state) {
                                          innerTextEditingController.text !=
                                                  state.searchString
                                              ? innerTextEditingController
                                                        .text =
                                                    state.searchString
                                              : null;
                                          return SearchBar(
                                            hintText: "Enter Search Text",
                                            autoFocus: true,
                                            leading: const Icon(Icons.search),
                                            trailing: [
                                              IconButton(
                                                onPressed: () {
                                                  BlocProvider.of<SearchBloc>(
                                                    context,
                                                  ).add(
                                                    InitiateSearchEvent(
                                                      searchString: "",
                                                      currentSearchEntries:
                                                          searchEntries,
                                                    ),
                                                  );
                                                  setState(() {
                                                    innerTextEditingController
                                                            .text =
                                                        "";
                                                    currentSearchText = "";
                                                    outerTextEditingController
                                                            .text =
                                                        "";
                                                  });
                                                },
                                                tooltip: "Clear text",
                                                icon: const Icon(Icons.close),
                                              ),
                                            ],
                                            focusNode: innerSearchBarFocusNode,
                                            controller:
                                                innerTextEditingController,
                                            onChanged: (value) {
                                              _debouncer.run(() {
                                                BlocProvider.of<SearchBloc>(
                                                  context,
                                                ).add(
                                                  InitiateSearchEvent(
                                                    currentSearchEntries:
                                                        searchEntries,
                                                    searchString: value,
                                                  ),
                                                );
                                              });
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    Expanded(
                                      child: Card(
                                        color: const Color.fromARGB(
                                          255,
                                          24,
                                          24,
                                          24,
                                        ),
                                        elevation: 1,

                                        child: SearchResultsView(
                                          widget: widget,
                                          searchController: searchController,
                                          handleTap: handleTap,
                                          innerSearchBarFocusNode:
                                              innerSearchBarFocusNode,
                                          overlayPortalController:
                                              overlayPortalController,
                                        ),
                                      ),
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
                );
              },
              child: BlocConsumer<SearchBloc, SearchState>(
                listener: (context, state) {},
                buildWhen: (previous, current) => previous != current,
                builder: (context, state) {
                  outerTextEditingController.text != state.searchString
                      ? outerTextEditingController.text = state.searchString
                      : null;

                  return SearchBar(
                    leading: (state.searchString.isEmpty)
                        ? const Icon(Icons.search)
                        : const Text("Searched for:"),

                    focusNode: outerSearchBarFocusNode,
                    controller: outerTextEditingController,
                    autoFocus: false,

                    elevation: const WidgetStatePropertyAll(0),
                    hintText: "Enter Search Text",

                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        side: BorderSide(
                          width: 1,
                          color: widget.theme.colorScheme.primary.withAlpha(
                            180,
                          ),
                        ),
                        borderRadius: BorderRadiusGeometry.circular(30),
                      ),
                    ),
                    onChanged: (value) => {outerSearchBarFocusNode.unfocus()},

                    onTap: () => {
                      outerSearchBarFocusNode.unfocus(),
                      overlayPortalController.show(),
                      innerSearchBarFocusNode.requestFocus(),
                    },
                  );
                },
              ),
            ),
    );
  }
}

class SearchResultsView extends StatelessWidget {
  const SearchResultsView({
    super.key,
    required this.widget,
    required this.innerSearchBarFocusNode,
    required this.overlayPortalController,
    required this.handleTap,
    required this.searchController,
  });

  final CustomSearchBar widget;
  final FocusNode innerSearchBarFocusNode;
  final SearchController searchController;
  final Function(SearchEntry) handleTap;
  final OverlayPortalController overlayPortalController;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SearchBloc, SearchState>(
      listener: (BuildContext context, SearchState state) {},
      buildWhen: (previous, current) => previous != current,
      builder: (context, state) {
        if (state is SearchingState) {
          return const Align(
            alignment: Alignment.center,
            child: CircularProgressIndicator(),
          );
        }

        if (state is SearchFailedState) {
          return Align(
            alignment: Alignment.center,
            child: Text(
              "No Search Results found!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
          );
        }

        return SearchResultsListView(
          theme: widget.theme,
          searchEntries: state is InitialState
              ? searchEntries
              : (state as FetchedSearchResultsState).searchEntries,
          searchBarFocusNode: innerSearchBarFocusNode,
          overlayPortalController: overlayPortalController,
          handleTap: handleTap,
        );
      },
    );
  }
}

class SearchResultsListView extends StatelessWidget {
  const SearchResultsListView({
    super.key,
    required this.theme,
    required this.searchBarFocusNode,
    required this.overlayPortalController,
    required this.handleTap,
    required this.searchEntries,
  });

  final ThemeData theme;
  final FocusNode searchBarFocusNode;
  final OverlayPortalController overlayPortalController;
  final List<SearchEntry> searchEntries;
  final Function(SearchEntry) handleTap;

  @override
  Widget build(BuildContext context) {
    if (searchEntries.isEmpty) {
      return Center(
        child: Text(
          "No Search Results found!",
          style: theme.textTheme.titleLarge,
        ),
      );
    }

    return ListView.builder(
      shrinkWrap: true,
      itemCount: searchEntries.length,
      itemBuilder: (context, index) {
        SearchEntry searchEntry = searchEntries[index];
        return Padding(
          padding: const EdgeInsets.all(8),
          child: Card.outlined(
            elevation: 3,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
              side: BorderSide(width: .5, color: theme.colorScheme.primary),
            ),

            child: Column(
              children: [
                RoundedExpansionTile(
                  titleWidget: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: searchEntry.route
                          .split('/')
                          .indexed
                          .map(
                            (routePath) => routePath.$1 == 0
                                ? const SizedBox()
                                : Padding(
                                    padding: const EdgeInsets.symmetric(
                                      vertical: 6,
                                      horizontal: 4,
                                    ),
                                    child: Focus(
                                      skipTraversal: true,
                                      descendantsAreTraversable: false,
                                      canRequestFocus: false,

                                      child: IgnorePointer(
                                        ignoring: true,
                                        child:
                                            routePath.$2 ==
                                                searchEntry.route
                                                    .split('/')
                                                    .last
                                            ? TextButton.icon(
                                                onPressed: () {},

                                                icon: const Icon(
                                                  Icons.keyboard_arrow_right,
                                                  size: 20,
                                                  color: Colors.transparent,
                                                ),

                                                iconAlignment:
                                                    IconAlignment.end,

                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 4,
                                                        bottom: 4,
                                                        left: 2,
                                                        right: 2,
                                                      ),

                                                  visualDensity:
                                                      VisualDensity.compact,
                                                ),
                                                label: Text(
                                                  "${routePath.$2.split('-').map((String splitText) => "${splitText[0].toUpperCase()}${splitText.substring(1)}").join(' ')} ",
                                                ),
                                              )
                                            : TextButton.icon(
                                                onPressed: () {},

                                                icon: const Icon(
                                                  Icons.keyboard_arrow_right,
                                                  size: 20,
                                                ),

                                                iconAlignment:
                                                    IconAlignment.end,

                                                style: TextButton.styleFrom(
                                                  padding:
                                                      const EdgeInsets.only(
                                                        top: 4,
                                                        bottom: 4,
                                                        left: 12,
                                                        right: 2,
                                                      ),
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadiusGeometry.circular(
                                                          20,
                                                        ),
                                                    side: BorderSide(
                                                      width: 0.5,
                                                      color: Theme.of(
                                                        context,
                                                      ).colorScheme.primary,
                                                    ),
                                                  ),
                                                  visualDensity:
                                                      VisualDensity.compact,
                                                ),
                                                label: Text(
                                                  "${routePath.$2.split('-').map((String splitText) => "${splitText[0].toUpperCase()}${splitText.substring(1)}").join(' ')} ",
                                                  style: Theme.of(
                                                    context,
                                                  ).textTheme.titleMedium,
                                                ),
                                              ),
                                      ),
                                    ),
                                  ),
                          )
                          .toList(),
                    ),
                  ),
                  titleString: searchEntry.route
                      .split('/')
                      .fold(
                        "",
                        (previousValue, element) => previousValue != ""
                            ? "$previousValue > ${element[0].toUpperCase()}${element.substring(1)}"
                            : element,
                      )
                      .split('-')
                      .map(
                        (String splitText) =>
                            "${splitText[0].toUpperCase()}${splitText.substring(1)}",
                      )
                      .join(' '),
                  textStyle: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),

                  children: [
                    ListView.separated(
                      separatorBuilder: (context, index) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Divider(
                          color: Theme.of(
                            context,
                          ).colorScheme.primary.withAlpha(120),
                        ),
                      ),
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: searchEntry.searchHits.length,
                      itemBuilder: (context, index) {
                        SearchHit searchHit = searchEntry.searchHits[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            onTap: () async {
                              searchBarFocusNode.unfocus();
                              overlayPortalController.isShowing
                                  ? overlayPortalController.hide()
                                  : null;

                              (context.currentBeamLocation.state as BeamState)
                                          .uri
                                          .path !=
                                      searchEntry.route
                                  ? {
                                      await Future.delayed(
                                        const Duration(microseconds: 200),
                                      ).then((value) => handleTap(searchEntry)),
                                    }
                                  : null;

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                final context = null;
                                if (context != null) {
                                  Scrollable.ensureVisible(
                                    context,
                                    duration: const Duration(milliseconds: 500),
                                    curve: Curves.fastEaseInToSlowEaseOut,
                                  );
                                  Scaffold.of(context).closeDrawer();
                                  Scaffold.of(context).closeEndDrawer();
                                }
                              });
                            },
                            title: Text.rich(
                              HelperFunctions.getRichTextFromTicks(
                                text: searchHit.keyword,
                                style: theme.textTheme.titleLarge,
                              ),
                            ),
                            subtitle: Text.rich(
                              HelperFunctions.getRichTextFromTicks(
                                text: searchHit.snippet,
                                style: theme.textTheme.titleMedium,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
