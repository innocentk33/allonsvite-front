import 'package:flutter/material.dart';
import '../../l10n/app_localizations.dart';

extension BuildContextExtensions on BuildContext {
  //Accès direct aux traductions
  AppLocalizations get l10n {
    return AppLocalizations.of(this)!;
  }

  ///  Raccourcis pour Design System

  // Accès direct aux couleurs (ColorScheme)
  // Utilisation : context.colors.primary
  ColorScheme get colorScheme => Theme.of(this).colorScheme;

  // Accès direct aux textes (TextTheme)
  // Utilisation : context.textTheme.headlineMedium
  TextTheme get textTheme => Theme.of(this).textTheme;

  // Accès à la largeur/hauteur de l'écran (Media Query)
  // Utilisation : context.width
  double get width => MediaQuery.sizeOf(this).width;

  double get height => MediaQuery.sizeOf(this).height;
}
