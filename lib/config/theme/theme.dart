import 'package:flutter/material.dart';

import 'package:simple_weather_app/utils/constant/globals.dart' as global;
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: global.primaryLightColor,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: Colors.transparent,
        iconTheme: IconThemeData(color: global.primaryDarkColor),
        titleTextStyle: GoogleFonts.roboto(
            fontSize: 16, letterSpacing: 2, color: global.primaryDarkColor),
      ),
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primaryContainer: global.primaryLightColor,
          primary: global.primaryLightColor,
          onPrimary: global.secondaryLightColor,
          secondary: global.secondaryLightColor,
          onSecondary: global.secondaryLightColor,
          error: global.red,
          onError: global.red.withOpacity(.5),
          surface: global.secondaryLightColor,
          onSurface: global.secondaryLightColor,
          tertiary: global.terciaryLightColor,
          inversePrimary: global.primaryDarkColor,
          inverseSurface: global.secondaryDarkColor),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.ubuntu(
            fontSize: 96, letterSpacing: 1, color: global.primaryDarkColor),
        titleMedium: GoogleFonts.ubuntu(
            fontSize: 48, letterSpacing: 1.5, color: global.primaryDarkColor),
        titleSmall: GoogleFonts.ubuntu(
            fontSize: 24, letterSpacing: 2, color: global.primaryDarkColor),
        bodyLarge: GoogleFonts.roboto(
            fontSize: 16, letterSpacing: 2, color: global.primaryDarkColor),
        bodyMedium: GoogleFonts.roboto(
            fontSize: 12, letterSpacing: 2, color: global.primaryDarkColor),
        bodySmall: GoogleFonts.roboto(
            fontSize: 8, letterSpacing: 2, color: global.primaryDarkColor),
        labelLarge: GoogleFonts.roboto(
            fontSize: 16,
            letterSpacing: 2,
            color: global.primaryDarkColor.withOpacity(.8)),
        labelMedium: GoogleFonts.roboto(
            fontSize: 12,
            letterSpacing: 2,
            color: global.primaryDarkColor.withOpacity(.8)),
        labelSmall: GoogleFonts.roboto(
            fontSize: 8,
            letterSpacing: 2,
            color: global.primaryDarkColor.withOpacity(.8)),
      ),
    );
  }

  static ThemeData get dark {
    return ThemeData(
      scaffoldBackgroundColor: global.primaryDarkColor,
      appBarTheme: AppBarTheme(
        elevation: 0.0,
        color: Colors.transparent,
        iconTheme: IconThemeData(color: global.primaryLightColor),
        titleTextStyle: GoogleFonts.roboto(
            fontSize: 16, letterSpacing: 2, color: global.primaryLightColor),
      ),
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primaryContainer: global.primaryDarkColor,
          primary: global.primaryDarkColor,
          onPrimary: global.secondaryDarkColor,
          secondary: global.secondaryDarkColor,
          onSecondary: global.secondaryDarkColor,
          error: global.red,
          onError: global.red.withOpacity(.5),
          surface: global.secondaryDarkColor,
          onSurface: global.secondaryDarkColor,
          tertiary: global.terciaryDarkColor,
          inversePrimary: global.primaryLightColor,
          inverseSurface: global.secondaryLightColor),
      textTheme: TextTheme(
        titleLarge: GoogleFonts.ubuntu(
            fontSize: 96, letterSpacing: 1, color: global.primaryLightColor),
        titleMedium: GoogleFonts.ubuntu(
            fontSize: 48, letterSpacing: 1.5, color: global.primaryLightColor),
        titleSmall: GoogleFonts.ubuntu(
            fontSize: 24, letterSpacing: 2, color: global.primaryLightColor),
        bodyLarge: GoogleFonts.roboto(
            fontSize: 16, letterSpacing: 2, color: global.primaryLightColor),
        bodyMedium: GoogleFonts.roboto(
            fontSize: 12, letterSpacing: 2, color: global.primaryLightColor),
        bodySmall: GoogleFonts.roboto(
            fontSize: 8, letterSpacing: 2, color: global.primaryLightColor),
        labelLarge: GoogleFonts.roboto(
            fontSize: 16,
            letterSpacing: 2,
            color: global.primaryLightColor.withOpacity(.8)),
        labelMedium: GoogleFonts.roboto(
            fontSize: 12,
            letterSpacing: 2,
            color: global.primaryLightColor.withOpacity(.8)),
        labelSmall: GoogleFonts.roboto(
            fontSize: 8,
            letterSpacing: 2,
            color: global.primaryLightColor.withOpacity(.8)),
      ),
    );
  }
}
