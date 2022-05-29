import 'package:flutter/material.dart';

class CustomThemeData {
  ThemeData apply = ThemeData(
    useMaterial3: true,

    // Default theme colors
    primarySwatch: Colors.blue,

    // AppBar theme
    appBarTheme: const AppBarTheme(
      titleTextStyle: TextStyle(color: Colors.white),
      toolbarTextStyle: TextStyle(color: Colors.white),
      backgroundColor: Colors.transparent,
      shadowColor: Colors.transparent,
      actionsIconTheme: IconThemeData(color: Colors.white),
      iconTheme: IconThemeData(color: Colors.white),
    ),

    // Button theme
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.white),
      ),
    ),

    // Text theme
    textTheme: const TextTheme(
      button: TextStyle(color: Colors.white),
      bodyText1: TextStyle(color: Colors.white),
      bodyText2: TextStyle(color: Colors.white),
    ),

    // Input cursor color
    textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.white),

    // Icon color
    iconTheme: const IconThemeData(
      color: Colors.white
    ),
  );
}
