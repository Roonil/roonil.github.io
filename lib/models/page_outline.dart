import 'package:wayves_wiki/models/content_target.dart';
import 'package:wayves_wiki/models/json_content.dart';

class TocEntry {
  final String anchor;
  final String title;
  final int level;
  final int blockIndex;
  final JsonContent content;

  const TocEntry({
    required this.anchor,
    required this.title,
    required this.level,
    required this.blockIndex,
    required this.content,
  });
}

class _SearchableBlock {
  final int blockIndex;
  final JsonContent target;
  final List<String> segments;
  final List<String>? rowKeys;
  final bool isMergeable;

  _SearchableBlock({
    required this.blockIndex,
    required this.target,
    required this.segments,
    this.rowKeys,
    this.isMergeable = false,
  });

  String get text => _normalise(segments.join(' '));

  double fractionOfSegment(int segmentIndex) => rowKeys != null
      ? (segmentIndex + 1) / (segments.length + 1)
      : segmentIndex / segments.length;
}

class ContentLocation {
  final int blockIndex;
  final JsonContent? content;

  final double fraction;

  const ContentLocation({
    required this.blockIndex,
    this.content,
    this.fraction = 0,
  });
}

String _normalise(String text) => text
    .replaceAll('`', '')
    .replaceAll(RegExp(r'\s+'), ' ')
    .trim()
    .toLowerCase();

int _countOccurrences(String text, String pattern) {
  int count = 0;
  for (
    int index = text.indexOf(pattern);
    index != -1;
    index = text.indexOf(pattern, index + pattern.length)
  ) {
    count++;
  }
  return count;
}

String plainTextOf(JsonContent content) => switch (content) {
  TextJsonContent() => content.content,
  InlineCodeBlockJsonContent() => content.children.map(plainTextOf).join(),
  LinkJsonContent() => content.content.map(plainTextOf).join(),
  ParagraphJsonContent() => content.children.map(plainTextOf).join(),
  ExpansionTileJsonContent() => content.title.map(plainTextOf).join(' '),
  ListItemJsonContent() => content.children.map(plainTextOf).join(' '),
  AdmonitionJsonContent() => content.children.map(plainTextOf).join(' '),
  _ => '',
};

class PageOutline {
  final List<TocEntry> tableOfContents = [];
  final Map<String, List<_SearchableBlock>> _sectionBlocks = {};
  String _currentSection = '';

  PageOutline.fromBlocks(List<JsonContent> blocks) {
    for (final (blockIndex, block) in blocks.indexed) {
      _visit(block, blockIndex, null, 0);
    }
  }

  void _addEntry(
    String anchor,
    JsonContent content,
    int blockIndex,
    int level,
  ) => tableOfContents.add(
    TocEntry(
      anchor: anchor,
      title: plainTextOf(content)
          .replaceAll('`', '')
          .replaceAll(':', '')
          .replaceAll(RegExp(r'\s+'), ' ')
          .trim(),
      level: level,
      blockIndex: blockIndex,
      content: content,
    ),
  );

  void _addBlock(_SearchableBlock block) {
    final List<_SearchableBlock> sectionBlocks = _sectionBlocks.putIfAbsent(
      _currentSection,
      () => [],
    );

    if (block.isMergeable &&
        sectionBlocks.isNotEmpty &&
        sectionBlocks.last.isMergeable &&
        sectionBlocks.last.target == block.target) {
      sectionBlocks.last.segments.addAll(block.segments);
      return;
    }
    sectionBlocks.add(block);
  }

