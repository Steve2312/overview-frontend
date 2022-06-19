import 'package:flutter/material.dart';

// Background color for app & scaffoldBackground
Color appBarBackgroundColor = const Color(0xFF2A2B2D);
Color backgroundColor = const Color(0xFF202123);
Color cardColor = const Color(0xFF2A2B2D);
Color primaryColor = const Color(0xFF92B3F2);

Color appBarColor = Colors.white;
Color headLineColor = Colors.white;
Color bodyTextColor = Colors.white70;
Color subtitleColor = Colors.white70;

Color shadowColor = Colors.black.withOpacity(0.2);

Color hintColor = Colors.white54;
Color labelColor = Colors.white;

ThemeData darkTheme = ThemeData.dark().copyWith(
  primaryColor: primaryColor,
  backgroundColor: backgroundColor,
  scaffoldBackgroundColor: backgroundColor,
  cardColor: cardColor,
  colorScheme: const ColorScheme.dark().copyWith(
    surface: backgroundColor,
    primary: primaryColor,
    onSurface: bodyTextColor,
  ),
  dialogBackgroundColor: backgroundColor,
  textTheme: TextTheme(
    headline1: TextStyle(
      color: headLineColor,
      fontSize: 20,
      fontWeight: FontWeight.w600,
    ),
    bodyText1: TextStyle(
      color: bodyTextColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    headline2: TextStyle(
      color: headLineColor,
      fontSize: 15,
      fontWeight: FontWeight.w600,
    ),
    subtitle1: TextStyle(
      color: subtitleColor,
      fontSize: 12,
      fontWeight: FontWeight.w600,
    ),
  ),
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: appBarBackgroundColor,
    titleTextStyle: TextStyle(
      color: appBarColor,
      fontSize: 17,
      fontWeight: FontWeight.w600,
    ),
    iconTheme: IconThemeData(
      color: appBarColor,
    ),
    shadowColor: shadowColor,
  ),
  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      primary: primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18.0),
      ),
      side: BorderSide(
        width: 1,
        color: primaryColor,
      ),
    ),
  ),
  inputDecorationTheme: InputDecorationTheme(
    hintStyle: TextStyle(
      color: hintColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
    labelStyle: TextStyle(
      color: labelColor,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  ),
);
