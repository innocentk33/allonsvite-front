import 'package:flutter/material.dart';

class AppColors {
  static const Color avGreen = Color(0xFFA6EB2E); // Brand Principal
  static const Color avGreenSub = Color(
    0xFFE4F9C0,
  ); // Brand Secondaire / Fond clair
  static const Color textPrimary = Color(0xFF031B1C); // Noir/Vert très foncé
  static const Color avWhite = Color(0xFFFFFFFF); // Blanc pur
  static const Color textSecondary = Color(0xFF374640); // Gris foncé
  static const Color avLightGrey = Color(0xFFF5F5F5); // Fond gris
  static const Color avOrange = Color(0xFFF2640E); // Accent / Action
  static const Color avRed = Color(0xFFFF0000); // Erreur
  static const Color borderColor = Color(0xFF98A3A3); // Bordure

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,

    // Couleur Principale ( Vert Lime)
    primary: avGreen,
    onPrimary: textPrimary,
    // Texte foncé sur le vert pour le contraste !

    // Container Principal ( Vert clair)
    primaryContainer: avGreenSub,
    onPrimaryContainer: textPrimary,

    // Container secondaire
    secondaryContainer: avLightGrey,
    onSecondaryContainer: textPrimary,

    // Secondaire ( Orange - Idéal pour les FAB ou actions secondaires)
    secondary: avOrange,
    onSecondary: Colors.white,
    // Texte blanc sur l'orange

    // Backgrounds & Surfaces
    surface: avWhite,
    onSurface: textPrimary,
    // Texte principal
    onSurfaceVariant: textSecondary,

    // Texte secondaire (sous-titres)
    outline: borderColor,
    // Utilisé pour les bordures
    outlineVariant: avLightGrey,
    // Utilisé pour les bordures discrètes

    // Erreurs
    error: avRed,
    onError: Colors.white,
  );
}
