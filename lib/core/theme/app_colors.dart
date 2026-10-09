import 'package:flutter/material.dart';

/// Every color used in the app, so nothing is hard-coded in widgets.
abstract final class AppColors {
  static const Color seed = Color(0xFF00695C);
  static const Color primary = Color(0xFF00695C);
  static const Color primaryDark = Color(0xFF004D40);

  static const Color background = Color(0xFFF5F7F6);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color divider = Color(0xFFE6EAE8);

  static const Color textPrimary = Color(0xFF16201E);
  static const Color textSecondary = Color(0xFF6B7774);

  static const Color white = Color(0xFFFFFFFF);
  static const Color whiteMuted = Color(0xCCFFFFFF);
  static const Color whiteOverlay = Color(0x33FFFFFF);
  static const Color black = Color(0xFF000000);

  static const Color expense = Color(0xFFD32F2F);
  static const Color income = Color(0xFF2E7D32);
  static const Color favorite = Color(0xFFF9A825);
  static const Color favoriteInactive = Color(0xFF9AA5A2);

  static const Color food = Color(0xFFEF6C00);
  static const Color transport = Color(0xFF1565C0);
  static const Color shopping = Color(0xFF8E24AA);
  static const Color bills = Color(0xFF00838F);
  static const Color salary = Color(0xFF2E7D32);

  static const List<Color> cardGradientTeal = [
    Color(0xFF00897B),
    Color(0xFF004D40),
  ];
  static const List<Color> cardGradientIndigo = [
    Color(0xFF5C6BC0),
    Color(0xFF283593),
  ];
  static const List<Color> cardGradientSunset = [
    Color(0xFFFB8C00),
    Color(0xFFD84315),
  ];
}
