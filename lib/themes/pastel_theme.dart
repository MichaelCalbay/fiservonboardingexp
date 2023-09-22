import 'package:flutter/material.dart';

//light mode.
final ThemeData pastelTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: const ColorScheme.light(
    background: Color(0xFFfdf6f6), // Background.
    onBackground: Color.fromARGB(255, 238, 190, 169), // Tiles.
    tertiary: Color(0xFFc0d8e3), // App/nav bars.
    primary: Color.fromARGB(255, 228, 132, 116), // Main text colour.
    secondary: Color(0xFFa78d8a), // Headings.
  ),
);
