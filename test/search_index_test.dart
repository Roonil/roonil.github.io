import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:wayves_wiki/models/content_target.dart';
import 'package:wayves_wiki/models/json_content.dart';
import 'package:wayves_wiki/models/page_outline.dart';
import 'package:wayves_wiki/models/search_entry.dart';

String _searchableTextOf(JsonContent content) => switch (content) {
  TableJsonContent() => content.jsonRows.map((row) => row.join(' ')).join(' '),
  CodeSnippetJsonContent() => content.codeSnippet,
  ImageCarouselJsonContent() =>
    content.images.map((image) => image.altText).join(' '),
  _ => plainTextOf(content),
}.replaceAll('`', '').replaceAll(RegExp(r'\s+'), ' ').toLowerCase();

void main() {
  final List<SearchIndexPage> searchIndex =
      (jsonDecode(File('jsons/search_index.json').readAsStringSync()) as List)
          .map((page) => SearchIndexPage.fromJson(page))
          .toList();

  for (SearchIndexPage page in searchIndex) {
    test('every match on ${page.route} resolves to a block containing it', () {
      final List<JsonContent> blocks =
          (jsonDecode(File('jsons${page.route}.json').readAsStringSync())
                  as List)
              .map(
                (block) => JsonContent.fromJson(
                  block,
                  const TextTheme(),
                  const ColorScheme.dark(),
                  null,
                  0,
                ),
              )
              .toList();
      final PageOutline outline = PageOutline.fromBlocks(blocks);

      expect(
        outline.tableOfContents.map((entry) => entry.anchor),
        page.sections.map((s) => s.anchor).whereType<String>(),
      );

      for (SearchIndexSection section in page.sections) {
        final Set<String> queries = section.searchableText
            .split(' ')
            .where((word) => word.length >= 3)
            .toSet();

        for (String query in queries) {
          int occurrence = 0;
          for (
            int index = section.searchableText.indexOf(query);
            index != -1;
            index = section.searchableText.indexOf(query, index + query.length)
          ) {
            final ContentLocation location = outline.locate(
              ContentTarget(
                anchor: section.anchor,
                matchText: query,
                occurrence: occurrence++,
              ),
            );
            expect(
              location.content == null
                  ? ''
                  : _searchableTextOf(location.content!),
              contains(query),
              reason: '"$query" #$occurrence in ${section.anchor}',
            );
          }
        }

        for (SearchIndexTerm term in section.terms) {
          final ContentLocation location = outline.locate(
            ContentTarget(
              anchor: section.anchor,
              matchText: term.keyword.replaceAll('`', ''),
              isTermMatch: true,
            ),
          );
          expect(
            location.content,
            isA<TableJsonContent>(),
            reason: 'term ${term.keyword} in ${section.anchor}',
          );
        }
      }
    });
  }
}
