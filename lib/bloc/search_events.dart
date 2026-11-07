import 'package:flutter/foundation.dart' show immutable;

@immutable
abstract class SearchEvent {
  const SearchEvent();
}

@immutable
class InitiateSearchEvent implements SearchEvent {
  final String searchString;

  const InitiateSearchEvent({required this.searchString});
}