  void _visit(
    JsonContent content,
    int blockIndex,
    JsonContent? anchorTarget,
    int tileDepth,
  ) {
    switch (content) {
      case ParagraphJsonContent(anchor: final String anchor):
        _addEntry(
          anchor,
          content,
          blockIndex,
          tileDepth > 0 ? tileDepth : (content.headingNumber > 1 ? 1 : 0),
        );
        _currentSection = anchor;

      case ParagraphJsonContent():
        _addBlock(
          _SearchableBlock(
            blockIndex: blockIndex,
            target: content,
            segments: [plainTextOf(content)],
          ),
        );

      case ExpansionTileJsonContent():
        final String parentSection = _currentSection;
        if (content.anchor != null) {
          _addEntry(content.anchor!, content, blockIndex, tileDepth);
          _currentSection = content.anchor!;
        }
        for (JsonContent child in content.children) {
          _visit(child, blockIndex, content, tileDepth + 1);
        }
        _currentSection = parentSection;

      case TableJsonContent():
        _addBlock(
          _SearchableBlock(
            blockIndex: blockIndex,
            target: content,
            segments: content.jsonRows.map((row) => row.join(' ')).toList(),
            rowKeys: content.jsonRows
                .map((row) => row.isEmpty ? '' : _normalise(row.first))
                .toList(),
          ),
        );

      case CodeSnippetJsonContent():
        _addBlock(
          _SearchableBlock(
            blockIndex: blockIndex,
            target: content,
            segments: content.codeSnippet.split('\n'),
          ),
        );

      case ImageCarouselJsonContent():
        _addBlock(
          _SearchableBlock(
            blockIndex: blockIndex,
            target: content,
            segments: [content.images.map((image) => image.altText).join(' ')],
          ),
        );

      case MarkdownListJsonContent():
        for (JsonContent item in content.items) {
          _visit(item, blockIndex, anchorTarget, tileDepth);
        }

      case ListItemJsonContent():
        for (JsonContent child in content.children) {
          _visit(child, blockIndex, content, tileDepth);
        }

      case AdmonitionJsonContent():
        for (JsonContent child in content.children) {
          _visit(child, blockIndex, content, tileDepth);
        }

      case TextJsonContent() ||
          InlineCodeBlockJsonContent() ||
          LinkJsonContent():
        _addBlock(
          _SearchableBlock(
            blockIndex: blockIndex,
            target: anchorTarget ?? content,
            segments: [plainTextOf(content)],
            isMergeable: true,
          ),
        );

      default:
        break;
    }
  }

  ContentLocation? _locateMatch(ContentTarget target) {
    final List<_SearchableBlock> blocks =
        _sectionBlocks[target.anchor ?? ''] ?? [];
    final String matchText = _normalise(target.matchText ?? '');
    if (matchText.isEmpty) return null;

    if (target.isTermMatch) {
      for (_SearchableBlock block in blocks) {
        final int rowIndex = block.rowKeys?.indexOf(matchText) ?? -1;
        if (rowIndex != -1) {
          return ContentLocation(
            blockIndex: block.blockIndex,
            content: block.target,
            fraction: block.fractionOfSegment(rowIndex),
          );
        }
      }
      return null;
    }

    int remaining = target.occurrence;
    for (_SearchableBlock block in blocks) {
      final int blockCount = _countOccurrences(block.text, matchText);
      if (remaining >= blockCount) {
        remaining -= blockCount;
        continue;
      }

      for (final (segmentIndex, segment) in block.segments.indexed) {
        final int segmentCount = _countOccurrences(
          _normalise(segment),
          matchText,
        );
        if (remaining < segmentCount) {
          return ContentLocation(
            blockIndex: block.blockIndex,
            content: block.target,
            fraction: block.fractionOfSegment(segmentIndex),
          );
        }
        remaining -= segmentCount;
      }

      return ContentLocation(
        blockIndex: block.blockIndex,
        content: block.target,
      );
    }
    return null;
  }

  ContentLocation locate(ContentTarget target) {
    final ContentLocation? match = _locateMatch(target);
    if (match != null) return match;

    for (TocEntry entry in tableOfContents) {
      if (entry.anchor == target.anchor) {
        return ContentLocation(
          blockIndex: entry.blockIndex,
          content: entry.content,
        );
      }
    }
    return const ContentLocation(blockIndex: 0);
  }
}
