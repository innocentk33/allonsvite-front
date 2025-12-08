import 'package:flutter/material.dart';

class AppColors {
  // --- VOS COULEURS DEFINIES ---
  static const Color _avGreen = Color(0xFFA6EB2E);      // Brand Principal
  static const Color _avGreenSub = Color(0xFFE4F9C0);   // Brand Secondaire / Fond clair
  static const Color _textPrimary = Color(0xFF031B1C);  // Noir/Vert très foncé
  static const Color _avWhite = Color(0xFFFFFFFF);      // Blanc pur
  static const Color _textSecondary = Color(0xFF374640);// Gris foncé
  static const Color _avLightGrey = Color(0xFFF5F5F5);  // Fond gris
  static const Color _avOrange = Color(0xFFF2640E);     // Accent / Action
  static const Color _avRed = Color(0xFFFF0000);        // Erreur
  static const Color _borderColor = Color(0xFF98A3A3);  // Bordure

  static const ColorScheme lightScheme = ColorScheme(
    brightness: Brightness.light,

    // Couleur Principale ( Vert Lime)
    primary: _avGreen,
    onPrimary: _textPrimary, // Texte foncé sur le vert pour le contraste !

    // Container Principal ( Vert clair)
    primaryContainer: _avGreenSub,
    onPrimaryContainer: _textPrimary,

    // Container secondaire
    secondaryContainer: _avLightGrey,
    onSecondaryContainer: _textPrimary,


    // Secondaire ( Orange - Idéal pour les FAB ou actions secondaires)
    secondary: _avOrange,
    onSecondary: Colors.white, // Texte blanc sur l'orange

    // Backgrounds & Surfaces
    surface: _avWhite,
    onSurface: _textPrimary,      // Texte principal
    onSurfaceVariant: _textSecondary, // Texte secondaire (sous-titres)


    outline: _borderColor, // Utilisé pour les bordures
    outlineVariant: _avLightGrey, // Utilisé pour les bordures discrètes



    // Erreurs
    error: _avRed,
    onError: Colors.white,
  );
}