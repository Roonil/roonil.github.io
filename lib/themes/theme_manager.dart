import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeManager {
  static List<ThemeData> getTheme({
    required ThemeMode? themeMode,
    required Color primaryColor,
    required Color? secondaryColor,
    required Color? tertiaryColor,
  }) {
    final ThemeData baseThemeData = ThemeData(
      chipTheme: ChipThemeData(
        side: const BorderSide(color: Colors.transparent),
        padding: EdgeInsets.zero,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
    );

    final ThemeData lightThemeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiaryColor,
        brightness: Brightness.light,
      ),
      primaryColor: primaryColor,
      useMaterial3: true,
    );

    final ThemeData darkThemeData = ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        secondary: secondaryColor,
        tertiary: tertiaryColor,
        brightness: Brightness.dark,
      ),
      primaryColor: primaryColor,
      useMaterial3: true,
    );

    final ThemeData darkTheme = darkThemeData.copyWith(
      cardTheme: darkThemeData.cardTheme.copyWith(
        shadowColor: primaryColor,
        elevation: 5,
        surfaceTintColor: darkThemeData.primaryColor,
      ),
      // scaffoldBackgroundColor: const Color.fromRGBO(20, 22, 34, 1),
      textTheme: GoogleFonts.montserratTextTheme(darkThemeData.textTheme),
      colorScheme: darkThemeData.colorScheme,
      chipTheme: baseThemeData.chipTheme.copyWith(
        side: const BorderSide(color: Colors.transparent),
        backgroundColor: secondaryColor,
        selectedShadowColor: primaryColor,
        labelStyle: const TextStyle(color: Colors.white),
        iconTheme: darkThemeData.iconTheme.copyWith(
          color: secondaryColor,
          size: 18,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: darkThemeData.primaryColor,
          foregroundColor: Colors.white,
        ),
      ),
    );

    final ThemeData lightTheme = lightThemeData.copyWith(
      colorScheme: lightThemeData.colorScheme,
      scaffoldBackgroundColor: lightThemeData.colorScheme.secondaryContainer,
      canvasColor: lightThemeData.colorScheme.primaryContainer,
      pageTransitionsTheme: PageTransitionsTheme(
        builders: {
          TargetPlatform.android: FadeForwardsPageTransitionsBuilder(
            backgroundColor: lightThemeData.colorScheme.primaryContainer,
          ),
          TargetPlatform.iOS: FadeForwardsPageTransitionsBuilder(
            backgroundColor: lightThemeData.colorScheme.primaryContainer,
          ),
          TargetPlatform.macOS: FadeForwardsPageTransitionsBuilder(
            backgroundColor: lightThemeData.colorScheme.primaryContainer,
          ),
          TargetPlatform.windows: FadeForwardsPageTransitionsBuilder(
            backgroundColor: lightThemeData.colorScheme.primaryContainer,
          ),
          TargetPlatform.linux: FadeForwardsPageTransitionsBuilder(
            backgroundColor: lightThemeData.colorScheme.primaryContainer,
          ),
          TargetPlatform.fuchsia: FadeForwardsPageTransitionsBuilder(
            backgroundColor: lightThemeData.colorScheme.primaryContainer,
          ),
        },
      ),
      dialogTheme: lightThemeData.dialogTheme.copyWith(
        backgroundColor: lightThemeData.colorScheme.primaryContainer,
      ),
      cardTheme: lightThemeData.cardTheme.copyWith(
        elevation: 5,
        surfaceTintColor: lightThemeData.primaryColor,
      ),
      elevatedButtonTheme: darkTheme.elevatedButtonTheme,
      chipTheme: darkTheme.chipTheme,
      textTheme: GoogleFonts.poppinsTextTheme(lightThemeData.textTheme),
    );

    if (themeMode == null) {
      return [lightTheme, darkTheme];
    }
    return [themeMode == ThemeMode.light ? lightTheme : darkTheme];
  }
}
