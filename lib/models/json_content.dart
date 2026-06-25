import 'dart:async';

import 'package:flutter/material.dart';
import 'package:numerus/numerus.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wayves_wiki/constants/custom_divs.dart';
import 'package:wayves_wiki/helper_functions/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/beamer_key.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/images_viewer.dart';
import 'package:wayves_wiki/widgets/table_viewer.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';

enum MarkdownBlockTypes {
  paragraph('paragraph'),
  text('text'),
  link('link'),
  inlineCodeBlock('inlineCodeBlock'),
  heading('heading'),
  information('info'),
  div('div'),
  warning('warning'),
  codeSnippet('codeSnippet'),
  expansionTile('expansionTile'),
  table('table'),
  horizontalDivider('horizontalDivider'),
  image('image'),
  markdownList('markdownList'),
  listItem('listItem'),
  footer('footer'),
  imageCarousel('imageCarousel'),
  unknown('unknown');

  final String typeKey;
  const MarkdownBlockTypes(this.typeKey);

  factory MarkdownBlockTypes.fromString(String? key) {
    return MarkdownBlockTypes.values.firstWhere(
      (element) => element.typeKey == key,
      orElse: () => MarkdownBlockTypes.unknown,
    );
  }
}

final List<String> unorderedListItemShapes = ["•", "-", "o"];

abstract class JsonContent {
  final MarkdownBlockTypes blockType;
  final TextStyle? textStyle;
  final int depth;

  JsonContent({
    required this.blockType,
    required this.textStyle,
    required this.depth,
  });

  InlineSpan get rendererWidget;

