import 'package:flutter/material.dart';

final ThemeData companyTheme = ThemeData(
  primarySwatch: CompanyColors.primary,
  primaryColor: CompanyColors.primary[700],
  primaryColorBrightness: Brightness.light,
  accentColor: CompanyColors.accent[500],
  scaffoldBackgroundColor: Colors.white,
  fontFamily: 'Lato',
);

class CompanyColors {
  CompanyColors._();

  static MaterialColor primary = const MaterialColor(
    0xFF38BA8C,
    <int, Color>{
      20: Color(0xFF00300f),
      30: Color(0xFF005b35),
      40: Color(0xFF00895f),
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
      1000: Color(0xFF71edbc),
      1100: Color(0xFFA6FFEF),
      1200: Color(0xFFA6FFEF),
      1300: Color(0xFFDAFFFF),
    },
  );

  static MaterialColor accent = const MaterialColor(
    0xFF6E6E6E,
    <int, Color>{
      50: Color(0x806E6E6E),
      100: Color(0x996E6E6E),
      200: Color(0xB36E6E6E),
      300: Color(0xFF925900),
      400: Color(0xFFc88619),
      500: Color(0xFFFFB64D),
      600: Color(0xFFffe87d),
      700: Color(0xFFffffae),
      800: Color(0xFF6E6E6E),
      900: Color(0xFF6E6E6E),
    },
  );
}
