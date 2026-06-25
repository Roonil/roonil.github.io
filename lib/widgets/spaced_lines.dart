import 'package:flutter/material.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';

class SpacedLines extends StatelessWidget {
  final String text;
  final TextStyle? style;
  const SpacedLines({super.key, required this.text, this.style});

  List<String> get splitText => text.split('\n');

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemBuilder: (context, index) =>
          RichTextFromTicks(text: splitText[index], style: style),
      separatorBuilder: (context, index) =>
          Padding(padding: const EdgeInsets.symmetric(vertical: 8.0)),
      itemCount: splitText.length,
      shrinkWrap: true,
    );
  }
}