  factory JsonContent.fromJson(
    Map<String, dynamic> jsonString,
    TextTheme textTheme,
    ColorScheme colorScheme,

    TextStyle? textStyle,
    int depth, {
    int index = -1,
    int headingDepth = 0,
  }) {
    final List<JsonContent> children = [];
    final MarkdownBlockTypes blockType = MarkdownBlockTypes.fromString(
      jsonString['type'],
    );

    switch (blockType) {
      case MarkdownBlockTypes.text:
        return TextJsonContent(
          content: jsonString['content'],
          depth: depth,
          textStyle: textStyle,
          textTheme: textTheme,
          colorScheme: colorScheme,
        );
      case MarkdownBlockTypes.link:
        return LinkJsonContent(
          textStyle: textStyle,
          depth: depth,
          content: (jsonString['content'] as List<dynamic>)
              .map(
                (e) => JsonContent.fromJson(
                  e,
                  textTheme,
                  colorScheme,
                  textStyle?.copyWith(color: colorScheme.primary),
                  depth,
                ),
              )
              .toList(),
          link: jsonString['altText'],
        );

      case MarkdownBlockTypes.footer:
        return FooterJsonContent(
          previous: jsonString['previous'] == null
              ? null
              : FooterLinkJsonContent.fromJson(
                  jsonString['previous'],
                  true,
                  textTheme.titleLarge,
                  depth,
                ),
          next: jsonString['next'] == null
              ? null
              : FooterLinkJsonContent.fromJson(
                  jsonString['next'],
                  false,
                  textTheme.titleLarge,
                  depth,
                ),
          textStyle: textStyle,
          depth: depth,
        );
      case MarkdownBlockTypes.inlineCodeBlock:
        return InlineCodeBlockJsonContent(
          children: (jsonString['children'] as List<dynamic>)
              .map(
                (e) => JsonContent.fromJson(
                  e,
                  textTheme,
                  colorScheme,
                  (jsonString['depth'] == 1
                          ? textTheme.displaySmall
                          : jsonString['depth'] == 2
                          ? textTheme.titleLarge
                          : textTheme.titleMedium)
                      ?.copyWith(
                        color: textStyle?.color,
                        fontWeight: FontWeight.w400,
                      ),
                  depth,
                ),
              )
              .toList(),
          depth: depth,
        );

      case MarkdownBlockTypes.paragraph:
        return ParagraphJsonContent(
          children: (jsonString['children'] as List<dynamic>)
              .map(
                (e) => JsonContent.fromJson(
                  e,
                  textTheme,
                  colorScheme,
                  jsonString['depth'] == 1
                      ? textTheme.displaySmall
                      : jsonString['depth'] == 2
                      ? textTheme.headlineSmall
                      : textStyle,
                  depth,
                ),
              )
              .toList(),
          textStyle: textStyle,
          depth: depth,

          headingNumber: jsonString['depth'] ?? headingDepth,
        );

      case MarkdownBlockTypes.div:
        return DivJsonContent(
          className: jsonString['className'] ?? "",
          depth: depth,
          colorScheme: colorScheme,
          textStyle: textStyle,
        );

      case MarkdownBlockTypes.information:
      case MarkdownBlockTypes.warning:
        for (var blockVar in jsonString['children']) {
          Map<String, dynamic> currentBlock = blockVar as Map<String, dynamic>;
          children.add(
            JsonContent.fromJson(
              currentBlock,
              textTheme,
              colorScheme,
              textTheme.bodyLarge?.copyWith(
                color: blockType == MarkdownBlockTypes.information
                    ? colorScheme.primary
                    : colorScheme.onTertiaryContainer,
              ),
              depth,
            ),
          );
        }

        return AdmonitionJsonContent(
          blockType: blockType,
          children: children,
          depth: depth,
        );

      case MarkdownBlockTypes.codeSnippet:
        return CodeSnippetJsonContent(
          blockType: blockType,
          codeSnippet: jsonString['content'],
          snippetLanguage: jsonString['language'],
          depth: depth,
        );
      case MarkdownBlockTypes.expansionTile:
        return ExpansionTileJsonContent(
          title: (jsonString['title'] as List<dynamic>)
              .map(
                (dynamic child) => JsonContent.fromJson(
                  child,
                  textTheme,
                  colorScheme,
                  (depth == 0
                          ? textTheme.displaySmall
                          : textTheme.headlineSmall)
                      ?.copyWith(fontWeight: FontWeight.w500),
                  depth,
                  headingDepth: headingDepth,
                ),
              )
              .toList(),
          subtitle: (jsonString['subtitle'] as List<dynamic>)
              .map(
                (dynamic child) => JsonContent.fromJson(
                  child,
                  textTheme,
                  colorScheme,
                  textStyle,
                  depth,
                  headingDepth: headingDepth + 2,
                ),
              )
              .toList(),
          depth: depth,
          children: (jsonString['children'] as List)
              .map(
                (dynamic child) => JsonContent.fromJson(
                  child,
                  textTheme,
                  colorScheme,
                  textStyle,
                  depth,
                  headingDepth: headingDepth + 1,
                ),
              )
              .toList(),
          blockType: blockType,
        );
      case MarkdownBlockTypes.table:
        return TableJsonContent(
          depth: depth,
          headers: ((jsonString['headers'] ?? []) as List<dynamic>)
              .cast<String>(),
          jsonRows: ((jsonString['rows'] ?? []) as List<dynamic>)
              .map(
                (dynamic innerRow) =>
                    List<String>.from(innerRow as List<dynamic>),
              )
              .toList(),
        );
      case MarkdownBlockTypes.image:
        return ImageJsonContent(
          altText: jsonString['altText'],
          animatedUrl: jsonString['animatedUrl'].toString().replaceFirst(
            '/assets/',
            '',
          ),
          staticUrl: jsonString['staticUrl'].toString().replaceFirst(
            '/assets/',
            '',
          ),
          depth: depth,
        );
      case MarkdownBlockTypes.imageCarousel:
        return ImageCarouselJsonContent(
          depth: depth,
          images: (jsonString['children'] as List<dynamic>)
              .map(
                (dynamic imageJsonString) => JsonContent.fromJson(
                  imageJsonString,
                  textTheme,
                  colorScheme,
                  textStyle,
                  depth,
                ),
              )
              .toList()
              .cast<ImageJsonContent>(),
        );
      case MarkdownBlockTypes.horizontalDivider:
        return HorizontalDividerJsonContent(textStyle: textStyle, depth: depth);
      case MarkdownBlockTypes.heading:
        return ParagraphJsonContent(
          children: (jsonString['children'] as List<dynamic>)
              .map(
                (e) => JsonContent.fromJson(
                  e,
                  textTheme,
                  colorScheme,
                  jsonString['depth'] == 1
                      ? textTheme.displaySmall
                      : jsonString['depth'] == 2
                      ? textTheme.titleLarge
                      : textStyle,
                  depth,
                ),
              )
              .toList(),

          headingNumber: jsonString['depth'],
          depth: depth,
          textStyle: jsonString['depth'] == 1
              ? textTheme.displaySmall
              : jsonString['depth'] == 2
              ? textTheme.titleLarge
              : textTheme.titleMedium,
        );

      case MarkdownBlockTypes.markdownList:
        return MarkdownListJsonContent(
          blockType: blockType,
          textStyle: textStyle,
          depth: depth,
          isOrdered: jsonString['ordered'],
          items: (jsonString['children'] as List<dynamic>).indexed
              .map(
                (e) => JsonContent.fromJson(
                  e.$2,
                  textTheme,
                  colorScheme,
                  textStyle,
                  depth + 1,
                  index: jsonString['ordered'] ? e.$1 : -1,
                ),
              )
              .toList(),
        );

      case MarkdownBlockTypes.listItem:
        return ListItemJsonContent(
          blockType: blockType,
          textStyle: textStyle,
          depth: depth,
          listIndex: index,
          children: (jsonString['children'] as List<dynamic>)
              .map(
                (e) => JsonContent.fromJson(
                  e,
                  textTheme,
                  colorScheme,
                  textStyle,
                  depth,
                ),
              )
              .toList(),
        );

      case MarkdownBlockTypes.unknown:
        return PlaceHolderJsonContent();
    }
  }
}

