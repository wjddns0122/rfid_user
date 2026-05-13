import 'package:flutter/material.dart';

class AppTheme {
  static const Color primary = Color(0xFF4C30C3);
  static const Color primaryDark = Color(0xFF7E22CE);
  static const Color background = Colors.white;
  static const Color surfaceGray = Color(0xFFF3F4F6);
  static const Color surfaceLightGray = Color(0xFFF9FAFB);
  static const Color borderGray = Color(0xFFE5E7EB);
  
  static const Color textMain = Color(0xFF111827);
  static const Color textSub = Color(0xFF4B5563);
  static const Color textHint = Color(0xFF9CA3AF);

  static const Color accentYellow = Color(0xFFFFCC00);
  static const Color statusGreen = Color(0xFF22C55E);

  static ThemeData get themeData {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primary,
        background: background,
        surface: Colors.white,
      ),
      scaffoldBackgroundColor: background,
      fontFamily: 'Pretendard',
    );
  }
}
