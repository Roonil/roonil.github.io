import 'dart:convert';

import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/markdown_helpers/json_content.dart';

class AstJsonParser extends StatelessWidget {
  final String jsonString;
  const AstJsonParser({super.key, required this.jsonString});

  List<JsonContent> jsonParser(
    Map<String, GlobalKey<State<StatefulWidget>>> heading,
    TextTheme textTheme,
    ColorScheme colorScheme,
  ) {
    final List<dynamic> blocksJSONList = jsonDecode(jsonString);
    final List<JsonContent> jsonContents = [];
    for (var blockVar in blocksJSONList) {
      final Map<String, dynamic> currentBlock =
          blockVar as Map<String, dynamic>;

      jsonContents.add(
        JsonContent.fromJson(
          currentBlock,
          heading,
          textTheme,
          colorScheme,
          textTheme.titleMedium,
          0,
        ),
      );
    }

    return jsonContents;
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, GlobalKey<State<StatefulWidget>>>? heading =
        headings[Beamer.of(context).configuration.uri.path];

    final widgets = jsonParser(
      heading!,
      GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
      Theme.of(context).colorScheme,
    ).map((JsonContent jsonContent) => jsonContent.rendererWidget).toList();

    return ListView.builder(
      itemBuilder: (context, index) => Text.rich(widgets[index]),
      itemCount: widgets.length,
      shrinkWrap: true,
    );
  }
}
