import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wayves_wiki/models/json_content.dart';

class AnchorRegistry {
  final GlobalKey viewportKey = GlobalKey();

  final Map<JsonContent, List<ContentAnchorState>> _anchorStates = {};

  void _register(JsonContent content, ContentAnchorState state) =>
      _anchorStates.putIfAbsent(content, () => []).add(state);

  void _unregister(JsonContent content, ContentAnchorState state) {
    _anchorStates[content]?.remove(state);
    if (_anchorStates[content]?.isEmpty ?? false) _anchorStates.remove(content);
  }

  ContentAnchorState? stateFor(JsonContent content) =>
      _anchorStates[content]?.lastWhere(
        (state) => state.mounted,
        orElse: () => _anchorStates[content]!.last,
      );

  RenderBox? get _viewportBox {
    final RenderObject? viewport = viewportKey.currentContext
        ?.findRenderObject();
    return viewport is RenderBox && viewport.attached ? viewport : null;
  }

  double get viewportHeight => _viewportBox?.size.height ?? 0;

  Rect? boundsInViewport(JsonContent content) {
    final ContentAnchorState? state = stateFor(content);
    final RenderBox? viewport = _viewportBox;
    if (state == null || !state.mounted || viewport == null) return null;

    final RenderObject? box = state.context.findRenderObject();
    if (box is! RenderBox || !box.attached || !box.hasSize) return null;

    return box.localToGlobal(Offset.zero, ancestor: viewport) & box.size;
  }
}

class AnchorScope extends InheritedWidget {
  final AnchorRegistry registry;

  const AnchorScope({super.key, required this.registry, required super.child});

  static AnchorRegistry? maybeOf(BuildContext context) =>
      context.getInheritedWidgetOfExactType<AnchorScope>()?.registry;

  @override
  bool updateShouldNotify(AnchorScope oldWidget) =>
      registry != oldWidget.registry;
}

class ContentAnchor extends StatefulWidget {
  final JsonContent content;
  final Widget child;

  const ContentAnchor({super.key, required this.content, required this.child});

  @override
  State<ContentAnchor> createState() => ContentAnchorState();
}

class ContentAnchorState extends State<ContentAnchor> {
  AnchorRegistry? _registry;
  bool _isHighlighted = false;
  Timer? _highlightTimer;

  void highlight() {
    _highlightTimer?.cancel();
    setState(() => _isHighlighted = true);
    _highlightTimer = Timer(const Duration(milliseconds: 1400), () {
      if (mounted) setState(() => _isHighlighted = false);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final AnchorRegistry? registry = AnchorScope.maybeOf(context);
    if (registry == _registry) return;

    _registry?._unregister(widget.content, this);
    _registry = registry?.._register(widget.content, this);
  }

  @override
  void didUpdateWidget(covariant ContentAnchor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.content != widget.content) {
      _registry?._unregister(oldWidget.content, this);
      _registry?._register(widget.content, this);
    }
  }

  @override
  void dispose() {
    _highlightTimer?.cancel();
    _registry?._unregister(widget.content, this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: _isHighlighted
            ? Theme.of(context).colorScheme.primary.withAlpha(40)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: widget.child,
    );
  }
}
