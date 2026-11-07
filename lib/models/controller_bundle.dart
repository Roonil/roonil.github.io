import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wayves_wiki/models/json_content.dart';
import 'package:wayves_wiki/models/page_outline.dart';
import 'package:wayves_wiki/widgets/content_anchor.dart';

class ControllerBundle {
  final ItemScrollController scrollController;
  final ScrollOffsetController scrollOffsetController;
  final ItemPositionsListener positionsListener;
  final AnchorRegistry anchorRegistry;
  final Function(List<JsonContent> loadedBlocks) onBlocksLoaded;

  const ControllerBundle({
    required this.scrollController,
    required this.scrollOffsetController,
    required this.positionsListener,
    required this.anchorRegistry,
    required this.onBlocksLoaded,
  });

  Future<void> scrollToLocation(
    ContentLocation location, {
    bool highlight = false,
  }) async {
    if (!scrollController.isAttached) return;

    await scrollController.scrollTo(
      index: location.blockIndex,
      duration: const Duration(milliseconds: 350),
      curve: Curves.fastOutSlowIn,
      alignment: 0.0,
    );

    final JsonContent? content = location.content;
    if (content == null) return;

    await WidgetsBinding.instance.endOfFrame;
    final Rect? bounds = anchorRegistry.boundsInViewport(content);
    if (bounds == null) return;

    final double offset =
        bounds.top +
        bounds.height * location.fraction -
        (location.fraction > 0 ? anchorRegistry.viewportHeight * 0.3 : 0);

    if (offset.abs() > 1 && scrollController.isAttached) {
      await scrollOffsetController.animateScroll(
        offset: offset,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    }

    if (highlight) anchorRegistry.stateFor(content)?.highlight();
  }
}
