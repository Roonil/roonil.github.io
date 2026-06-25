import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';

import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';

class FunctionDescriber extends StatelessWidget {
  final int index;
  final List<String> functions, functionsDescriptions, sampleCodes;
  const FunctionDescriber({
    super.key,
    required this.index,
    required this.functions,
    required this.functionsDescriptions,
    required this.sampleCodes,
  });

  @override
  Widget build(BuildContext context) {
    final Map<String, GlobalKey<State<StatefulWidget>>>? heading =
        headings[Beamer.of(context).configuration.uri.path];

    return RoundedExpansionTile(
      key: heading![functions[index]],
      titleString: functions[index],
      textStyle: Theme.of(context).textTheme.headlineSmall,
      subtitleString: functionsDescriptions[index],
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
          child: CodeSnippetCard(textString: sampleCodes[index]),
        ),
      ],
    );
  }
}
