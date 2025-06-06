import 'package:flutter/material.dart';

abstract final class AppColors {
  static const active = Color.fromRGBO(183, 178, 169, 1);

  static const bg = Color.fromRGBO(31, 36, 45, 1);

  static const darkColorScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color.fromRGBO(31, 36, 45, 1),
    onPrimary: Colors.white,
    primaryContainer: Color.fromRGBO(31, 36, 45, 1),
    onPrimaryContainer: Colors.white,
    secondary: Color.fromRGBO(31, 36, 45, 1),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.yellow,
    surface: Color.fromRGBO(31, 36, 45, 1),
    onSurface: Colors.white,
  );
  static const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color.fromRGBO(31, 36, 45, 1),
    primaryContainer: Color.fromRGBO(31, 36, 45, 1),
    onPrimary: Colors.white,
    onPrimaryContainer: Colors.white,
    secondary: Color.fromRGBO(31, 36, 45, 1),
    onSecondary: Colors.white,
    error: Colors.red,
    onError: Colors.yellow,
    surface: Color.fromRGBO(31, 36, 45, 1),
    onSurface: Colors.white,
  );
}
