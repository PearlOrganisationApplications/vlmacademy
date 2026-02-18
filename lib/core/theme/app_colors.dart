import 'package:flutter/material.dart';
import 'dart:ui';

class AppColors {
  // Primary Colors - Blue (Figma: blue1)
  static const Color primary = Color(0xFF2F80FF); // Figma 0%  stop
  static const Color primaryDark = Color(0xFF1A6FE8); // darker shade
  static const Color primaryLight = Color(0xFF56CCF2); // Figma 100% stop
  static const Color primaryLighter = Color(0xFFB3E8FB); // tint

  // Secondary Colors - Vibrant Amber
  static const Color secondary = Color(0xFFF59E0B);
  static const Color secondaryDark = Color(0xFFD97706);
  static const Color secondaryLight = Color(0xFFFBBF24);

  // Accent Colors - Emerald
  static const Color accent = Color(0xFF10B981);
  static const Color accentDark = Color(0xFF059669);
  static const Color accentLight = Color(0xFF34D399);

  // Semantic Colors
  static const Color success = Color(0xFF10B981);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Neutral Colors - Light Theme
  static const Color backgroundLight = Color(0xFFF9FAFB);
  static const Color surfaceLight = Color(0xFFFFFFFF);
  static const Color textPrimaryLight = Color(0xFF111827);
  static const Color textSecondaryLight = Color(0xFF6B7280);
  static const Color borderLight = Color(0xFFE5E7EB);
  static const Color dividerLight = Color(0xFFF3F4F6);

  // Neutral Colors - Dark Theme
  static const Color backgroundDark = Color(0xFF000000);
  static const Color surfaceDark = Color(0xFF1E293B);
  static const Color surfaceDarkElevated = Color(0xFF334155);
  static const Color textPrimaryDark = Color(0xFFF1F5F9);
  static const Color textSecondaryDark = Color(0xFF94A3B8);
  static const Color borderDark = Color(0xFF475569);
  static const Color dividerDark = Color(0xFF334155);

  // Role-specific Colors
  static const Color studentColor = Color(0xFF3B82F6);
  static const Color teacherColor = Color(0xFF8B5CF6);
  static const Color parentColor = Color(0xFFEC4899);

  // Feature Colors
  static const Color walletGreen = Color(0xFF10B981);
  static const Color rewardGold = Color(0xFFFBBF24);
  static const Color streakOrange = Color(0xFFF97316);
  static const Color liveRed = Color(0xFFEF4444);
  static const Color premiumPurple = Color(0xFF8B5CF6);

  // Glassmorphism
  static const Color glassLight = Color(0x40FFFFFF);
  static const Color glassDark = Color(0x40000000);
  static const Color glassBlur = Color(0x20FFFFFF);

  // Gradients - Primary (Figma: blue1 — #2F80FF → #56CCF2)
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF2F80FF), Color(0xFF56CCF2)],
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
  );

  static const LinearGradient primaryGradientVertical = LinearGradient(
    colors: [Color(0xFF2F80FF), Color(0xFF56CCF2)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  // Gradients - Secondary
  static const LinearGradient secondaryGradient = LinearGradient(
    colors: [Color(0xFFF59E0B), Color(0xFFFBBF24)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradients - Success
  static const LinearGradient successGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF34D399)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradients - Wallet
  static const LinearGradient walletGradient = LinearGradient(
    colors: [Color(0xFF10B981), Color(0xFF34D399), Color(0xFF6EE7B7)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradients - Error/Live
  static const LinearGradient errorGradient = LinearGradient(
    colors: [Color(0xFFEF4444), Color(0xFFF87171)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradients - Reward
  static const LinearGradient rewardGradient = LinearGradient(
    colors: [Color(0xFFFBBF24), Color(0xFFFCD34D), Color(0xFFFDE68A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradients - Premium
  static const LinearGradient premiumGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFA78BFA), Color(0xFFC4B5FD)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradients - Student
  static const LinearGradient studentGradient = LinearGradient(
    colors: [Color(0xFF3B82F6), Color(0xFF60A5FA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Gradients - Teacher
  static const LinearGradient teacherGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFFA78BFA)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Overlay Colors
  static const Color overlay = Color(0x80000000);
  static const Color overlayLight = Color(0x40000000);
  static const Color shimmerBase = Color(0xFFE0E0E0);
  static const Color shimmerHighlight = Color(0xFFF5F5F5);

  // Shadow Colors
  static Color shadowLight = Colors.black.withOpacity(0.08);
  static Color shadowMedium = Colors.black.withOpacity(0.12);
  static Color shadowHeavy = Colors.black.withOpacity(0.16);
}
