import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFFFFC107); // Amber
  static const Color secondary = Color(0xFFFFD54F); // Amber[300]
  static const Color honeyComb = Color(0xFFFFB300); // Amber[700]
  static const Color background = Color(0xFFFAFAFA);
  static const Color white = Colors.white;
  static const Color black = Colors.black;
  static const Color grey = Color(0xFF9E9E9E);
  static const Color darkGrey = Color(0xFF616161);
  static const Color lightGrey = Color(0xFFE0E0E0);
  static const Color error = Color(0xFFD32F2F);
  static const Color success = Color(0xFF388E3C);
  
  // Dark theme colors
  static const Color darkBackground = Color(0xFF303030);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2C2C2C);
  static const Color darkText = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFB0B0B0);
  
  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFFFC107),
      Color(0xFFFFD54F),
    ],
  );
  
  static const LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFF212121),
      Color(0xFF424242),
    ],
  );

  // Honey Theme Colors
  static const Color honeyGold = Color(0xFFFFB300);
  static const Color beeBlack = Color(0xFF212121);
  static const Color beeStripe = Color(0xFF424242);
} 