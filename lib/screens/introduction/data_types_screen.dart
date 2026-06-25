import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:wayves_wiki/constants/data_types.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/introduction/glsl_functions_screen.dart';
import 'package:wayves_wiki/screens/introduction/overview_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';

import 'package:wayves_wiki/widgets/types_list.dart';

class DataTypesScreen extends StatefulWidget {
  const DataTypesScreen({super.key});
  static const routeName = '/introduction/data-types';

  @override
  State<DataTypesScreen> createState() => _DataTypesScreenState();
}

class _DataTypesScreenState extends State<DataTypesScreen> {
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
                key: heading!["Data Types"],
                "Data Types",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 12.0, left: 12),
              child: SpacedLines(
                text:
                    """• `WayVes` utilises OpenGL - driven `Shaders` to draw high - quality Visuals.
• `OpenGL` uses `GLSL` (OpenGL Shading Language), which is a C - typed Language. 
• Aside from most of the basic data types from C, there are some additional data types that `GLSL` supports.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, left: 12),
              child: Text.rich(
                TextSpan(
                  style: Theme.of(context).textTheme.titleMedium,
                  text: "The following sections are taken from the official ",
                  children: [
                    WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: TextButton(
                        onPressed: () async {
                          await launchUrl(
                            Uri.parse(
                              "https://wikis.khronos.org/opengl/Data_Type_(GLSL)",
                            ),
                          );
                        },
                        child: const Text("OpenGL Khronos Wiki"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Scalars"],
              titleString: "Scalars",
              subtitleString: "Fundamental Data Types",
              children: [
                TypesList(
                  dataDescriptions: scalarDataTypeDescriptions,
                  parameters: scalarDataTypes,
                  dataTypes: null,
                  examples: null,
                ),
                const CodeSnippetCard(
                  textString: """bool boolVal = true;
int intVal = 10;
float floatVal = 20.012;
double doubleVal = 30.004;""",
                ),
              ],
            ),

            const Divider(),
            RoundedExpansionTile(
              key: heading["Vectors"],
              titleString: "Vectors",
              subtitleString:
                  "Each of the scalar types, including booleans, have 2, 3, and 4-component vector equivalents",
              children: [
                TypesList(
                  dataDescriptions: vectorDataTypesDescriptions,
                  parameters: vectorDataTypes,
                  dataTypes: null,
                  examples: null,
                ),
                const Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Divider(),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20.0,
                    vertical: 12,
                  ),
                  child: Text(
                    "Swizzling",
                    style: Theme.of(context).textTheme.displaySmall,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: 12.0,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    """You can access the components of vectors using the following syntax:""",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.0),
                  child: CodeSnippetCard(
                    textString: """vec4 someVec;
float value = someVec.x + someVec.y;""",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 12,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    """This is called swizzling. You can use x, y, z, or w, referring to the first, second, third, and fourth components, respectively.""",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                  child: InfoCard(
                    textString:
                        "If you initialise a vecn (vec2, vec3, or vec4) variable with just one value, then all components take on that value.",
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                  child: CodeSnippetCard(
                    textString:
                        "vec2 uv = vec2(1);                           // Same as vec2(1, 1);",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 4,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    "You can also combine smaller vecn variables in the initialisation of a larger one.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                  child: CodeSnippetCard(
                    textString:
                        "vec4 Color = vec4(uv, 0, 1);             // x and y components of Color are the same as the x and y components of uv.",
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.only(
                    top: 8.0,
                    bottom: 4,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    "Or you can Swizzle the components to switch the ordering of the inner vector to the desired order.",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                  child: CodeSnippetCard(
                    textString:
                        "Color = vec4(uv.yx, uv.xy);              // Color = vec4(uv.y, uv.x, uv.x, uv.y);",
                  ),
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Matrices"],
              titleString: "Matrices",
              subtitleString: "Collection of Vectors",
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: SpacedLines(
                    text:
                        """• In addition to vectors, there are also matrix types.
• All matrix types are floating-point, either single-precision or double-precision.
• Matrix types are as follows, where n and m can be the numbers 2, 3, or 4:""",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TypesList(
                    parameters: matrixDataTypes,
                    dataDescriptions: matrixDataTypesDescriptions,
                    dataTypes: null,
                    examples: null,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    left: 20,
                    right: 20,
                    bottom: 8,
                  ),
                  child: Text(
                    """Swizzling does not work with matrices. You can instead access a matrix's fields with array syntax:""",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                  child: CodeSnippetCard(
                    textString: """mat3 theMatrix;
theMatrix[1] = vec3(3.0, 3.0, 3.0);             // Sets the second column to all 3.0s
theMatrix[2][0] = 16.0;                               // Sets the first entry of the third column to 16.0.""",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 12.0,
                    bottom: 8,
                    left: 20,
                    right: 20,
                  ),
                  child: Text(
                    """However, the result of the first array accessor is a vector, so you can swizzle that:""",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),

                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 4.0, horizontal: 20),
                  child: CodeSnippetCard(
                    textString: """mat3 theMatrix;
theMatrix[1].yzx = vec3(3.0, 1.0, 2.0);""",
                  ),
                ),
              ],
            ),
            const Divider(),
            Padding(
              padding: const EdgeInsets.only(
                left: 12.0,
                right: 12,
                top: 12,
                bottom: 8,
              ),
              child: Text(
                key: heading["Explicit Type Conversion"],
                "Explicit Type Conversion",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 12.0,
                horizontal: 12,
              ),
              child: RichTextFromTicks(
                text:
                    """To cast a data type to another, use `datatype_to_cast_to(variable)`""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const CodeSnippetCard(
              textString: """int a = 2;
float b = float(a) / 3;             // a is treated as a float before the division""",
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Overview",
                route: OverviewScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "GLSL Functions",
                route: GlslFunctionsScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
