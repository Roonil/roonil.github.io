import 'package:flutter/material.dart';

class HelperFunctions {
  static TextSpan getRichTextFromTicks({
    required String text,
    TextStyle? style,
  }) {
    int index = 0;
    List<InlineSpan>? children = [];

    for (String splitText in text.split('`')) {
      children.add(
        (index++).isOdd
            ? WidgetSpan(
                child: Card.outlined(
                  elevation: 1,
                  margin: const EdgeInsets.symmetric(vertical: 2),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: Text(splitText, style: style),
                  ),
                ),

                alignment: PlaceholderAlignment.middle,
              )
            : TextSpan(text: splitText, style: style),
      );
    }
    return TextSpan(text: "", style: style, children: [...children]);
  }
}
