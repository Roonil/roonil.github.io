import 'package:flutter/material.dart';
import 'package:wayves_wiki/models/nav_item.dart';

class SlidableNavItem extends StatefulWidget {
  final List<NavItem> navItems;
  const SlidableNavItem({super.key, required this.navItems});

  @override
  State<SlidableNavItem> createState() => _SlidableNavItemState();
}

class _SlidableNavItemState extends State<SlidableNavItem>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: Offset.zero,
    end: const Offset(12, 0),
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticIn));

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SlideTransition(
      position: _offsetAnimation,
      child: Column(
        children: widget.navItems
            .map((NavItem navItem) => Text(navItem.title))
            .toList(),
      ),
    );
  }
}
