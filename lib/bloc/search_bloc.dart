import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:wayves_wiki/bloc/search_events.dart';
import 'package:wayves_wiki/bloc/search_states.dart';
import 'package:wayves_wiki/constants/search_entries.dart';
import 'package:wayves_wiki/models/search_entry.dart';

List<SearchEntry> parseSearches(String searchText) {
  List<SearchEntry> matchedSearchEntries = [];
  if (searchText.isEmpty) return searchEntries;

  for (SearchEntry searchEntry in searchEntries) {
    SearchEntry newSearchEntry = SearchEntry(
      route: searchEntry.route,
      pageTitle: searchEntry.pageTitle,
      searchHits: [],
    );

    if (newSearchEntry.route
        .split('-')
        .join(' ')
        .toLowerCase()
        .contains(searchText)) {
      matchedSearchEntries.add(searchEntry);
      continue;
    }

    for (SearchHit searchHit in searchEntry.searchHits) {
      if (searchHit.keyword.toLowerCase().contains(searchText) ||
          searchHit.snippet.toLowerCase().contains(searchText)) {
        newSearchEntry.searchHits.add(searchHit);
      }
    }

    if (newSearchEntry.searchHits.isNotEmpty) {
      matchedSearchEntries.add(newSearchEntry);
    }
  }
  return matchedSearchEntries;
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc()
    : super(
        const InitialState(isLoading: false, searchString: "", error: null),
      ) {
    on<InitiateSearchEvent>(_searchLists);
  }

  FutureOr<void> _searchLists(
    InitiateSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    emit(
      SearchingState(
        isLoading: true,
        searchString: event.searchString,
        error: null,
      ),
    );

    try {
      final List<SearchEntry> searchEntries = await compute(
        parseSearches,
        event.searchString.toLowerCase().trim(),
      );

      await Future.delayed(const Duration(seconds: 0, microseconds: 200)).then(
        (_) => emit(
          FetchedSearchResultsState(
            isLoading: false,
            error: null,
            searchString: event.searchString,
            searchEntries: searchEntries,
          ),
        ),
      );
    } catch (_) {
      emit(
        SearchFailedState(
          isLoading: false,
          searchString: event.searchString,
          error: Exception("An Error occured!"),
        ),
      );
    }
  }
}
