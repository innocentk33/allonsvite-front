import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTypography {
  static const String _fontHeadings = 'Jokker';

  // On utilise un "getter" car GoogleFonts n'est pas une constante
  static TextTheme get textTheme {
    return TextTheme(
      // --- TITRES & BOUTONS (JOKKER - Local) ---
      displayLarge: TextStyle(fontFamily: _fontHeadings, fontSize: 57, fontWeight: FontWeight.bold),
      displayMedium: TextStyle(fontFamily: _fontHeadings, fontSize: 45, fontWeight: FontWeight.bold),
      displaySmall: TextStyle(fontFamily: _fontHeadings, fontSize: 36, fontWeight: FontWeight.bold),

      headlineLarge: TextStyle(fontFamily: _fontHeadings, fontSize: 32, fontWeight: FontWeight.w600),
      headlineMedium: TextStyle(fontFamily: _fontHeadings, fontSize: 28, fontWeight: FontWeight.w600),
      headlineSmall: TextStyle(fontFamily: _fontHeadings, fontSize: 24, fontWeight: FontWeight.w600),

      titleLarge: TextStyle(fontFamily: _fontHeadings, fontSize: 22, fontWeight: FontWeight.w500),
      titleMedium: TextStyle(fontFamily: _fontHeadings, fontSize: 16, fontWeight: FontWeight.w500),
      titleSmall: TextStyle(fontFamily: _fontHeadings, fontSize: 14, fontWeight: FontWeight.w500),

      // BOUTONS (Jokker)
      labelLarge: TextStyle(fontFamily: _fontHeadings, fontSize: 14, fontWeight: FontWeight.bold),
      labelMedium: TextStyle(fontFamily: _fontHeadings, fontSize: 12, fontWeight: FontWeight.w500),
      labelSmall: TextStyle(fontFamily: _fontHeadings, fontSize: 11, fontWeight: FontWeight.w500),

      // --- CORPS DE TEXTE (INTER - Google Fonts) ---
      bodyLarge: GoogleFonts.inter(
          fontSize: 16,
          fontWeight: FontWeight.normal
      ),
      bodyMedium: GoogleFonts.inter(
          fontSize: 14,
          fontWeight: FontWeight.normal
      ),
      bodySmall: GoogleFonts.inter(
          fontSize: 12,
          fontWeight: FontWeight.normal
      ),

    );
  }
}