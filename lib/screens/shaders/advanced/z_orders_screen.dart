import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/headings.dart';
import 'package:wayves_wiki/models/nav_item.dart';
import 'package:wayves_wiki/screens/shaders/advanced/extras_screen.dart';
import 'package:wayves_wiki/screens/shaders/advanced/special_directives_screen.dart';
import 'package:wayves_wiki/widgets/bottom_navigation.dart';
import 'package:wayves_wiki/widgets/code_snippet_card.dart';
import 'package:wayves_wiki/widgets/info_card.dart';
import 'package:wayves_wiki/widgets/rich_text_from_ticks.dart';
import 'package:wayves_wiki/widgets/rounded_expansion_tile.dart';
import 'package:wayves_wiki/widgets/spaced_lines.dart';
import 'package:wayves_wiki/widgets/types_list.dart';

class ZOrdersScreen extends StatefulWidget {
  const ZOrdersScreen({super.key});
  static const routeName = '/shaders/advanced/z-orders';

  @override
  State<ZOrdersScreen> createState() => _ZOrdersScreenState();
}

class _ZOrdersScreenState extends State<ZOrdersScreen> {
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
              key: heading!["Z-Index Ordering"],
              "Z-Index Ordering",
              style: Theme.of(context).textTheme.displaySmall,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SpacedLines(
                text:
                    """• `Linear` and `Angular` Shaders expose `Primitives`, that can additionally have `Caps` and / or `Connectors`
• All the `Objects` naturally follow a pre-configured hierarchy in which they appear to be stacked from bottom to top
• This is more prominent when the `Objects` have different Transparency values
By default, the `Objects` appear to be stacked from bottom to top as such:""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const GroupsHierarchy(),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: SpacedLines(
                text:
                    """• You can modify each `SDF` or `Shape` for the `Primitives`, `Caps`, and `Connectors` in the `modifySDFs()` function.
• The array `zOrder` defined within `linear/structs.glsl` (and `angular/structs.glsl`) can be manipulated to manually specify the `Z-Index` of each `Object`.
• Additionally, as helper functions, the `Z-Orders` files contain some logic that can rearrange the `Z-Index` for each Object within a `Group` (`Bar`, `Upside Particles` and `Downside Particles`)
• You can import the relevant `Z-Orders` file within your `GLSL Configuration File` (`#include "linear/zOrders.glsl"` or `#include "angular/zOrders.glsl"`), then call the necessary functions from the `modifySDFs()` function.
Both `Z-Orders` counter-parts provide 3 different kinds of 'functionalities', namely, setting the `Z-Index` for each `Object / Group`, the `Color Blend Mode` for each `Object` within a `Group`, and `PassThrough` for how 'deep' an `Object` appears within a `Group` when the `Color Blend Mode` is not additive; as if the `Object` at the top 'cuts' the `Object(s)` that is / are beneath it.
Listed below are the functions that `Z-Orders` exposes. These are described for the `Angular` Shader, but except for the `Circle` counter-part, they are the same for the `Linear` Shader. Ensure that for the `Linear` Shader, you pass only 3 parameters to the `setLayerOffsets()` function.""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const InfoCard(
              textString:
                  """It is absolutely necessary that the values provided to the zIndex functions are all different (as they indicate the zIndex for each Object / Group)""",
              isWarning: true,
            ),

            const InfoCard(
              textString:
                  """The zIndices that are passed to the functions are all relative, meaning that all the zIndices begin from 0.""",
            ),

            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TypesList(
                parameters: [
                  "setLayerOffsets(int circleOffset, int barOffset, int particleUpOffset, int particleDownOffset)",
                ],
                dataDescriptions: [
                  "Sets the `Z-Index` for each `Group`. `setLayerOffsets(1,3,0,2)` makes the `Bars Group` appear at the top, followed by `Downside Particles`, `Circle`, and finally the `Upside Particles`",
                ],
                dataTypes: null,
                examples: null,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: RichTextFromTicks(
                text:
                    """For each `Group`, there are 3 functions, each for setting the `Z-Index` for each `Object` within that `Group` (all different values), for setting the `Color Blend Mode` of each `Object` (either 0 or 1), and for setting the `PassThrough` for each `Intermediate Layer` within that group (by excluding the `top and bottom layers` within that `Group`)""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              child: TypesList(
                parameters: [
                  "set<GroupName>GroupZIndex(int object1ZIndex, int object2ZIndex, ...)",
                  "set<GroupName>GroupCBM(int object1CBM, int object2CBM, ...)",
                  "set<GroupName>GroupPassThrough(int layer1PassThrough, int layer2PassThrough, ...)",
                ],
                dataDescriptions: [
                  "Sets the `Z-Index` for each `Object` within the `Group`. All passed values must be different, with the lowest value being 0. If the `Group` has 5 Objects in total, then sending in the values 1, 0, 4, 2, 3 will mean that `Object3` will appear at the Top, followed by `Object5`, `Object4`, `Object1` and then `Object2` at the bottom of all `Objects`.",
                  "Sets the `Color Blend Mode` for each `Object`, that decides how the `Object` 'below' this `Object` will be rendered, if this `Object` has some Transparency. Each value is either 0 or 1. Setting 1 means that the `Object` below this `Object` will be rendered with the necessary `Alpha Blending` applied. Setting 0 means that the portion of the `Object` below this `Object` won't be rendered, as if this `Object` 'cuts' the `Object` below. The extent of this 'cutting' is specified by the `PassThrough` function.",
                  "Sets whether the `Object` that 'cuts' this `layer`, should also 'cut' the `layer` beneath. Each value is either 0 or 1. Setting 0 means that the 'cutting' stops at this `layer`. Setting 1 means that the current `layer` should also get 'cut'. This is only effective when an `Object` with CBM 0 is 'cutting' the current `layer`.",
                ],
                dataTypes: null,
                examples: null,
              ),
            ),
            const Divider(),

            RoundedExpansionTile(
              key: heading["Circle Group"],
              titleString: "Circle Group",
              subtitleString: """Available only in the `Angular` Shader""",
              children: [
                Text(
                  """Mostly Trivial as you should not expect to see any difference as the Inner and Outer Shapes are Mutually Exclusive, but the functions have been provided nonetheless.                  """,
                  style: Theme.of(context).textTheme.titleMedium,
                ),

                const CodeSnippetCard(
                  textString:
                      """void setCircleGroupZIndex( int innerCircleZIndex, int outerCircleZIndex )

void setCircleGroupCBM( int innerCircleCBM, int outerCircleCBM )""",
                ),
                const InfoCard(
                  textString:
                      "No Intermediate Layers in this Group, hence no PassThrough() function",
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Bars Group"],
              titleString: "Bars Group",
              children: [
                const CodeSnippetCard(
                  textString:
                      """void setBarGroupZIndex( int barBGZIndex, int innerBarZIndex, int outerBarZIndex, int upperCapZIndex, int lowerCapZIndex )

void setBarGroupCBM( int barBGCBM, int innerBarCBM, int outerBarCBM, int upperCapCBM, int lowerCapCBM )

void setBarGroupPassThrough( int layer1PassThrough, int layer2PassThrough, int layer3PassThrough )""",
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Upper Particles Group"],
              titleString: "Upper Particles Group",
              children: [
                const CodeSnippetCard(
                  textString:
                      """void setParticleUpGroupZIndex( int innerParticleUpZIndex, int outerParticleUpZIndex, int leftConnectorInnerZIndex, int rightConnectorInnerZIndex,  int leftConnectorOuterZIndex, int rightConnectorOuterZIndex, int capZIndex )

void setParticleUpGroupCBM( int innerParticleUpCBM, int outerParticleUpCBM, int leftConnectorInnerCBM, int rightConnectorInnerCBM,  int leftConnectorOuterCBM, int rightConnectorOuterCBM, int capCBM )

void setParticleUpGroupPassThrough( int layer1PassThrough, int layer2PassThrough, int layer3PassThrough, int layer4PassThrough, int layer5PassThrough )""",
                ),
              ],
            ),
            const Divider(),
            RoundedExpansionTile(
              key: heading["Lower Particles Group"],
              titleString: "Lower Particles Group",
              children: [
                const CodeSnippetCard(
                  textString:
                      """void setParticleDownGroupZIndex( int innerParticleDownZIndex, int outerParticleDownZIndex, int leftConnectorInnerZIndex, int rightConnectorInnerZIndex,  int leftConnectorOuterZIndex, int rightConnectorOuterZIndex, int capZIndex )

void setParticleDownGroupCBM( int innerParticleDownCBM, int outerParticleDownCBM, int leftConnectorInnerCBM, int rightConnectorInnerCBM,  int leftConnectorOuterCBM, int rightConnectorOuterCBM, int capCBM )

void setParticleDownGroupPassThrough( int layer1PassThrough, int layer2PassThrough, int layer3PassThrough, int layer4PassThrough, int layer5PassThrough )""",
                ),
              ],
            ),

            const Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                key: heading["Manually overriding Z-Orders and SDFs"],
                "Manually overriding Z-Orders and SDFs",
                style: Theme.of(context).textTheme.displaySmall,
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: SpacedLines(
                text:
                    """For finer control, you can modify the `zOrder` and `sdfs` arrays to get desired outcomes.
Take care to always overwrite `zOrder` array's values in pairs, so that no two entries are the same.
You can manipulate the entries as such:""",
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),

            const CodeSnippetCard(
              textString: """void modifySDFs()
{
    // Changes the Z-Index ordering from
    // BG -> Inner -> Outer
    // to
    // Outer -> BG -> Inner
    // Use colors with some transparency to see the results!

    zOrder[BAR_BG_SDF] = BAR_OUTER_SDF; // Same as zOrder[0] = BAR_OUTER_SDF
    zOrder[BAR_INNER_SDF] = BAR_BG_SDF; // Same as zOrder[1] = BAR_BG_SDF;
    zOrder[BAR_OUTER_SDF] = BAR_INNER_SDF; // Same as zOrder[2] = BAR_INNER_SDF;

    // Note that using the _SDF variables within the square brackets doesn't update their value whenever you use them next here.
    // In this case, if you have to refer to BAR_INNER_SDF using the zOrder array from now on, you'll have to use  zOrder[BAR_OUTER_SDF], as this is where BAR_INNER_SDF sits now.

    // Completely hides downward particles' inner body whenever a Bar's inner body is on top of it.
    // Note that BAR_INNER_SDF is referred to as sdfs[zOrder[BAR_OUTER_SDF]] because of the previous assignment.
    sdfs[zOrder[PARTICLE_DOWN_INNER_SDF]] = clamp(sdfs[zOrder[PARTICLE_DOWN_INNER_SDF]] - sdfs[zOrder[BAR_OUTER_SDF]], 0, 1);

    // Or, you can just use the _SDF variables directly within sdfs array without worrying about previous assignments in this way.
    // sdfs[PARTICLE_DOWN_INNER_SDF] = clamp(sdfs[PARTICLE_DOWN_INNER_SDF] - sdfs[BAR_INNER_SDF], 0, 1);
}""",
            ),
            BottomNavigation(
              prevNavItem: NavItem(
                title: "Extras",
                route: ExtrasScreen.routeName,
              ),
              nextNavItem: NavItem(
                title: "Special Directives",
                route: SpecialDirectivesScreen.routeName,
              ),
            ),
          ],
        ),
      ),
    );
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