class DivJsonContent extends JsonContent {
  final String className;
  final ColorScheme colorScheme;

  DivJsonContent({
    required super.textStyle,
    required super.depth,
    required this.className,
    required this.colorScheme,
  }) : super(blockType: MarkdownBlockTypes.div);

  @override
  InlineSpan get rendererWidget => WidgetSpan(
    child: CustomDivs.getCustomWidgetFromClassName(className, colorScheme),
  );
}

class ImageJsonContent extends JsonContent {
  final String altText, staticUrl, animatedUrl;
  double _staticWidth = -1, _staticHeight = -1;
  double _animatedWidth = -1, _animatedHeight = -1;

  Future<Size> getImageAssetSize(String assetPath) {
    Completer<Size> completer = Completer();

    AssetImage assetImage = AssetImage(assetPath);

    assetImage
        .resolve(const ImageConfiguration())
        .addListener(
          ImageStreamListener(
            (ImageInfo imageInfo, bool synchronousCall) {
              double width = imageInfo.image.width.toDouble();
              double height = imageInfo.image.height.toDouble();

              if (!completer.isCompleted) {
                completer.complete(Size(width, height));
              }
            },
            onError: (dynamic exception, StackTrace? stackTrace) {
              completer.completeError(exception, stackTrace);
            },
          ),
        );

    return completer.future;
  }

  Future<List<double>> _loadImageSize(bool isStatic) async {
    double width, height;

    width = isStatic ? _staticWidth : _animatedWidth;
    height = isStatic ? _staticHeight : _animatedHeight;

    if (width > 0) return [width, height];

    try {
      Size size = await getImageAssetSize(isStatic ? staticUrl : animatedUrl);

      width = size.width;
      height = size.height;
    } catch (e) {
      width = 1;
      height = 1;
    }

    if (isStatic) {
      _staticWidth = width;
      _staticHeight = height;
    } else {
      _animatedWidth = width;
      _animatedHeight = height;
    }

    return [width, height];
  }

