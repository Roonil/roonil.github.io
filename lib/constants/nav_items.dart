import 'package:wayves_wiki/models/nav_item.dart';

final NavItem rootNavItem = NavItem(
  title: "Index",
  children: [
    NavItem(
      title: "Getting Started",
      children: [
        NavItem(title: "Installation", route: '/getting-started/installation'),
        NavItem(title: "Usage", route: '/getting-started/usage'),
      ],
    ),

    NavItem(
      title: "Introduction",
      children: [
        NavItem(title: "Overview", route: '/introduction/overview'),
        NavItem(title: "Data Types", route: '/introduction/data-types'),
        NavItem(title: "GLSL Functions", route: '/introduction/glsl-functions'),
      ],
    ),

    NavItem(
      title: "Shaders",
      children: [
        NavItem(title: "Overview", route: '/shaders/overview'),
        NavItem(
          title: "Chain",
          children: [
            NavItem(title: "Overview", route: '/shaders/chain/overview'),
            NavItem(
              title: "Configuration",
              route: '/shaders/chain/configuration',
            ),
            NavItem(title: "Life Cycle", route: '/shaders/chain/life-cycle'),
            NavItem(title: "Examples", route: '/shaders/chain/examples'),
          ],
        ),

        NavItem(
          title: "Linear",

          children: [
            NavItem(title: "Overview", route: '/shaders/linear/overview'),
            NavItem(
              title: "Configuration",
              route: '/shaders/linear/configuration',
            ),
            NavItem(title: "Life Cycle", route: '/shaders/linear/life-cycle'),
            NavItem(title: "Examples", route: '/shaders/linear/examples'),
          ],
        ),

        NavItem(
          title: "Angular",

          children: [
            NavItem(title: "Overview", route: '/shaders/angular/overview'),
            NavItem(
              title: "Configuration",
              route: '/shaders/angular/configuration',
            ),
            NavItem(title: "Life Cycle", route: '/shaders/angular/life-cycle'),
            NavItem(title: "Examples", route: '/shaders/angular/examples'),
          ],
        ),

        NavItem(
          title: "NCS",
          children: [
            NavItem(title: 'Overview', route: '/shaders/ncs/overview'),
            NavItem(
              title: 'Configuration',
              route: '/shaders/ncs/configuration',
            ),
            NavItem(title: 'Life Cycle', route: '/shaders/ncs/life-cycle'),
            NavItem(title: 'Examples', route: '/shaders/ncs/examples'),
          ],
        ),

        NavItem(
          title: "Advanced",
          children: [
            NavItem(
              title: "Post-Processing",
              route: '/shaders/advanced/post-processing',
            ),
            NavItem(title: "Colors", route: '/shaders/advanced/colors'),
            NavItem(title: "Extras", route: '/shaders/advanced/extras'),

            NavItem(title: "Z Orders", route: '/shaders/advanced/z-orders'),
            NavItem(
              title: "Special Directives",
              route: '/shaders/advanced/special-directives',
            ),

            NavItem(
              title: "Creating your own Shaders",
              route: '/shaders/advanced/creating-your-own-shaders',
            ),
          ],
        ),
      ],
    ),

    NavItem(
      title: "Main Configuration",
      children: [
        NavItem(
          title: "YAML Specification",
          route: '/main-configuration/yaml-specification',
        ),
        NavItem(title: "Styling", route: '/main-configuration/styling'),
      ],
    ),
    NavItem(
      title: "Updating Properties",
      children: [
        NavItem(
          title: "Piping Data",
          route: '/updating-properties/piping-data',
        ),
        NavItem(
          title: "CLI Arguments",
          route: '/updating-properties/cli-arguments',
        ),
      ],
    ),

    NavItem(
      title: "Recommendations",
      children: [
        NavItem(title: "Tips", route: '/recommendations/tips'),
        NavItem(title: "Performance", route: '/recommendations/performance'),
      ],
    ),
  ],
);
