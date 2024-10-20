import 'package:flutter/material.dart';

import 'package:simple_weather_app/core/constant/globals.dart' as global;
import 'package:google_fonts/google_fonts.dart';

abstract class AppTheme {
  static ThemeData get light {
    return ThemeData(
      scaffoldBackgroundColor: global.primaryLightColor,
      appBarTheme: AppBarTheme(
          elevation: 0.0,
          color: Colors.transparent,
          iconTheme: IconThemeData(color: global.primaryDarkColor),
          titleTextStyle: TextStyle(
            color: global.primaryDarkColor,
            fontSize: 16,
          )),
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
        titleLarge: GoogleFonts.roboto(
            fontSize: 96, letterSpacing: 1, color: global.primaryDarkColor),
        titleMedium: GoogleFonts.roboto(
            fontSize: 48, letterSpacing: 1.5, color: global.primaryDarkColor),
        titleSmall: GoogleFonts.roboto(
            fontSize: 24, letterSpacing: 2, color: global.primaryDarkColor),
        bodyLarge: GoogleFonts.robotoMono(
            fontSize: 16, letterSpacing: 2, color: global.primaryDarkColor),
        bodyMedium: GoogleFonts.robotoMono(
            fontSize: 12, letterSpacing: 2, color: global.primaryDarkColor),
        bodySmall: GoogleFonts.robotoMono(
            fontSize: 8, letterSpacing: 2, color: global.primaryDarkColor),
        labelLarge: GoogleFonts.robotoMono(
            fontSize: 16,
            letterSpacing: 2,
            color: global.primaryDarkColor.withOpacity(.8)),
        labelMedium: GoogleFonts.robotoMono(
            fontSize: 12,
            letterSpacing: 2,
            color: global.primaryDarkColor.withOpacity(.8)),
        labelSmall: GoogleFonts.robotoMono(
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
          iconTheme: IconThemeData(color: global.terciaryDarkColor),
          titleTextStyle: TextStyle(
            color: global.primaryLightColor,
            fontSize: 16,
          )),
      colorScheme: ColorScheme(
          brightness: Brightness.dark,
          primaryContainer: global.primaryDarkColor,
          primary: global.primaryDarkColor,
          onPrimary: global.primaryDarkColor,
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
        titleLarge: GoogleFonts.roboto(
            fontSize: 96, letterSpacing: 1, color: global.primaryLightColor),
        titleMedium: GoogleFonts.roboto(
            fontSize: 48, letterSpacing: 1.5, color: global.primaryLightColor),
        titleSmall: GoogleFonts.roboto(
            fontSize: 25, letterSpacing: 2, color: global.primaryLightColor),
        bodyLarge: GoogleFonts.robotoMono(
            fontSize: 16, letterSpacing: 2, color: global.primaryLightColor),
        bodyMedium: GoogleFonts.robotoMono(
            fontSize: 12, letterSpacing: 2, color: global.primaryLightColor),
        bodySmall: GoogleFonts.robotoMono(
            fontSize: 8, letterSpacing: 2, color: global.primaryLightColor),
        labelLarge: GoogleFonts.robotoMono(
            fontSize: 16,
            letterSpacing: 2,
            color: global.primaryLightColor.withOpacity(.8)),
        labelMedium: GoogleFonts.robotoMono(
            fontSize: 12,
            letterSpacing: 2,
            color: global.primaryLightColor.withOpacity(.8)),
        labelSmall: GoogleFonts.robotoMono(
            fontSize: 8,
            letterSpacing: 2,
            color: global.primaryLightColor.withOpacity(.8)),
      ),
    );
  }
}