  Future<List<double>> getStaticDimensions() async {
    return _loadImageSize(true);
  }

  Future<List<double>> getAnimatedDimensions() async {
    return _loadImageSize(false);
  }

  ImageJsonContent({
    super.textStyle,
    required this.altText,
    required this.staticUrl,
    required this.animatedUrl,
    required super.depth,
  }) : super(blockType: MarkdownBlockTypes.image);

  @override
  WidgetSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: const SizedBox(),
  );
}

class MarkdownListJsonContent extends JsonContent {
  final List<JsonContent> items;
  final bool isOrdered;
  MarkdownListJsonContent({
    required super.blockType,
    required super.textStyle,
    required super.depth,
    required this.items,
    required this.isOrdered,
  });

  String getOrderedIndex(int position, int depthResolution) {
    switch (depthResolution) {
      case 1:
        return position.toString();

      case 2:
        return String.fromCharCode(97 + (position % 26));

      case 3:
        return (position.toRomanNumeralString() ?? "i").toLowerCase();
      default:
        return getOrderedIndex(position, (depthResolution % 3) + 1);
    }
  }

  @override
  WidgetSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: ListView.separated(
        separatorBuilder: (context, index) => Padding(
          padding: EdgeInsetsGeometry.only(
            top: 6,
            bottom: 6,
            left: depth * (12),
          ),
        ),
        itemCount: items.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Text.rich(
          softWrap: true,

          WidgetSpan(
            alignment: PlaceholderAlignment.middle,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                items[index] is ListItemJsonContent
                    ? Padding(
                        padding: EdgeInsets.only(
                          top:
                              ((items[index] as ListItemJsonContent).children[0]
                                  is ParagraphJsonContent)
                              ? 12
                              : ((items[index] as ListItemJsonContent)
                                        .children[0]
                                    is ExpansionTileJsonContent)
                              ? 18
                              : 4,
                          left: depth * (8),
                          right: 4,
                        ),
                        child: Text(
                          (items[index] as ListItemJsonContent).listIndex == -1
                              ? ("${unorderedListItemShapes[(depth) % unorderedListItemShapes.length]} ")
                              : "${getOrderedIndex((items[index] as ListItemJsonContent).listIndex + 1, depth + 1)}. ",
                          textAlign: TextAlign.center,
                        ),
                      )
                    : const SizedBox(),
                Expanded(child: Text.rich(items[index].rendererWidget)),
              ],
            ),
          ),
        ),
        shrinkWrap: true,
      ),
    ),
  );
}

class ListItemJsonContent extends JsonContent {
  final List<JsonContent> children;
  final int listIndex;

  ListItemJsonContent({
    required super.blockType,
    required super.textStyle,
    required super.depth,
    required this.children,
    required this.listIndex,
  });

  String getOrderedIndex(int position, int depthResolution) {
    switch (depthResolution) {
      case 1:
        return position.toString();

      case 2:
        return String.fromCharCode(97 + (position % 26));

      case 3:
        return (position.toRomanNumeralString() ?? "i").toLowerCase();
      default:
        return getOrderedIndex(position, (depthResolution % 3) + 1);
    }
  }

  @override
  WidgetSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Padding(
      padding: EdgeInsets.only(left: 0 * 8),
      child: Text.rich(
        TextSpan(
          children: [
            TextSpan(children: [children.first.rendererWidget]),

            ...children.skip(1).map((e) => (e.rendererWidget)),
          ],
        ),
      ),
    ),
  );
}

class ImageCarouselJsonContent extends JsonContent {
  final List<ImageJsonContent> images;

  ImageCarouselJsonContent({
    super.textStyle,
    required this.images,
    required super.depth,
  }) : super(blockType: MarkdownBlockTypes.imageCarousel);

  @override
  WidgetSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Padding(
      padding: const EdgeInsets.only(top: 12.0),
      child: ImagesViewer(viewerImages: images, height: 380),
    ),
  );
}

