import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wayves_wiki/models/json_content.dart';
import 'package:wayves_wiki/models/controller_bundle.dart';

import 'beamer_key.dart';

import 'package:wayves_wiki/widgets/screen_contents.dart';
import 'package:wayves_wiki/widgets/left_side_drawer.dart';
import 'package:wayves_wiki/widgets/right_side_drawer.dart';
import 'package:wayves_wiki/widgets/top_path_buttons.dart';
import 'package:wayves_wiki/widgets/custom_search_bar.dart';

class SectionedScreen extends StatefulWidget {
  const SectionedScreen({super.key});

  @override
  State<SectionedScreen> createState() => _SectionedScreenState();
}

class _SectionedScreenState extends State<SectionedScreen> {
  List<String> pathSegments = [];

  ItemScrollController? _sharedScrollController;
  ItemPositionsListener? _sharedPositionsListener;

  List<JsonContent> _currentActiveBlocks = [];

  late final BeamerDelegate beamerDelegate;
  @override
  void initState() {
    super.initState();

    beamerDelegate = BeamerDelegate(
      initialPath: '/',
      locationBuilder: RoutesLocationBuilder(
        routes: {
          '*': (context, state, data) {
            final String currentPath = state.uri.path.replaceFirst('/', '');
            final cleanPath = currentPath.isEmpty
                ? 'getting-started/installation'
                : currentPath;

            final localController = ItemScrollController();
            final localListener = ItemPositionsListener.create();

            final bundle = ControllerBundle(
              scrollController: localController,
              positionsListener: localListener,
              onBlocksLoaded: (List<JsonContent> loadedBlocks) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (mounted) {
                    setState(() {
                      _currentActiveBlocks = loadedBlocks;
                      _sharedScrollController = localController;
                      _sharedPositionsListener = localListener;
                    });
                  }
                });
              },
            );

            return BeamPage(
              key: ValueKey('wiki_page_$cleanPath'),
              title: 'WayVes Wiki - $cleanPath',
              child: ScreenContents(
                screenRoute: cleanPath,
                key: ValueKey('viewport_$cleanPath'),
                controllerBundle: bundle,
              ),
            );
          },
        },
      ).call,
    );
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    beamerDelegate.addListener(
      () => setState(() {
        pathSegments = beamerDelegate.configuration.uri.pathSegments;
      }),
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLargeScreen = MediaQuery.of(context).size.width > 930;

    return Scaffold(
      drawer: !isLargeScreen
          ? LeftSideDrawer(showBackButton: true, beamerKey: BeamerKey.beamerKey)
          : null,
      endDrawer: !isLargeScreen
          ? (_sharedScrollController != null &&
                    _sharedPositionsListener != null)
                ? RightSideDrawer(
                    showBackButton: true,
                    wikiBlocks: _currentActiveBlocks,
                    scrollController: _sharedScrollController!,
                    positionsListener: _sharedPositionsListener!,
                  )
                : const SizedBox()
          : null,

      appBar: AppBar(
        elevation: 5,

        backgroundColor: Theme.of(context).brightness == Brightness.light
            ? Theme.of(context).colorScheme.inversePrimary
            : null,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: TextButton(
              style: TextButton.styleFrom(
                shape: const CircleBorder(),

                visualDensity: VisualDensity.compact,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              onPressed: () async {
                await launchUrl(Uri.parse('https://github.com/Roonil/WayVes'));
              },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                clipBehavior: Clip.antiAlias,
                child: SvgPicture.asset(
                  fit: BoxFit.scaleDown,
                  colorFilter: const ColorFilter.mode(
                    Colors.white,
                    BlendMode.srcATop,
                  ),
                  width: 40,

                  height: 40,
                  'images/github.svg',
                ),
              ),
            ),
          ),

          isLargeScreen
              ? const SizedBox()
              : Builder(
                  builder: (context) {
                    return TextButton(
                      style: TextButton.styleFrom(
                        visualDensity: const VisualDensity(
                          horizontal: -4.0,
                          vertical: -4.0,
                        ),
                      ),
                      onPressed: () => Scaffold.of(context).openEndDrawer(),
                      child: const Text("On this Page"),
                    );
                  },
                ),
        ],
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            isLargeScreen
                ? Flexible(
                    flex: 5,
                    child: Text(
                      "WayVes",
                      style: GoogleFonts.audiowideTextTheme(
                        Theme.of(context).textTheme,
                      ).headlineMedium,
                    ),
                  )
                : const SizedBox(),
            isLargeScreen
                ? Expanded(
                    flex: 10,
                    child: CustomSearchBar(
                      theme: Theme.of(context),
                      isLargeScreen: isLargeScreen,
                    ),
                  )
                : const SizedBox(),
            const Spacer(flex: 1),
          ],
        ),

        actionsPadding: isLargeScreen
            ? const EdgeInsets.only(right: 12)
            : EdgeInsets.zero,
      ),

      body: SelectionArea(
        key: ValueKey(pathSegments.toString()),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,

          children: [
            isLargeScreen
                ? Flexible(
                    flex: 2,
                    child: LeftSideDrawer(
                      showBackButton: false,
                      beamerKey: BeamerKey.beamerKey,
                    ),
                  )
                : const SizedBox(),
            Expanded(
              flex: 7,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TopPathButtons(
                    pathSegments: pathSegments.isEmpty
                        ? beamerDelegate.configuration.uri.pathSegments
                        : pathSegments,
                  ),
                  Expanded(
                    child: Beamer(
                      key: BeamerKey.beamerKey,
                      routerDelegate: beamerDelegate,
                    ),
                  ),
                ],
              ),
            ),
            isLargeScreen
                ? Flexible(
                    flex: 2,
                    child:
                        (_sharedScrollController != null &&
                            _sharedPositionsListener != null)
                        ? RightSideDrawer(
                            showBackButton: false,
                            wikiBlocks: _currentActiveBlocks,
                            scrollController: _sharedScrollController!,
                            positionsListener: _sharedPositionsListener!,
                          )
                        : const SizedBox(),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
