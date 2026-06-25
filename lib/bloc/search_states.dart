import 'package:flutter/foundation.dart' show immutable;
import 'package:wayves_wiki/models/search_entry.dart';

@immutable
abstract class SearchState {
  final bool isLoading;
  final Exception? error;
  final String searchString;
  const SearchState({
    required this.isLoading,
    required this.error,
    required this.searchString,
  });
}

@immutable
class InitialState extends SearchState {
  const InitialState({
    required super.isLoading,
    required super.error,
    required super.searchString,
  });
}

@immutable
class SearchingState extends SearchState {
  const SearchingState({
    required super.isLoading,
    required super.error,
    required super.searchString,
  });
}

@immutable
class SearchFailedState extends SearchState {
  const SearchFailedState({
    required super.isLoading,
    required super.error,
    required super.searchString,
  });
}

@immutable
class FetchedSearchResultsState extends SearchState {
  final List<SearchEntry> searchEntries;

  const FetchedSearchResultsState({
    required super.isLoading,
    required super.error,
    required this.searchEntries,
    required super.searchString,
  });
}
