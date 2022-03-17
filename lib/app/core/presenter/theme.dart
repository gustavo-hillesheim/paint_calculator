import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData get lightTheme {
    const primaryColor = Colors.deepPurple;
    final backgroundColor = Colors.grey.shade50;
    const onBackgroundColor = Colors.black87;

    return ThemeData(
      brightness: Brightness.light,
      colorScheme: ColorScheme.light(
        primary: primaryColor,
        background: backgroundColor,
        onBackground: onBackgroundColor,
        surface: backgroundColor,
        onSurface: onBackgroundColor,
      ),
      textTheme: const TextTheme().apply(
        bodyColor: onBackgroundColor,
        displayColor: onBackgroundColor,
      ),
      appBarTheme: const AppBarTheme(
        elevation: 0,
        color: Colors.transparent,
        foregroundColor: onBackgroundColor,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        border: OutlineInputBorder(),
      ),
    );
  }
}
