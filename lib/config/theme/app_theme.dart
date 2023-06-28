import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData getAppTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: const Color.fromARGB(255, 255, 230, 0),
      brightness: Brightness.light);
}
