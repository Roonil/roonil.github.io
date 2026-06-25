import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:wayves_wiki/markdown_helpers/ast_json_parser.dart';

class MarkdownFileLoader extends StatelessWidget {
  final String fileName;
  const MarkdownFileLoader({super.key, required this.fileName});

  Future<String> _loadMarkdownFile() async {
    return await rootBundle.loadString('jsons$fileName.json');
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: _loadMarkdownFile(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error loading wiki: ${snapshot.error}'));
        }

        final jsonStringData = snapshot.data ?? 'No content found.';
        return AstJsonParser(jsonString: jsonStringData);
      },
    );
  }
}
