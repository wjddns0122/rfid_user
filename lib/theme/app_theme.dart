import 'package:flutter/material.dart';

class AppTheme {
  // Colors - Figma 디자인 기반 색상 추출
  static const Color primaryColor = Color(0xFF6F34FF); // 중앙 아이콘 배경 보라색
  static const Color primaryLight = Color(0xFFE2D9FF);
  static const Color primaryExtraLight = Color(0xFFF4F5FA);

  static const Color textPrimary = Color(0xFF111111);
  static const Color textSecondary = Color(0xFF767676);
  static const Color background = Colors.white;

  static const Color primary = primaryColor;
  static const Color cartPrimary = Color(0xFF6347C6);
  static const Color cartPrimarySoft = Color(0xFFEEF2FF);
  static const Color primaryDark = Color(0xFF7E22CE);
  static const Color surfaceGray = Color(0xFFF3F4F6);
  static const Color surfaceLightGray = Color(0xFFF9FAFB);
  static const Color borderGray = Color(0xFFE5E7EB);
  static const Color borderSubtle = Color(0xFFF0F0F0);

  static const Color textMain = Color(0xFF111827);
  static const Color textSub = Color(0xFF4B5563);
  static const Color textHint = Color(0xFF9CA3AF);

  static const Color accentYellow = Color(0xFFFFCC00);
  static const Color statusGreen = Color(0xFF22C55E);
  static const Color successText = Color(0xFF16A34A);
  static const Color successSurface = Color(0xFFF0FDF4);
  static const Color successBorder = Color(0xFFBBF7D0);

  static ThemeData get themeData => lightTheme;

  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: primaryColor,
        primary: primaryColor,
        surface: background,
      ),
      scaffoldBackgroundColor: background,
      fontFamily: 'Pretendard',
      appBarTheme: const AppBarTheme(
        backgroundColor: background,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: textPrimary),
        titleTextStyle: TextStyle(
          color: textPrimary,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
      ),
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: -0.5,
        ),
        bodyMedium: TextStyle(fontSize: 16, color: textSecondary),
      ),
    );
  }

  static String getProductImageUrl(String title) {
    if (title.contains('해링턴')) {
      return 'https://media.bunjang.co.kr/product/303934322_1_1733212719_w360.jpg';
    } else if (title.contains('Jordan') || title.contains('신발') || title.contains('스니커')) {
      return 'assets/images/real_image/jordan.jpg';
    } else if (title.contains('흰 반팔')) {
      return 'assets/images/real_image/white_shirt.jpeg';
    } else if (title.contains('오아시스')) {
      return 'assets/images/real_image/oasis_shirt.jpg';
    } else if (title.contains('벨리에') || title.contains('청셔츠')) {
      return 'assets/images/real_image/black_white_shirt.jpg';
    } else if (title.contains('슈프림')) {
      return 'assets/images/real_image/supreme_cap.jpeg';
    } else if (title.contains('갭 모자')) {
      return 'assets/images/real_image/gap_cap.jpeg';
    } else if (title.contains('블레이저') ||
        title.contains('재킷') ||
        title.contains('자켓') ||
        title.contains('아우터')) {
      return 'https://images.unsplash.com/photo-1591047139829-d91aecb6caea?w=500';
    } else if (title.contains('후드') || title.contains('스웨트셔츠') || title.contains('티셔츠')) {
      return 'https://images.unsplash.com/photo-1556821840-3a63f95609a7?w=500';
    } else if (title.contains('팬츠') || title.contains('데님') || title.contains('바지')) {
      return 'https://images.unsplash.com/photo-1542272604-787c3835535d?w=500';
    } else if (title.contains('볼캡') || title.contains('모자') || title.contains('캡')) {
      return 'https://images.unsplash.com/photo-1588850561407-ed78c282e89b?w=500';
    }
    // Fallback general clothing image
    return 'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=500';
  }

  /// asset 경로면 AssetImage, 아니면 NetworkImage. 호출부 Image(image:)에 사용.
  static ImageProvider productImageProvider(String title) {
    final src = getProductImageUrl(title);
    if (src.startsWith('assets/')) {
      return AssetImage(src);
    }
    return NetworkImage(src);
  }
}
