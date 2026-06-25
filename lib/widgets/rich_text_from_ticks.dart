import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RichTextFromTicks extends StatelessWidget {
  final String text;
  final TextStyle? style;
  final List<InlineSpan>? endSpan;
  const RichTextFromTicks({
    super.key,
    required this.text,
    this.style,
    this.endSpan,
  });

  @override
  Widget build(BuildContext context) {
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
                    child: Text(
                      splitText,
                      style: GoogleFonts.firaCode(
                        textStyle:
                            style ??
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                              color: Theme.of(context).colorScheme.primary,
                            ),
                      ),
                    ),
                  ),
                ),
                alignment: PlaceholderAlignment.middle,
              )
            : TextSpan(text: splitText),
      );
    }
    return Text.rich(
      style: style ?? Theme.of(context).textTheme.titleMedium,
      TextSpan(text: "", children: [...children, ...(endSpan ?? [])]),
    );
  }
}
