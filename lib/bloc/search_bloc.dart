import 'dart:async';
import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:wayves_wiki/bloc/search_events.dart';
import 'package:wayves_wiki/bloc/search_states.dart';
import 'package:wayves_wiki/models/content_target.dart';
import 'package:wayves_wiki/models/search_entry.dart';

const int _excerptBefore = 60, _excerptAfter = 140;
const int _maxOccurrencesPerSection = 5;

int _keywordScore(String keyword, String searchText) {
  final String cleanKeyword = keyword.replaceAll('`', '').toLowerCase().trim();
  if (cleanKeyword == searchText) return 3;
  if (cleanKeyword.startsWith(searchText)) return 2;
  if (cleanKeyword.contains(searchText)) return 1;
  return -1;
}

String _excerpt(String text, int matchIndex, int matchLength) {
  int start = (matchIndex - _excerptBefore).clamp(0, text.length);
  int end = (matchIndex + matchLength + _excerptAfter).clamp(0, text.length);

  if (start > 0) {
    final int space = text.indexOf(' ', start);
    if (space != -1 && space < matchIndex) start = space + 1;
  }
  if (end < text.length) {
    final int space = text.lastIndexOf(' ', end);
    if (space > matchIndex + matchLength) end = space;
  }

  if ('`'.allMatches(text.substring(0, start)).length.isOdd) {
    start = text.lastIndexOf('`', start - 1);
  }
  if ('`'.allMatches(text.substring(0, end)).length.isOdd) {
    final int closingTick = text.indexOf('`', end);
    end = closingTick == -1 ? text.length : closingTick + 1;
  }

  return "${start > 0 ? '…' : ''}${text.substring(start, end).trim()}"
      "${end < text.length ? '…' : ''}";
}

SearchHit _sectionHit(SearchIndexSection section) => SearchHit(
  keyword: section.heading,
  heading: section.heading,
  snippet: section.summary,
  target: ContentTarget(anchor: section.anchor),
);

List<SearchEntry> parseSearches(
  (String searchText, List<SearchIndexPage> searchIndex) request,
) {
  final (searchText, searchIndex) = request;
  final List<(int, SearchEntry)> matchedSearchEntries = [];

  for (SearchIndexPage page in searchIndex) {
    if (searchText.isEmpty ||
        page.route.split('-').join(' ').toLowerCase().contains(searchText)) {
      matchedSearchEntries.add((
        0,
        SearchEntry(
          route: page.route,
          pageTitle: page.pageTitle,
          searchHits: page.sections
              .where((section) => section.anchor != null)
              .map(_sectionHit)
              .toList(),
        ),
      ));
      continue;
    }

    final List<(int, SearchHit)> scoredHits = [];

    for (SearchIndexSection section in page.sections) {
      final int hitCountBefore = scoredHits.length;

      final int headingScore = _keywordScore(section.heading, searchText);
      if (section.anchor != null && headingScore >= 0) {
        scoredHits.add((headingScore, _sectionHit(section)));
      }

      for (SearchIndexTerm term in section.terms) {
        final int termScore = _keywordScore(term.keyword, searchText);
        if (termScore >= 0) {
          scoredHits.add((
            termScore,
            SearchHit(
              keyword: term.keyword,
              heading: section.heading,
              snippet: term.snippet,
              target: ContentTarget(
                anchor: section.anchor,
                matchText: term.keyword.replaceAll('`', ''),
                isTermMatch: true,
              ),
            ),
          ));
        }
      }

      if (scoredHits.length > hitCountBefore &&
          scoredHits.last.$2.target.isTermMatch) {
        continue;
      }

      int occurrence = 0;
      int matchIndex = section.searchableText.indexOf(searchText);
      while (matchIndex != -1 && occurrence < _maxOccurrencesPerSection) {
        final int textStart = section.textPositionOf(matchIndex);
        final int textEnd =
            section.textPositionOf(matchIndex + searchText.length - 1) + 1;

        scoredHits.add((
          0,
          SearchHit(
            keyword: section.heading,
            heading: section.heading,
            snippet: _excerpt(section.text, textStart, textEnd - textStart),
            target: ContentTarget(
              anchor: section.anchor,
              matchText: searchText,
              occurrence: occurrence++,
            ),
          ),
        ));
        matchIndex = section.searchableText.indexOf(
          searchText,
          matchIndex + searchText.length,
        );
      }
    }

    if (scoredHits.isEmpty) continue;

    mergeSort(scoredHits, compare: (a, b) => b.$1.compareTo(a.$1));

    matchedSearchEntries.add((
      scoredHits.first.$1,
      SearchEntry(
        route: page.route,
        pageTitle: page.pageTitle,
        searchHits: scoredHits.map((scoredHit) => scoredHit.$2).toList(),
      ),
    ));
  }

  mergeSort(matchedSearchEntries, compare: (a, b) => b.$1.compareTo(a.$1));
  return matchedSearchEntries.map((scoredEntry) => scoredEntry.$2).toList();
}

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  Future<List<SearchIndexPage>>? _searchIndex;

  String _latestSearchString = "";

  SearchBloc()
    : super(
        const InitialState(isLoading: false, searchString: "", error: null),
      ) {
    on<InitiateSearchEvent>(_searchLists);
    add(const InitiateSearchEvent(searchString: ""));
  }

  Future<List<SearchIndexPage>> _loadSearchIndex() async {
    final List<dynamic> pagesJson = jsonDecode(
      await rootBundle.loadString('jsons/search_index.json'),
    );
    return pagesJson.map((page) => SearchIndexPage.fromJson(page)).toList();
  }

  FutureOr<void> _searchLists(
    InitiateSearchEvent event,
    Emitter<SearchState> emit,
  ) async {
    _latestSearchString = event.searchString;
    emit(
      SearchingState(
        isLoading: true,
        searchString: event.searchString,
        error: null,
      ),
    );

    try {
      final List<SearchEntry> searchEntries = await compute(parseSearches, (
        event.searchString.toLowerCase().trim(),
        await (_searchIndex ??= _loadSearchIndex()),
      ));

      await Future.delayed(const Duration(seconds: 0, microseconds: 200));
      if (event.searchString != _latestSearchString) return;

      emit(
        FetchedSearchResultsState(
          isLoading: false,
          error: null,
          searchString: event.searchString,
          searchEntries: searchEntries,
        ),
      );
    } catch (_) {
      _searchIndex = null;
      if (event.searchString != _latestSearchString) return;

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
