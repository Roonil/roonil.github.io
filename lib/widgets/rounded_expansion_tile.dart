import 'package:flutter/material.dart';
import 'package:wayves_wiki/helper_functions/rich_text_from_ticks.dart';

class RoundedExpansionTile extends StatelessWidget {
  final String titleString;
  final String? subtitleString;
  final TextStyle? textStyle;
  final Widget? titleWidget, subtitleWidget;
  final List<Widget> children;
  const RoundedExpansionTile({
    super.key,
    required this.titleString,
    required this.children,
    this.subtitleString,
    this.textStyle,
    this.titleWidget,
    this.subtitleWidget,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadiusGeometry.circular(20),
      child: ExpansionTile(
        initiallyExpanded: true,
        childrenPadding: const EdgeInsets.symmetric(vertical: 4),
        expandedAlignment: Alignment.centerLeft,
        expandedCrossAxisAlignment: CrossAxisAlignment.start,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title:
            titleWidget ??
            Text.rich(
              style: textStyle ?? Theme.of(context).textTheme.titleMedium,
              HelperFunctions.getRichTextFromTicks(
                text: titleString,
                style:
                    textStyle?.copyWith(fontWeight: FontWeight.w500) ??
                    Theme.of(context).textTheme.displaySmall?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
        subtitle:
            subtitleWidget ??
            (subtitleString != null
                ? Text.rich(
                    style: textStyle ?? Theme.of(context).textTheme.titleMedium,

                    HelperFunctions.getRichTextFromTicks(
                      text: subtitleString!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  )
                : null),
        children: children,
      ),
    );
  }
}
