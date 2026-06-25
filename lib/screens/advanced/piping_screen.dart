import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/data_types.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/advanced/cli_args_screen.dart';
import 'package:wayves_wiki/screens/main_configuration/styling_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';

import 'package:wayves_wiki/widgets/types_list.dart';

class PipingScreen extends StatefulWidget {
  const PipingScreen({super.key});
  static const routeName = '/updating-properties/piping-data';

  @override
  State<PipingScreen> createState() => _PipingScreenState();
}

class _PipingScreenState extends State<PipingScreen> {
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
              key: heading!["Piping Data"],
              "Piping Data",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SpacedLines(
              text:
                  """• `WayVes` supports supplying in dynamic values for its `Shaders`. This is achieved by using `Named Pipes`.
• For a variable to be eligible for dynamic overrides in this way, it should be declared as a `uniform`.
• `uniforms` are always declared globally, so they should be declared outside any functions.         
For Example, if you want to supply `visualiserDirections` as a dynamic input, then in the Shader Configuration File,
change :""",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const CodeSnippetCard(textString: "#define visualiserDirections 0"),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text("to", style: Theme.of(context).textTheme.titleMedium),
            ),
            const CodeSnippetCard(
              textString: "uniform int visualiserDirections = 0;",
            ),
            SpacedLines(
              text:
                  """You can then pass in data using external scripts to manipulate `visualiserDirections`
Pipe the data you want to send in the `/tmp/WayVes/<ShaderClass>` file. Data should be in the form:""",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const CodeSnippetCard(
              textString:
                  "variableName1 = variableValue1\nvariableName2 = variableValue2\n.\n.\n.",
              language: "txt",
            ),
            const InfoCard(
              textString:
                  "Use the '\\n' escape sequence to go to the next line while writing data to the pipe.",
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichTextFromTicks(
                text:
                    "You can also pass in colors in the same way. Just define an attribute with a suitable name as a `uniform`:",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const CodeSnippetCard(
              textString:
                  "uniform vec4 dynamicColor = vec4(1, 0, 0, 1);            // vec4(1, 0, 0, 1) serves as the initial value here",
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichTextFromTicks(
                text: "Consume the value where you want in the `Shader`:",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const CodeSnippetCard(textString: "bar.color = dynamicColor;"),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: RichTextFromTicks(
                text:
                    """Then, you can write to the pipe `/tmp/WayVes/linear` (assuming the className is `linear`):""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const CodeSnippetCard(
              textString:
                  """echo "dynamicColor = vec4(0, 0, 1, 1)" >> /tmp/WayVes/linear""",
              language: "bash",
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                "Bars' color will change from Red to Blue in this case.",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const InfoCard(
              isWarning: true,
              textString:
                  "`hsv / hsva` cannot be used as `uniforms`, and hence cannot be piped in. Instead use `vec4 / vec3` or `rgba / rgb`.",
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Supported Data Types"],
              titleString: "Supported Data Types",
              children: [
                TypesList(
                  parameters: pipeDataTypes,
                  dataDescriptions: pipeDataTypesDescriptions,
                  dataTypes: null,
                  examples: null,
                ),
                const InfoCard(
                  isWarning: true,
                  textString:
                      "vecn needs to be supplied in with all n values. vec2(1) will not be accepted, however vec2(1, 1) will be.",
                ),
              ],
            ),
            const Divider(),
            Text(
              "Reloading Configurations",
              key: heading["Reloading Configurations"],
              style: Theme.of(context).textTheme.displaySmall,
            ),
            SpacedLines(
              text:
                  """• `WayVes` uses named instances to identify the group of Shaders that can be targeted for a reload.
• Supply an instance name while launching `WayVes` by supplying the `-i` flag along with the name to identify the Instance with.
• All `Audio` Object names within an instance must be unique. You can run different invocations of the same instance as long as their `Audio` Object names are all different. 
• To target a reload for an instance, you need to pipe in the name of the new YAML file from which to read the new Spec that will replace the Shaders for that instance.
• This is useful if you dynamically want to change the number and types of Shaders based on any runtime attribute.
• For an instance with name instanceName, the pipe is present at `/tmp/WayVes/instance_instanceName`
• For example, if you want to target the instance `desktop` and reload its contents with the Shaders specification defined in a file `newShaderSpec.yaml`, then:""",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const CodeSnippetCard(
              textString:
                  """echo "reload = newShaderSpec" >> /tmp/WayVes/instance_desktop""",
              language: "bash",
            ),
            const InfoCard(
              textString:
                  "Use instance reloading sparingly, as spamming too many reloads for a single instance might lead to inconsistencies",
              isWarning: true,
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Main Configuration - Styling",
                route: StylingScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "CLI Arguments",
                route: CliArgsScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
