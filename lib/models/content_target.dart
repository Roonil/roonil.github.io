import 'package:flutter/foundation.dart';

@immutable
class ContentTarget {
  final String? anchor;
  final String? matchText;
  final int occurrence;
  final bool isTermMatch;

  const ContentTarget({
    this.anchor,
    this.matchText,
    this.occurrence = 0,
    this.isTermMatch = false,
  });
}

class PendingContentTarget {
  static final ValueNotifier<(String route, ContentTarget target)?> request =
      ValueNotifier(null);
}
