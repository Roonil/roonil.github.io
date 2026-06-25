import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wayves_wiki/models/json_content.dart';

class RightSideDrawer extends StatefulWidget {
  final List<JsonContent> wikiBlocks;
  final ItemScrollController scrollController;
  final ItemPositionsListener positionsListener;
  final bool showBackButton;

  const RightSideDrawer({
    super.key,
    required this.wikiBlocks,
    required this.scrollController,
    required this.positionsListener,
    required this.showBackButton,
  });

  @override
  State<RightSideDrawer> createState() => _RightSideDrawerState();
}

class _RightSideDrawerState extends State<RightSideDrawer> {
  int? _activeBlockIndex;

  void _syncActiveIndexFromScroll() {
    try {
      final positions = widget.positionsListener.itemPositions.value;
      if (positions.isEmpty) return;

      final visibleItems = positions
          .where((ItemPosition pos) => pos.itemTrailingEdge > 0)
          .toList();
      if (visibleItems.isEmpty) return;

      visibleItems.sort(
        (a, b) => a.itemLeadingEdge.abs().compareTo(b.itemLeadingEdge.abs()),
      );
      final int topVisibleItemIndex = visibleItems.first.index;

      int? detectedSectionIndex;
      for (int i = topVisibleItemIndex; i >= 0; i--) {
        if (i >= widget.wikiBlocks.length) continue;

        final block = widget.wikiBlocks[i];
        if ((block is ParagraphJsonContent && block.headingNumber != 0) ||
            block is ExpansionTileJsonContent) {
          detectedSectionIndex = i;
          break;
        }
      }

      if (detectedSectionIndex != null &&
          detectedSectionIndex != _activeBlockIndex) {
        if (!mounted) {
          _activeBlockIndex = detectedSectionIndex;
        } else {
          setState(() {
            _activeBlockIndex = detectedSectionIndex;
          });
        }
      }
    } catch (_) {}
  }

  @override
  void initState() {
    super.initState();

    widget.positionsListener.itemPositions.addListener(
      _onScrollPositionsChanged,
    );

    _syncActiveIndexFromScroll();
  }

  @override
  void didUpdateWidget(covariant RightSideDrawer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.positionsListener != widget.positionsListener) {
      oldWidget.positionsListener.itemPositions.removeListener(
        _onScrollPositionsChanged,
      );
      widget.positionsListener.itemPositions.addListener(
        _onScrollPositionsChanged,
      );
    }
  }

  void _onScrollPositionsChanged() {
    if (!mounted) return;

    _syncActiveIndexFromScroll();
  }

  void _scrollToIndex(int targetIndex) {
    widget.scrollController.scrollTo(
      index: targetIndex,
      duration: const Duration(milliseconds: 350),
      curve: Curves.fastOutSlowIn,
      alignment: 0.0,
    );
  }

  @override
  void dispose() {
    widget.positionsListener.itemPositions.removeListener(
      _onScrollPositionsChanged,
    );
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
              itemCount: widget.wikiBlocks.length,
              itemBuilder: (context, index) {
                final block = widget.wikiBlocks[index];
                final bool isActive = _activeBlockIndex == index;

                String textContent = '';
                bool isSubSection = false;

                if (block is ParagraphJsonContent && block.headingNumber != 0) {
                  textContent =
                      ((block.children.firstWhere(
                                (element) => element is TextJsonContent,
                                orElse: () => TextJsonContent(
                                  content: '',
                                  textTheme: TextTheme(),
                                  colorScheme: Theme.of(context).colorScheme,
                                  depth: 0,
                                ),
                              ))
                              as TextJsonContent)
                          .content;
                  isSubSection = block.headingNumber > 1;
                } else if (block is ExpansionTileJsonContent) {
                  textContent = (block.title.first is TextJsonContent)
                      ? ((block.title.first as TextJsonContent).content)
                      : (((block.title.firstWhere(
                                          (element) =>
                                              (element is ParagraphJsonContent),
                                          orElse: () => ParagraphJsonContent(
                                            children: [
                                              TextJsonContent(
                                                content: '',
                                                textTheme: TextTheme(),
                                                colorScheme: Theme.of(
                                                  context,
                                                ).colorScheme,
                                                depth: 0,
                                              ),
                                            ],
                                            depth: 0,
                                          ),
                                        ))
                                        as ParagraphJsonContent)
                                    .children
                                    .firstWhere(
                                      (element) => element is TextJsonContent,
                                    )
                                as TextJsonContent)
                            .content;

                  ((block.title[0] is ParagraphJsonContent)
                      ? ((block.title[0] as ParagraphJsonContent).children[0]
                                as TextJsonContent)
                            .content
                      : (block.title[0] as TextJsonContent).content);
                } else {
                  return const SizedBox.shrink();
                }

                final cleanDisplayTitle = textContent
                    .replaceAll('`', '')
                    .replaceAll(':', "");

                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 3.0),
                  child: InkWell(
                    onTap: () {
                      _scrollToIndex(index);
                      if (widget.showBackButton) Navigator.of(context).pop();
                    },
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(20),
                      right: Radius.zero,
                    ),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: EdgeInsets.only(
                        left: isSubSection ? 20.0 : 10.0,
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
                        cleanDisplayTitle,
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
