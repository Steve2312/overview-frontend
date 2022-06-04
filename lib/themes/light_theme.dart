import 'package:flutter/material.dart';

ThemeData lightTheme = ThemeData.light().copyWith(
  primaryColor: const Color(0xffFE5858),
  backgroundColor: Colors.white,
  scaffoldBackgroundColor: Colors.white,
  cardColor: const Color(0xffFE5858),
  textTheme: TextTheme(
    headline1: const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
    headline2: const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    bodyText1: TextStyle(
      color: Colors.black.withOpacity(0.7),
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    subtitle1: TextStyle(
      color: Colors.black.withOpacity(0.7),
      fontSize: 12,
      fontWeight: FontWeight.bold,
    ),
  ),
  appBarTheme: const AppBarTheme().copyWith(
    backgroundColor: Colors.white,
    titleTextStyle: const TextStyle(
      color: Colors.black,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
    iconTheme: const IconThemeData(
      color: Colors.black,
    ),
    shadowColor: Colors.black.withOpacity(0.1),
  ),
);