class HorizontalDividerJsonContent extends JsonContent {
  HorizontalDividerJsonContent({required super.textStyle, required super.depth})
    : super(blockType: MarkdownBlockTypes.horizontalDivider);

  @override
  WidgetSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: const Divider(),
    ),
  );
}

class TableJsonContent extends JsonContent {
  final List<String> headers;
  final List<List<String>> jsonRows;

  TableJsonContent({
    required this.headers,
    required this.jsonRows,
    required super.depth,
    super.textStyle,
  }) : super(blockType: MarkdownBlockTypes.table);

  @override
  WidgetSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TableViewer(
        tableHeader: CustomTableRow.fromJson(headers),
        tableRows: jsonRows
            .map((List<String> jsonRow) => CustomTableRow.fromJson(jsonRow))
            .toList(),
      ),
    ),
  );
}

class PlaceHolderJsonContent extends JsonContent {
  PlaceHolderJsonContent()
    : super(blockType: MarkdownBlockTypes.unknown, depth: 0, textStyle: null);

  @override
  WidgetSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: const SizedBox(),
  );
}

class TextJsonContent extends JsonContent {
  final String content;
  final TextTheme textTheme;
  final ColorScheme colorScheme;
  TextJsonContent({
    required this.content,
    required this.textTheme,
    required this.colorScheme,
    super.textStyle,
    required super.depth,
  }) : super(blockType: MarkdownBlockTypes.text);

  @override
  TextSpan get rendererWidget => HelperFunctions.getRichTextFromTicks(
    text: content,
    style:
        textStyle?.copyWith(fontWeight: FontWeight.w400) ??
        textTheme.bodyLarge?.copyWith(
          color: colorScheme.primary,
          fontWeight: FontWeight.w400,
        ),
  );
}

class LinkJsonContent extends JsonContent {
  final String link;
  final List<JsonContent> content;
  LinkJsonContent({
    required super.textStyle,
    required super.depth,
    required this.content,
    required this.link,
  }) : super(blockType: MarkdownBlockTypes.link);
  @override
  InlineSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: TextButton(
      onPressed: () async {
        await launchUrl(Uri.parse(link));
      },
      child: Text.rich(
        TextSpan(
          style: textStyle,
          children: content.map((e) => e.rendererWidget).toList(),
        ),
      ),
    ),
  );
}

class FooterLinkJsonContent extends JsonContent {
  final String pathName, route;
  bool isPrevious;
  factory FooterLinkJsonContent.fromJson(
    Map<String, dynamic> jsonString,
    bool isPrevious,
    TextStyle? textStyle,
    int depth,
  ) {
    return FooterLinkJsonContent(
      pathName: jsonString['pathName'],
      route: jsonString['route'],
      isPrevious: isPrevious,
      textStyle: textStyle,
      depth: depth,
    );
  }

  FooterLinkJsonContent({
    required this.pathName,
    required this.route,
    required this.isPrevious,
    required super.textStyle,
    required super.depth,
  }) : super(blockType: MarkdownBlockTypes.footer);

  @override
  InlineSpan get rendererWidget => WidgetSpan(
    child: TextButton.icon(
      iconAlignment: isPrevious ? IconAlignment.start : IconAlignment.end,
      icon: Icon(
        isPrevious
            ? Icons.keyboard_arrow_left_rounded
            : Icons.keyboard_arrow_right_rounded,
        size: 30,
      ),
      onPressed: () =>
          BeamerKey.beamerKey.currentState?.routerDelegate.beamToNamed(route),
      label: Text(pathName, style: textStyle),
    ),
  );
}

class FooterJsonContent extends JsonContent {
  FooterLinkJsonContent? previous, next;
  FooterJsonContent({
    required this.previous,
    required this.next,
    required super.textStyle,
    required super.depth,
  }) : super(blockType: MarkdownBlockTypes.footer);

