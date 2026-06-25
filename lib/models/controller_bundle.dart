import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:wayves_wiki/models/json_content.dart';

class ControllerBundle {
  final ItemScrollController scrollController;
  final ItemPositionsListener positionsListener;
  final Function(List<JsonContent> loadedBlocks) onBlocksLoaded;

  const ControllerBundle({
    required this.scrollController,
    required this.positionsListener,
    required this.onBlocksLoaded,
  });
}
