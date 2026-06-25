import 'package:flutter/foundation.dart' show immutable;
import 'package:flutter/material.dart';
import 'package:wayves_wiki/models/search_entry.dart';

@immutable
abstract class SearchEvent {
  const SearchEvent();
}

@immutable
class InitiateSearchEvent implements SearchEvent {
  final String searchString;
  final List<SearchEntry> currentSearchEntries;

  const InitiateSearchEvent({
    required this.searchString,
    required this.currentSearchEntries,
  });
}
