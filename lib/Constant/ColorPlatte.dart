import 'dart:ui';

import 'package:flutter/material.dart';

class ColorPalette {
  // Primary Colors
  static const Color primary = Color(0xFF6200EE);
  static const Color primaryVariant = Color(0xFF3700B3);
  static const Color secondary = Color(0xFF03DAC6);
  static const Color secondaryVariant = Color(0xFF018786);

  // Background Colors
  static Color lightBackground = const Color(0xFFF5F5F5);
  static Color darkBackground = const Color(0xFF121212);

  // Surface Colors
  static Color lightSurface = Colors.white;
  static Color darkSurface = const Color(0xFF1E1E1E);

  // Error Colors
  static const Color error = Color(0xFFB00020);
  static const Color errorDark = Color(0xFFCF6679);

  // Text Colors
  static Color lightTextPrimary = Colors.black87;
  static Color lightTextSecondary = Colors.black54;
  static Color darkTextPrimary = Colors.white;
  static Color darkTextSecondary = Colors.white70;

  // Note Colors (Pastel shades that work well in both modes)
  static const List<Color> noteColors = [
    Color(0xFF80DEEA), // Soft Blue
    Color(0xFFFFCC80), // Soft Orange
    Color(0xFFE6EE9C), // Soft Green
    Color(0xFFCF94DA), // Soft Purple
    Color(0xFFFFAB91), // Soft Red
    Color(0xFFB0BEC5), // Soft Gray
  ];

  // Container Colors
  static Color containerLight = const Color(0xFFE3F2FD);
  static Color containerDark = const Color(0xFF1A237E).withOpacity(0.15);

  // Get dynamic container color based on theme
  static Color getContainerColor(bool isDarkMode) {
    return isDarkMode ? containerDark : containerLight;
  }

  // Get dynamic text color based on theme
  static Color getTextColor(bool isDarkMode, {bool isSecondary = false}) {
    if (isDarkMode) {
      return isSecondary ? darkTextSecondary : darkTextPrimary;
    }
    return isSecondary ? lightTextSecondary : lightTextPrimary;
  }

  // Get dynamic background color based on theme
  static Color getBackgroundColor(bool isDarkMode) {
    return isDarkMode ? darkBackground : lightBackground;
  }

  // Get dynamic surface color based on theme
  static Color getSurfaceColor(bool isDarkMode) {
    return isDarkMode ? darkSurface : lightSurface;
  }
}
