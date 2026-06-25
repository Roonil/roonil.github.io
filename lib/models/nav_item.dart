class NavItem {
  final String title;
  final String? route;
  final List<NavItem>? children;

  NavItem({required this.title, this.route, this.children});
}
