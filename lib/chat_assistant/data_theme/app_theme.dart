import 'package:flutter/material.dart';

import '../config/color.dart';

class AppTheme {
  static ColorScheme darkTheme = const ColorScheme.dark(
    primary: darkGround, //appBar fon
    //Color(0xFFF8D028),
    onPrimary: yellow,
    primaryContainer: Color(0xFFD0C000),
    onPrimaryContainer: Color(0xFF333333),
    secondary: yellow,
    onSecondary: ground,
    secondaryContainer: Color(0xFFF0A000),
    onSecondaryContainer: red,
    error: red,
    onError: red,
    errorContainer: red,
    onErrorContainer: Color(0xFFF9DEDC),
    outline: Color(0xFF938F99),
    background: ground,
    onBackground: Color(0xFFF3F3F3),
    surface: ground,
    onSurface: Color(0xFF3d4533),//orange, //надпись Gptik
    surfaceVariant: Color(0xFF49454F),
    onSurfaceVariant: orange,
  );

  static ColorScheme lightTheme = ColorScheme.light(
    primary: grey,
    onPrimary: Color(0xFF3d4533), //text appBar
    //primaryContainer: Color(0xFFFDD943),
    onPrimaryContainer: Color(0xFF333333),
    secondary: lightGray,
    onSecondary: lightGray,
    secondaryContainer: orange,
    onSecondaryContainer: Color(0xFF333333),
    error: red,
    onError: red,
    errorContainer: red,
    onErrorContainer: Color(0xFFF9DEDC),
    outline: Color(0xFF6F6D73),
    background: grey,
    onBackground: Color(0xFF333333),
    surface: grey,
    onSurface: Color(0xFF333333),
    surfaceVariant: Color(0xFF57545B),
    onSurfaceVariant: Color(0xFF3d4533),
  );

  static final light = ThemeData(
    useMaterial3: true,
    fontFamily: 'Segoe UI',
    colorScheme: lightTheme,
  );
  static final dark = ThemeData(
    useMaterial3: true,
    fontFamily: 'Segoe UI',
    colorScheme: darkTheme,
  );
}