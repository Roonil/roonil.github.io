import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/constants/uniforms.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/main_configuration/main_config_overview_screen.dart';
import 'package:wayves_wiki/screens/shaders/advanced/special_directives_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/types_list.dart';

class CreatingYourOwnShadersScreen extends StatefulWidget {
  const CreatingYourOwnShadersScreen({super.key});
  static const routeName = '/shaders/advanced/creating-your-own-shaders';

  @override
  State<CreatingYourOwnShadersScreen> createState() =>
      _CreatingYourOwnShadersScreenState();
}

class _CreatingYourOwnShadersScreenState
    extends State<CreatingYourOwnShadersScreen> {
  @override
  Widget build(BuildContext context) {
    final Map<String, GlobalKey<State<StatefulWidget>>>? heading =
        headings[Beamer.of(context).configuration.uri.path];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              key: heading!["Creating your own Shaders"],
              "Creating your own Shaders",

              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: RichTextFromTicks(
                text:
                    """`WayVes` reads `Shaders` that follow the below hierarchy:""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
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

                      color: Theme.of(context).colorScheme.onPrimaryContainer,
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

                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      width: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: VerticalDivider(
                        thickness: 0.5,

                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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

                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      width: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: VerticalDivider(
                        thickness: 0.5,

                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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

                      color: Theme.of(context).colorScheme.onPrimaryContainer,
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

                      color: Theme.of(context).colorScheme.onPrimaryContainer,
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

                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      width: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: VerticalDivider(
                        thickness: 0.5,

                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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

                      color: Theme.of(context).colorScheme.onPrimaryContainer,
                      width: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 24.0),
                      child: VerticalDivider(
                        thickness: 0.5,

                        color: Theme.of(context).colorScheme.onPrimaryContainer,
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

                      color: Theme.of(context).colorScheme.onPrimaryContainer,
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
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                "The pair of Vertex and Fragment Shaders get compiled and executed in the order in which they are numbered.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            InfoCard(
              formattedTextWidget: Column(
                children: [
                  RichTextFromTicks(
                    text:
                        "When `number of Vertex Shader files <= number of Fragment Shader files`, then the default Vertex Shader File will be used:",
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                  const CodeSnippetCard(
                    textString: """#version 330 core
layout(location = 0) in vec3 aPos;
void main()
{
    gl_Position = vec4(aPos.x, aPos.y, 0.0f, 1.0);
}""",
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichTextFromTicks(
                text:
                    "By using `Shaders` in this way, you can utilise the output of the 'previous' pass and consume it for some `Post-Processing Effects`",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Uniforms"],
              titleString: "Uniforms",
              subtitleString:
                  "`WayVes` provides several `uniforms` that can be consumed in a `Shader`.",
              children: [
                TypesList(
                  parameters: uniforms,
                  dataDescriptions: uniformsDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
              ],
            ),
            const InfoCard(
              textString:
                  "Besides Uniforms, `gl_FragCoord` and `FragColor` are also to be specified to handle input and output values for the current Fragment Shader",
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Minimal Fragment Shader Example; all Uniforms"],
              titleString: "Minimal Fragment Shader Example; all Uniforms",
              children: [
                const CodeSnippetCard(
                  textString: """#define version 430

in vec4 gl_FragCoord;

uniform float time;
uniform vec2 resolution;

uniform sampler2D tex; // Not available in 1.frag

uniform sampler1D audioL;
uniform int audioLSize;

uniform sampler1D audioR;
uniform int audioRSize;

layout(r32ui, binding = 0) uniform uimage2D atomicImageTexture0;

layout(binding = 1, rgba32f) uniform image2D imageTexture0;
layout(binding = 2, rgba32f) uniform image2D imageTexture1;

out vec4 FragColor;

void main()
{
}""",
                ),
              ],
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Special Directives",
                route: SpecialDirectivesScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Main Configuration - YAML Specification",
                route: YAMLSpecificationScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
