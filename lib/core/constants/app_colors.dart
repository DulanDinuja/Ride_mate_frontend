import 'package:flutter/material.dart';

/// Application color palette
/// Dark navy blue theme with coral accents
class AppColors {
  // Primary Colors (Dark Navy Blue)
  static const Color primary = Color(0xFF1A1A2E); // Default: dark navy blue
  static const Color primaryLight = Color(0xFF16213E); // Lighter navy
  static const Color primaryDark = Color(0xFF0F0F1E); // Darker navy

  // Secondary Colors (Deep Blue)
  static const Color secondary = Color(0xFF0F3460); // Default: deep blue
  static const Color secondaryLight = Color(0xFF16527A); // Lighter blue
  static const Color secondaryDark = Color(0xFF0A2342); // Darker blue

  // Accent Colors (Coral Red/Pink)
  static const Color accent = Color(0xFFE94560); // Default: coral red/pink
  static const Color accentLight = Color(0xFFFF6B88); // Lighter pink
  static const Color accentDark = Color(0xFFC72E4A); // Darker red

  // Additional Colors
  static const Color background = Color(0xFF0A0A0F); // Very dark background
  static const Color surface = Color(0xFF1A1A2E); // Surface color (matches primary)
  static const Color surfaceLight = Color(0xFF16213E); // Light surface

  // Text Colors
  static const Color textPrimary = Color(0xFFFFFFFF); // White
  static const Color textSecondary = Color(0xFFB0B0B0); // Light gray
  static const Color textTertiary = Color(0xFF808080); // Medium gray

  // Highlight Colors
  static const Color cyan = Color(0xFF00F7FF); // Cyan/aqua for highlights
  static const Color cyanBright = Color(0xFF00D4FF); // Bright cyan for hovers
  static const Color blueViolet = Color(0xFF8A2BE2); // Blue violet/purple
  static const Color purple = Color(0xFF7019CC); // Purple for gradient hover

  // Status Colors
  static const Color success = Color(0xFF4CAF50); // Green
  static const Color warning = Color(0xFFFF9800); // Orange
  static const Color error = Color(0xFFE94560); // Using accent color
  static const Color info = Color(0xFF00F7FF); // Using cyan

  // Opacity variants
  static Color primaryWithOpacity(double opacity) => primary.withOpacity(opacity);
  static Color accentWithOpacity(double opacity) => accent.withOpacity(opacity);
  static Color cyanWithOpacity(double opacity) => cyan.withOpacity(opacity);

  // Gradient colors
  static const List<Color> primaryGradient = [
    primary,
    secondary,
  ];

  static const List<Color> accentGradient = [
    accent,
    accentLight,
  ];

  static const List<Color> cyanGradient = [
    cyan,
    cyanBright,
  ];

  static const List<Color> purpleGradient = [
    blueViolet,
    purple,
  ];

  static const List<Color> vibrantGradient = [
    blueViolet,
    cyan,
  ];
}
