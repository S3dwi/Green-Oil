import 'package:flutter/material.dart';

// Light theme
final themeLight = ThemeData(
  useMaterial3: true,
  colorScheme: colorSchemeLight,
  scaffoldBackgroundColor: const Color(0xFFF8F8F8),
  disabledColor: const Color(0xFFA9A9AC),
  fontFamily: 'Lato',
  shadowColor: Colors.black.withOpacity(0.24),
  iconTheme: IconThemeData(
    color: const Color(0xFF47AB4D),
  ),
);

// Light theme color scheme
final colorSchemeLight = ColorScheme.fromSeed(
    brightness: Brightness.light, // Theme brightness: light or dark
    seedColor: Color(0xFF47AB4D),
    primary: Color(0xFF47AB4D),
    // Main color used for primary interactive elements
    onPrimary: Colors.white, //  Component color

    secondary: Color(0xFF000000), // Text/icon color
    onSecondary: Colors.white, // Text color

    error: Colors.red, // Error color for showing validation issues

    surface: Color.fromARGB(0, 255, 255, 255),

    //gredient colors
    surfaceContainer: Color(0xFF529C57),
    surfaceContainerHigh: Color(0xFF6DB571),
    surfaceContainerHighest: Color(0xFFA1D5A4));

///////////////////////////////////////////////////////////////////
///////////////////////////////////////////////////////////////////

// Dark theme
final ThemeData themeDark = ThemeData(
  useMaterial3: true,
  colorScheme: colorSchemeDark,
  scaffoldBackgroundColor: const Color(0xFF1E1F20),
  disabledColor: const Color(0xFFA9A9AC),
  fontFamily: 'Lato',
  shadowColor: Colors.black.withOpacity(0.5),
  iconTheme: IconThemeData(
    color: const Color(0xFF47AB4D),
  ),
);

// Dark theme color scheme
final colorSchemeDark = ColorScheme.fromSeed(
  brightness: Brightness.dark, // Theme brightness: light or dark
  seedColor: Color(0xFF47AB4D),

  primary: Color(0xFF47AB4D),
  // Main color used for primary interactive elements
  onPrimary: const Color(0xFF282A2C), //  Component color

  secondary: Color.fromARGB(255, 255, 255, 255),
  // Text/icon color
  onSecondary: Colors.white, // Text color

  error: Color(0xFFCF6679), // Error color for showing validation issues

  surface: Color.fromARGB(0, 255, 255, 255),
  //gredient colors
  surfaceContainer: const Color(0xFF5F885F),
  surfaceContainerHigh: Color(0xFF435A42),
  surfaceContainerHighest: Color(0xFF233123),
);
