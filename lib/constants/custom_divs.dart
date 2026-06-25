import 'package:flutter/material.dart';

class CustomDivs {
  static Widget getCustomWidgetFromClassName(
    String className,
    ColorScheme colorScheme,
  ) {
    if (className == "creating-your-own-shaders") {
      return Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 8.0),
                child: Icon(Icons.folder),
              ),
              Text("Shader Name"),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalDivider(
                    thickness: 0.5,

                    color: colorScheme.onPrimaryContainer,
                    width: 0.5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0, left: 12),
                    child: Icon(Icons.folder),
                  ),
                  const Text("vertex"),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalDivider(
                    thickness: 0.5,

                    color: colorScheme.onPrimaryContainer,
                    width: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: VerticalDivider(
                      thickness: 0.5,

                      color: colorScheme.onPrimaryContainer,
                      width: 0.5,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 4.0, left: 12),
                    child: Icon(Icons.file_present_outlined),
                  ),
                  const Text("1.vert"),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalDivider(
                    thickness: 0.5,

                    color: colorScheme.onPrimaryContainer,
                    width: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: VerticalDivider(
                      thickness: 0.5,

                      color: colorScheme.onPrimaryContainer,
                      width: 0.5,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 4.0, left: 12),
                    child: Icon(Icons.file_present_outlined),
                  ),
                  const Text("2.vert"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalDivider(
                    thickness: 0.5,

                    color: colorScheme.onPrimaryContainer,
                    width: 0.5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Icon(Icons.more_vert_rounded),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalDivider(
                    thickness: 0.5,

                    color: colorScheme.onPrimaryContainer,
                    width: 0.5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 8.0, left: 12),
                    child: Icon(Icons.folder),
                  ),
                  const Text("fragment"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalDivider(
                    thickness: 0.5,

                    color: colorScheme.onPrimaryContainer,
                    width: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: VerticalDivider(
                      thickness: 0.5,

                      color: colorScheme.onPrimaryContainer,
                      width: 0.5,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 4.0, left: 12),
                    child: Icon(Icons.file_present_outlined),
                  ),
                  const Text("1.frag"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalDivider(
                    thickness: 0.5,

                    color: colorScheme.onPrimaryContainer,
                    width: 0.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 24.0),
                    child: VerticalDivider(
                      thickness: 0.5,

                      color: colorScheme.onPrimaryContainer,
                      width: 0.5,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.only(right: 4.0, left: 12),
                    child: Icon(Icons.file_present_outlined),
                  ),
                  const Text("2.frag"),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12.0),
            child: IntrinsicHeight(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  VerticalDivider(
                    thickness: 0.5,

                    color: colorScheme.onPrimaryContainer,
                    width: 0.5,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 12.0),
                    child: Icon(Icons.more_vert_rounded),
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    }

    if (className == "objects-stack") {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 12.0),
        child: GroupsHierarchy(),
      );
    }

    return const SizedBox();
  }
}

class GroupsHierarchy extends StatelessWidget {
  const GroupsHierarchy({super.key});

  @override
  Widget build(BuildContext context) {
    final divider = VerticalDivider(
      width: 0.5,
      thickness: 0.5,
      color: Theme.of(context).colorScheme.onPrimaryContainer,
    );
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Only for Angular             ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.5),
                child: divider,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Inner Circle",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Outer Circle",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Bar Group                         ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 23.0),
                child: divider,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Bar Background",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Inner Bar",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Outer Bar",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Top Cap",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Bottom Cap",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Upper Particle Group     ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: divider,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Inner Particle",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Outer Particle",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Left Inner Connector",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Right Inner Connector",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Left Outer Connector",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Right Outer Connector",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Cap",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 20),

        IntrinsicHeight(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,

            children: [
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Lower Particle Group     ",
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22.5),
                child: divider,
              ),
              Flexible(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Inner Particle",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Outer Particle",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Left Inner Connector",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Right Inner Connector",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Left Outer Connector",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Text(
                      "Right Outer Connector",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      "Cap",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