  @override
  InlineSpan get rendererWidget => WidgetSpan(
    child: Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(top: 16.0, bottom: 20),
          child: Divider(),
        ),

        Padding(
          padding: const EdgeInsets.only(bottom: 36),
          child: Row(
            mainAxisSize: MainAxisSize.max,

            children: [
              Expanded(
                child: Wrap(
                  alignment: WrapAlignment.spaceBetween,
                  runAlignment: WrapAlignment.spaceBetween,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  runSpacing: 12,
                  direction: Axis.horizontal,
                  children: [
                    Text.rich(
                      TextSpan(
                        children: [previous?.rendererWidget ?? TextSpan()],
                      ),
                    ),

                    Text.rich(
                      TextSpan(children: [next?.rendererWidget ?? TextSpan()]),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

class InlineCodeBlockJsonContent extends JsonContent {
  final List<JsonContent> children;

  InlineCodeBlockJsonContent({
    required this.children,
    super.textStyle,
    required super.depth,
  }) : super(blockType: MarkdownBlockTypes.inlineCodeBlock);

  @override
  WidgetSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: Card.outlined(
      elevation: 1,
      margin: EdgeInsets.symmetric(vertical: 2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Text.rich(
          TextSpan(
            style: textStyle?.copyWith(fontWeight: FontWeight.w400),
            children: children.map((e) => (e.rendererWidget)).toList(),
          ),
        ),
      ),
    ),
  );
}

class ParagraphJsonContent extends JsonContent {
  final int headingNumber;
  final List<JsonContent> children;

  ParagraphJsonContent({
    required this.children,
    this.headingNumber = 0,
    super.textStyle,
    required super.depth,
  }) : super(blockType: MarkdownBlockTypes.paragraph);

  @override
  WidgetSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,

    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Text.rich(
        TextSpan(children: children.map((e) => (e.rendererWidget)).toList()),
      ),
    ),
  );
}

class AdmonitionJsonContent extends JsonContent {
  final List<JsonContent> children;

  AdmonitionJsonContent({
    required super.blockType,
    super.textStyle,
    required super.depth,
    required this.children,
  });

  @override
  WidgetSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: InfoCard(
      formattedTextWidget: Text.rich(
        TextSpan(
          children: children
              .map((JsonContent jsonContent) => (jsonContent.rendererWidget))
              .toList(),
        ),
      ),
      isWarning: blockType == MarkdownBlockTypes.warning,
    ),
  );
}

class CodeSnippetJsonContent extends JsonContent {
  final String codeSnippet;
  final String? snippetLanguage;

  CodeSnippetJsonContent({
    required super.blockType,
    super.textStyle,
    required super.depth,
    required this.codeSnippet,
    this.snippetLanguage,
  });

  @override
  WidgetSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,

    child: CodeSnippetCard(textString: codeSnippet, language: snippetLanguage),
  );
}

class ExpansionTileJsonContent extends JsonContent {
  final List<JsonContent> title;
  final List<JsonContent>? subtitle;
  final GlobalKey? key;
  final List<JsonContent> children;
  ExpansionTileJsonContent({
    this.key,
    required super.blockType,
    super.textStyle,
    required this.title,
    required super.depth,
    this.subtitle,
    required this.children,
  });

  List<InlineSpan> get subtitleWidgetSpan =>
      subtitle?.map((e) => (e.rendererWidget)).toList() ?? [];

  @override
  WidgetSpan get rendererWidget => WidgetSpan(
    alignment: PlaceholderAlignment.middle,
    child: RoundedExpansionTile(
      key: key,
      titleString: "",
      titleWidget: Text.rich(
        TextSpan(children: title.map((e) => (e.rendererWidget)).toList()),
      ),
      subtitleWidget: subtitleWidgetSpan.isEmpty
          ? null
          : Text.rich(TextSpan(children: subtitleWidgetSpan)),
      children: children.map((e) => Text.rich(e.rendererWidget)).toList(),
    ),
  );
}
