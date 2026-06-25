class SearchHit {
  final String keyword;
  final String snippet;
  final String heading;

  SearchHit({
    required this.keyword,
    required this.snippet,
    required this.heading,
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
