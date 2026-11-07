import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wayves_wiki/models/controller_bundle.dart';
import 'package:wayves_wiki/models/json_content.dart';
import 'package:wayves_wiki/models/page_outline.dart';

class RightSideDrawer extends StatefulWidget {
  final List<JsonContent> wikiBlocks;
  final ControllerBundle controllerBundle;
  final bool showBackButton;

  const RightSideDrawer({
    super.key,
    required this.wikiBlocks,
    required this.controllerBundle,
    required this.showBackButton,
  });

  @override
  State<RightSideDrawer> createState() => _RightSideDrawerState();
}

class _RightSideDrawerState extends State<RightSideDrawer> {
  static const double _activeHeadingThreshold = 48;

  late List<TocEntry> _tableOfContents;
  TocEntry? _activeEntry;

  bool _isScrollingToEntry = false;

  ItemPositionsListener get _positionsListener =>
      widget.controllerBundle.positionsListener;

  void _syncActiveIndexFromScroll() {
    try {
      final positions = _positionsListener.itemPositions.value;
      if (positions.isEmpty || _tableOfContents.isEmpty) return;

      final int firstVisibleIndex = positions
          .where((ItemPosition pos) => pos.itemTrailingEdge > 0)
          .fold(
            widget.wikiBlocks.length,
            (int minimum, ItemPosition pos) =>
                pos.index < minimum ? pos.index : minimum,
          );

      TocEntry detectedEntry = _tableOfContents.first;
      for (TocEntry entry in _tableOfContents) {
        final Rect? bounds = widget.controllerBundle.anchorRegistry
            .boundsInViewport(entry.content);
        final bool isPassed = bounds != null
            ? bounds.top <= _activeHeadingThreshold
            : entry.blockIndex < firstVisibleIndex;
        if (isPassed) detectedEntry = entry;
      }

      if (detectedEntry != _activeEntry) {
        if (!mounted) {
          _activeEntry = detectedEntry;
        } else {
          setState(() {
            _activeEntry = detectedEntry;
          });
        }
      }
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();
    _tableOfContents = PageOutline.fromBlocks(
      widget.wikiBlocks,
    ).tableOfContents;

    _positionsListener.itemPositions.addListener(_onScrollPositionsChanged);

    _resetActiveEntry();
  }

  void _resetActiveEntry() {
    _activeEntry = _tableOfContents.firstOrNull;
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => _onScrollPositionsChanged(),
    );
  }

  Future<void> _scrollToEntry(TocEntry entry) async {
    setState(() {
      _activeEntry = entry;
      _isScrollingToEntry = true;
    });

    await widget.controllerBundle.scrollToLocation(
      ContentLocation(blockIndex: entry.blockIndex, content: entry.content),
    );
    await WidgetsBinding.instance.endOfFrame;
    _isScrollingToEntry = false;
  }

  @override
  void didUpdateWidget(covariant RightSideDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.wikiBlocks != widget.wikiBlocks) {
      _tableOfContents = PageOutline.fromBlocks(
        widget.wikiBlocks,
      ).tableOfContents;
      _isScrollingToEntry = false;
      _resetActiveEntry();
    }
    if (oldWidget.controllerBundle.positionsListener != _positionsListener) {
      oldWidget.controllerBundle.positionsListener.itemPositions.removeListener(
        _onScrollPositionsChanged,
      );
      _positionsListener.itemPositions.addListener(_onScrollPositionsChanged);
    }
  }

  void _onScrollPositionsChanged() {
    if (!mounted || _isScrollingToEntry) return;

    _syncActiveIndexFromScroll();
  }

  @override
  void dispose() {
    _positionsListener.itemPositions.removeListener(_onScrollPositionsChanged);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: widget.showBackButton ? 5 : 0,
        backgroundColor: widget.showBackButton
            ? Theme.of(context).brightness == Brightness.light
                  ? Theme.of(context).colorScheme.inversePrimary
                  : null
            : Colors.transparent,
        titleSpacing: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Flexible(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 8,
                ),
                child: Text(
                  'On This Page',
                  style:
                      GoogleFonts.audiowideTextTheme(
                        Theme.of(context).textTheme,
                      ).headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.onSurfaceVariant,
                        letterSpacing: 0.5,
                      ),
                ),
              ),
            ),
            widget.showBackButton
                ? IconButton(
                    onPressed: Scaffold.of(context).closeEndDrawer,
                    icon: const Icon(Icons.arrow_forward),
                  )
                : const SizedBox(),
          ],
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(height: 1),

          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12.0,
              ),
              itemCount: _tableOfContents.length,
              itemBuilder: (context, index) {
                final TocEntry entry = _tableOfContents[index];
                final bool isActive = _activeEntry == entry;

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: InkWell(
                    onTap: () {
                      _scrollToEntry(entry);
                      if (widget.showBackButton) Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20),
                      right: Radius.zero,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.only(
                        left: 10.0 + 10.0 * entry.level,
                        right: 10.0,
                        top: 10.0,
                        bottom: 10.0,
                      ),
                      decoration: BoxDecoration(
                        color: isActive
                            ? theme.colorScheme.primaryContainer.withAlpha(64)
                            : Colors.transparent,
                        borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(20),
                          right: Radius.zero,
                        ),
                        border: Border(
                          left: BorderSide(
                            width: 2,
                            color: isActive
                                ? theme.colorScheme.primary
                                : Colors.transparent,
                          ),
                          right: BorderSide(
                            width: 1,
                            color: isActive
                                ? theme.colorScheme.primary
                                : Colors.transparent,
                          ),
                        ),
                      ),
                      child: Text(
                        entry.title,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: isActive
                              ? FontWeight.bold
                              : FontWeight.normal,
                          color: isActive
                              ? theme.colorScheme.primary
                              : theme.colorScheme.onSurface,
                          height: 1.3,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
