import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/config_objects.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/main_configuration/styling_screen.dart';
import 'package:wayves_wiki/screens/shaders/advanced/creating_your_own_shaders_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';

import 'package:wayves_wiki/widgets/types_list.dart';

class YAMLSpecificationScreen extends StatefulWidget {
  const YAMLSpecificationScreen({super.key});
  static const routeName = '/main-configuration/yaml-specification';

  @override
  State<YAMLSpecificationScreen> createState() =>
      _YAMLSpecificationScreenState();
}

class _YAMLSpecificationScreenState extends State<YAMLSpecificationScreen> {
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
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Text(
                key: heading!["Configuration File"],
                "Configuration File",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 12),
              child: SpacedLines(
                text:
                    """• The `config.yaml` file serves as the layout specification for the Shaders.
• Used to Define :-
      Audio objects
      Shader objects, belonging to an Audio object""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const InfoCard(
              textString:
                  """You can specify a different yaml file via the `-f` CLI Argument""",
            ),

            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 12,
              ),

              child: RichTextFromTicks(
                text:
                    """The `YAML Configuration file` has the following structure:""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const CodeSnippetCard(
              language: "yaml",
              textString: """audios:
    - name: audio1
      pipewire-settings:
        .
        .
        .
      audio-overrides:
        .
        .
        .
      shaders:
        - name: linear
          class-name: linear1
          .
          .
          .
          audio-overrides:
            .
            .
            .
          paintables:
            - class-name: paintable_1
              .
              .
              .
          post-processing:
            - name: glow
              passes: 1
            .
            .
            . 
          overrides:
            - visualiserMode=1
            .
            .
            .
    - name: audio2
    .
    .
    .""",
            ),

            const Divider(),

            RoundedExpansionTile(
              key: heading["PipeWire Settings"],
              titleString: "PipeWire Settings",
              subtitleString:
                  "Represents Audio Capturing properties, such as `Sample Rate` and `Buffer Size`",
              children: [
                TypesList(
                  parameters: pipeWireSettings,
                  dataDescriptions: pipeWireSettingsDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
              ],
            ),
            const Divider(),

            RoundedExpansionTile(
              key: heading["Channels Map"],
              titleString: "Channels Map",
              subtitleString: "Handles mapping for each Audio Channel",
              children: [
                TypesList(
                  parameters: channelMap,
                  dataDescriptions: channelMapDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Smooth Settings"],
              titleString: "Smooth Settings",
              subtitleString:
                  "Represents various paramters used to smoothen the Audio Output",
              children: [
                TypesList(
                  parameters: smoothSettings,
                  dataDescriptions: smoothSettingsDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Gravity Settings"],
              titleString: "Gravity Settings",
              subtitleString:
                  "Represents the amount of time for which the captured Audio Data 'stays' in the buffer",
              children: [
                TypesList(
                  parameters: gravitySettings,
                  dataDescriptions: gravitySettingsDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
              ],
            ),

            const Divider(),
            RoundedExpansionTile(
              key: heading["Audio Overrides"],
              titleString: "Audio Overrides",
              subtitleString: "Represents Audio Transformation properties",
              children: [
                TypesList(
                  parameters: audioOverrides,
                  dataDescriptions: audioOverridesDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Post-Processing Object"],
              titleString: "Post-Processing Object",
              subtitleString: """Represents the Post-Processing Shader.""",
              children: [
                TypesList(
                  parameters: postProcessingProps,
                  dataDescriptions: postProcessingPropsDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
              ],
            ),
            const Divider(),

            RoundedExpansionTile(
              key: heading["Paintable Object"],
              titleString: "Paintable Object",
              subtitleString:
                  """Represents the layout properties for the `Paintable`. It is essentially a 'copy' of a `Shader` that displays the same output as the `Shader`.""",
              children: [
                TypesList(
                  parameters: paintableProps,
                  dataDescriptions: paintablePropsDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Shader Object"],
              titleString: "Shader Object",
              subtitleString:
                  """Represents the layout properties of the Shader Program that gets displayed in a Window.""",
              children: [
                TypesList(
                  parameters: shaderProps,
                  dataDescriptions: shaderPropsDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
              ],
            ),

            const Divider(),
            RoundedExpansionTile(
              key: heading["Audio Object"],
              titleString: "Audio Object",
              subtitleString:
                  "Represents various Audio Capturing and transformation properties",
              children: [
                TypesList(
                  parameters: audioProps,
                  dataDescriptions: audioPropsDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
              ],
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Shaders - Creating your own Shaders",
                route: CreatingYourOwnShadersScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Styling",
                route: StylingScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
