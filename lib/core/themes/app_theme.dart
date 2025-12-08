import 'package:allonsvite/core/themes/app_spacing.dart';
import 'package:flutter/material.dart';
import 'app_colors.dart';
import 'app_typography.dart';

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: AppColors.lightScheme,
      scaffoldBackgroundColor: AppColors.lightScheme.surface,
      // Ou _avLightGrey

      // Typographie
      textTheme: AppTypography.textTheme.apply(
        bodyColor: AppColors.lightScheme.onSurface,
        displayColor: AppColors.lightScheme.onSurface,
      ),

      // --- CONFIGURATION DES BOUTONS ---

      // Boutons principaux (Fond Vert, Texte Noir)
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.lightScheme.primary,
          foregroundColor: AppColors.lightScheme.onPrimary,
          // Texte noir automatique
          elevation: 0,
          textStyle: AppTypography.textTheme.labelLarge,
          // Utilise Jokker Bold
          padding: const EdgeInsets.symmetric(horizontal: AppSpacings.l, vertical: AppSpacings.m),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacings.brL,
          ),
        ),
      ),

      // Boutons secondaires (Fond blanc, bordure ou texte couleur)
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.lightScheme.onSurface,
          textStyle: AppTypography.textTheme.labelLarge,
          side: BorderSide(color: AppColors.lightScheme.outline),
          padding: const EdgeInsets.symmetric(horizontal: AppSpacings.l, vertical: AppSpacings.m),
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacings.brL,
          ),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacings.l, vertical: AppSpacings.m),
          backgroundColor: AppColors.lightScheme.secondaryContainer,
          textStyle: AppTypography.textTheme.labelLarge,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: AppSpacings.brL,
          ),
        ),
      ),

      // AppBar
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.lightScheme.surface,
        foregroundColor: AppColors.lightScheme.onSurface,
        elevation: 0,
        centerTitle: true,
        titleTextStyle: AppTypography.textTheme.titleLarge,
      ),
    );
  }
}
