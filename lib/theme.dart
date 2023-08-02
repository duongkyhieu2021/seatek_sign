import 'package:flutter/material.dart';

class ThemeApp {
  static ThemeData light() {
    return ThemeData(
      fontFamily: "Roboto",
      scaffoldBackgroundColor: const Color(0xFFFBFBFB),
      primaryColor: const Color(0xFF015785),
      appBarTheme: const AppBarTheme(
        backgroundColor: Color(0xFF015785),
      ),
    );
  }

  static TextStyle textStyle(
      {double? fontSize, FontWeight? fontWeight, Color? color}) {
    return TextStyle(
      fontSize: fontSize ?? 16,
      fontWeight: fontWeight,
      color: color,
    );
  }
}
