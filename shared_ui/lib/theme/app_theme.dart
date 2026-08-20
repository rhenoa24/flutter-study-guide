import 'package:flutter/material.dart';

class AppTheme {
  AppTheme._();

  static ThemeData get darkTheme {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Color(0xFF007236),
        brightness: Brightness.dark,
        dynamicSchemeVariant: DynamicSchemeVariant.fidelity,
      ),
      fontFamily: 'Roboto',
    );
  }
}
