import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wayves_wiki/models/content_target.dart';
import 'package:wayves_wiki/models/json_content.dart';
import 'package:wayves_wiki/models/controller_bundle.dart';
import 'package:wayves_wiki/models/page_outline.dart';
import 'package:wayves_wiki/widgets/content_anchor.dart';

class ScreenContents extends StatefulWidget {
  final String screenRoute;
  final ControllerBundle controllerBundle;

  const ScreenContents({
    super.key,
    required this.screenRoute,
    required this.controllerBundle,
  });

  @override
  State<ScreenContents> createState() => _ScreenContentsState();
}

class _ScreenContentsState extends State<ScreenContents> {
  late Future<List<JsonContent>> _jsonAssetFuture;
  PageOutline? _pageOutline;

  @override
  void initState() {
    super.initState();
    _jsonAssetFuture = _fetchAndParseJson(widget.screenRoute);
    PendingContentTarget.request.addListener(_scrollToPendingTarget);
  }

  @override
  void dispose() {
    PendingContentTarget.request.removeListener(_scrollToPendingTarget);
    super.dispose();
  }

  void _scrollToPendingTarget() {
    final (String, ContentTarget)? request = PendingContentTarget.request.value;
    final PageOutline? pageOutline = _pageOutline;
    if (request == null ||
        pageOutline == null ||
        request.$1 != '/${widget.screenRoute}') {
      return;
    }

    PendingContentTarget.request.value = null;
    widget.controllerBundle.scrollToLocation(
      pageOutline.locate(request.$2),
      highlight: request.$2.matchText != null,
    );
  }

  @override
  void didUpdateWidget(covariant ScreenContents oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.screenRoute != widget.screenRoute) {
      _jsonAssetFuture = _fetchAndParseJson(widget.screenRoute);
    }
  }

  Future<List<JsonContent>> _fetchAndParseJson(String routePath) async {
    final String rawJsonString = await rootBundle.loadString(
      'jsons/$routePath.json',
    );
    final List<dynamic> blocksJson = jsonDecode(rawJsonString);

    final blocks = blocksJson.map((block) {
      return JsonContent.fromJson(
        block as Map<String, dynamic>,

        GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        Theme.of(context).colorScheme,
        GoogleFonts.montserratTextTheme(Theme.of(context).textTheme).bodyLarge,
        0,
      );
    }).toList();

    widget.controllerBundle.onBlocksLoaded(blocks);

    _pageOutline = PageOutline.fromBlocks(blocks);
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => mounted ? _scrollToPendingTarget() : null,
    );

    return blocks;
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = widget.controllerBundle.scrollController;
    final positionsListener = widget.controllerBundle.positionsListener;

    return FutureBuilder<List<JsonContent>>(
      future: _jsonAssetFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('404: Content Missing: ${widget.screenRoute}'),
          );
        }

        final List<JsonContent> wikiBlocks = snapshot.data ?? [];

        return AnchorScope(
          registry: widget.controllerBundle.anchorRegistry,
          child: KeyedSubtree(
            key: widget.controllerBundle.anchorRegistry.viewportKey,
            child: ScrollablePositionedList.builder(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              itemCount: wikiBlocks.length,
              itemScrollController: scrollController,
              scrollOffsetController:
                  widget.controllerBundle.scrollOffsetController,
              itemPositionsListener: positionsListener,
              itemBuilder: (context, index) {
                return Text.rich(wikiBlocks[index].rendererWidget);
              },
            ),
          ),
        );
      },
    );
  }
}
