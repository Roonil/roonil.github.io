import 'package:flutter/material.dart';
import 'package:wayves_wiki/constants/colors.dart';
import 'package:wayves_wiki/themes/theme_manager.dart';

class InfoCard extends StatelessWidget {
  final Widget formattedTextWidget;
  final bool? isWarning;
  const InfoCard({
    super.key,
    required this.formattedTextWidget,
    this.isWarning,
  });

  static final themeDatas = ThemeManager.getTheme(
    themeMode: null,
    primaryColor: secondaryColor,
    secondaryColor: secondaryColor,
    tertiaryColor: tertiaryColor,
  );

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: (isWarning ?? false)
          ? themeDatas[Theme.of(context).brightness == Brightness.light ? 0 : 1]
          : Theme.of(context),
      child: Card.outlined(
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 0),
        elevation: 2,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 9),
                child: Icon(
                  (isWarning ?? false)
                      ? Icons.warning_rounded
                      : Icons.info_outline_rounded,

                  color: (isWarning ?? false)
                      ? Colors.amberAccent
                      : Theme.of(context).colorScheme.primary,
                ),
              ),
              Expanded(child: formattedTextWidget),
            ],
          ),
        ),
      ),
    );
  }
}
