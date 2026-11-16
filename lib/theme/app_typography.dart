import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ALVARAN Typography System
/// Headings: Lora (elegant serif)
/// Body & UI: Plus Jakarta Sans (clean, modern sans-serif)
class AppTypography {
  AppTypography._();

  static const String loraFamily = 'Lora';
  static const String sansFamily = 'Plus Jakarta Sans';
  static const List<String> serifFallback = ['Lora', 'Georgia', 'serif'];
  static const List<String> sansFallback = ['Plus Jakarta Sans', 'Inter', 'Roboto', 'sans-serif'];

  // Headings (Lora)
  static TextStyle get displayLarge => const TextStyle(
        fontFamily: loraFamily,
        fontFamilyFallback: serifFallback,
        fontSize: 32,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        letterSpacing: -0.5,
        height: 1.2,
      );

  static TextStyle get displayMedium => const TextStyle(
        fontFamily: loraFamily,
        fontFamilyFallback: serifFallback,
        fontSize: 26,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
        height: 1.25,
      );

  static TextStyle get displaySmall => const TextStyle(
        fontFamily: loraFamily,
        fontFamilyFallback: serifFallback,
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get headlineLarge => const TextStyle(
        fontFamily: loraFamily,
        fontFamilyFallback: serifFallback,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineMedium => const TextStyle(
        fontFamily: loraFamily,
        fontFamilyFallback: serifFallback,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get headlineSmall => const TextStyle(
        fontFamily: loraFamily,
        fontFamilyFallback: serifFallback,
        fontSize: 16,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // Body & UI (Plus Jakarta Sans)
  static TextStyle get bodyLarge => const TextStyle(
        fontFamily: sansFamily,
        fontFamilyFallback: sansFallback,
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontFamily: sansFamily,
        fontFamilyFallback: sansFallback,
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondary,
        height: 1.45,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontFamily: sansFamily,
        fontFamilyFallback: sansFallback,
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: AppColors.textMuted,
        height: 1.4,
      );

  // Titles & Labels (Plus Jakarta Sans)
  static TextStyle get titleLarge => const TextStyle(
        fontFamily: sansFamily,
        fontFamilyFallback: sansFallback,
        fontSize: 16,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimary,
      );

  static TextStyle get titleMedium => const TextStyle(
        fontFamily: sansFamily,
        fontFamilyFallback: sansFallback,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  static TextStyle get titleSmall => const TextStyle(
        fontFamily: sansFamily,
        fontFamilyFallback: sansFallback,
        fontSize: 12,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      );

  // Special Accents & Buttons
  static TextStyle get greetingTag => const TextStyle(
        fontFamily: sansFamily,
        fontFamilyFallback: sansFallback,
        fontSize: 11,
        fontWeight: FontWeight.w800,
        color: AppColors.gold,
        letterSpacing: 1.2,
      );

  static TextStyle get buttonText => const TextStyle(
        fontFamily: sansFamily,
        fontFamilyFallback: sansFallback,
        fontSize: 15,
        fontWeight: FontWeight.w700,
        color: AppColors.white,
        letterSpacing: 0.2,
      );

  static TextStyle get priceLarge => const TextStyle(
        fontFamily: sansFamily,
        fontFamilyFallback: sansFallback,
        fontSize: 20,
        fontWeight: FontWeight.w800,
        color: AppColors.textPrimary,
      );

  static TextStyle get badgeText => const TextStyle(
        fontFamily: sansFamily,
        fontFamilyFallback: sansFallback,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      );
}
