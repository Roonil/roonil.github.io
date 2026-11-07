import 'package:wayves_wiki/models/content_target.dart';

class SearchHit {
  final String keyword;
  final String snippet;
  final String heading;
  final ContentTarget target;

  SearchHit({
    required this.keyword,
    required this.snippet,
    required this.heading,
    required this.target,
  });
}

class SearchEntry {
  final String route;
  final String pageTitle;

  final List<SearchHit> searchHits;

  SearchEntry({
    required this.route,
    required this.pageTitle,
    required this.searchHits,
  });
}

class SearchIndexTerm {
  final String keyword;
  final String snippet;

  SearchIndexTerm({required this.keyword, required this.snippet});

  factory SearchIndexTerm.fromJson(Map<String, dynamic> json) =>
      SearchIndexTerm(keyword: json['keyword'], snippet: json['snippet']);
}

class SearchIndexSection {
  final String? anchor;
  final String heading;
  final String summary;
  final String text;
  final List<SearchIndexTerm> terms;

  final String searchableText;
  final List<int> _textPositions;

  SearchIndexSection._({
    required this.anchor,
    required this.heading,
    required this.summary,
    required this.text,
    required this.terms,
    required this.searchableText,
    required List<int> textPositions,
  }) : _textPositions = textPositions;

  factory SearchIndexSection.fromJson(Map<String, dynamic> json) {
    final String text = json['text'] ?? "";
    final StringBuffer searchableText = StringBuffer();
    final List<int> textPositions = [];

    for (int i = 0; i < text.length; i++) {
      if (text[i] == '`') continue;
      searchableText.write(text[i].toLowerCase());
      textPositions.add(i);
    }
    textPositions.add(text.length);

    return SearchIndexSection._(
      anchor: json['anchor'],
      heading: json['heading'],
      summary: json['summary'] ?? "",
      text: text,
      terms: ((json['terms'] ?? []) as List<dynamic>)
          .map((term) => SearchIndexTerm.fromJson(term))
          .toList(),
      searchableText: searchableText.toString(),
      textPositions: textPositions,
    );
  }

  int textPositionOf(int searchableIndex) => _textPositions[searchableIndex];
}

class SearchIndexPage {
  final String route;
  final String pageTitle;
  final List<SearchIndexSection> sections;

  SearchIndexPage({
    required this.route,
    required this.pageTitle,
    required this.sections,
  });

  factory SearchIndexPage.fromJson(Map<String, dynamic> json) =>
      SearchIndexPage(
        route: json['route'],
        pageTitle: json['pageTitle'],
        sections: (json['sections'] as List<dynamic>)
            .map((section) => SearchIndexSection.fromJson(section))
            .toList(),
      );
}
