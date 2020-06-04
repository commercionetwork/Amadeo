import 'package:flutter/material.dart';

final ThemeData companyTheme = ThemeData(
  brightness: Brightness.light,
  primarySwatch: CompanyColors.primary,
  primaryColor: CompanyColors.primary[500],
  primaryColorBrightness: Brightness.light,
  accentColor: CompanyColors.accent[500],
  accentColorBrightness: Brightness.light,
);

class CompanyColors {
  CompanyColors._();

  static MaterialColor primary = const MaterialColor(
    0xFF38BA8C,
    <int, Color>{
      50: Color(0x8038BA8C),
      100: Color(0x9938BA8C),
      200: Color(0xB338BA8C),
      300: Color(0xCC38BA8C),
      400: Color(0xE638BA8C),
      500: Color(0xFF38BA8C),
      600: Color(0xFF38BA8C),
      700: Color(0xFF38BA8C),
      800: Color(0xFF38BA8C),
      900: Color(0xFF38BA8C),
    },
  );

  static MaterialColor accent = const MaterialColor(
    0xFF6E6E6E,
    <int, Color>{
      50: Color(0x806E6E6E),
      100: Color(0x996E6E6E),
      200: Color(0xB36E6E6E),
      300: Color(0xCC6E6E6E),
      400: Color(0xE66E6E6E),
      500: Color(0xFF6E6E6E),
      600: Color(0xFF6E6E6E),
      700: Color(0xFF6E6E6E),
      800: Color(0xFF6E6E6E),
      900: Color(0xFF6E6E6E),
    },
  );
}
