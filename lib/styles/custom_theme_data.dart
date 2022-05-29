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

    // Input theme
    inputDecorationTheme: InputDecorationTheme(
      border: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
      ),
      enabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
      ),
      disabledBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white),
        borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
      ),
      focusedBorder: const OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white, width: 2.0),
        borderRadius: BorderRadius.all(Radius.elliptical(15, 15)),
      ),
      prefixIconColor: Colors.white.withOpacity(0.5),
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
      contentPadding: const EdgeInsets.only(left: 40.0, top: 20.0, right: 20.0, bottom: 20.0),
    ),
  );
}
