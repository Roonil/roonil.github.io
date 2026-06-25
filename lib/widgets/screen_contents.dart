import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_fonts/google_fonts.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wayves_wiki/models/json_content.dart';
import 'package:wayves_wiki/models/controller_bundle.dart';

class ScreenContents extends StatefulWidget {
  final String screenRoute;
  final ControllerBundle controllerBundle;

  const ScreenContents({
    super.key,
    required this.screenRoute,
    required this.controllerBundle,
  });

  @override
  State<ScreenContents> createState() => _ScreenContentsState();
}

class _ScreenContentsState extends State<ScreenContents> {
  late Future<List<JsonContent>> _jsonAssetFuture;

  @override
  void initState() {
    super.initState();
    _jsonAssetFuture = _fetchAndParseJson(widget.screenRoute);
  }

  @override
  void didUpdateWidget(covariant ScreenContents oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.screenRoute != widget.screenRoute) {
      _jsonAssetFuture = _fetchAndParseJson(widget.screenRoute);
    }
  }

  Future<List<JsonContent>> _fetchAndParseJson(String routePath) async {
    final String rawJsonString = await rootBundle.loadString(
      'jsons/$routePath.json',
    );
    final List<dynamic> blocksJson = jsonDecode(rawJsonString);

    final blocks = blocksJson.map((block) {
      return JsonContent.fromJson(
        block as Map<String, dynamic>,

        GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        Theme.of(context).colorScheme,
        GoogleFonts.montserratTextTheme(Theme.of(context).textTheme).bodyLarge,
        0,
      );
    }).toList();

    widget.controllerBundle.onBlocksLoaded(blocks);

    return blocks;
  }

  @override
  Widget build(BuildContext context) {
    final scrollController = widget.controllerBundle.scrollController;
    final positionsListener = widget.controllerBundle.positionsListener;

    return FutureBuilder<List<JsonContent>>(
      future: _jsonAssetFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(
            child: Text('404: Content Missing: ${widget.screenRoute}'),
          );
        }

        final List<JsonContent> wikiBlocks = snapshot.data ?? [];

        return ScrollablePositionedList.builder(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          itemCount: wikiBlocks.length,
          itemScrollController: scrollController,
          itemPositionsListener: positionsListener,
          itemBuilder: (context, index) {
            return Text.rich(wikiBlocks[index].rendererWidget);
          },
        );
      },
    );
  }
}
