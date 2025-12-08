import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class AppSpacings {
  // VALEURS BRUTES (Doubles)
  // Utiles pour les borderRadius, les tailles d'icônes, ou les paddings custom
  static const double xs = 4.0;
  static const double s = 8.0;
  static const double ms = 12.0;
  static const double m = 16.0;
  static const double l = 24.0;
  static const double xl = 32.0;
  static const double xxl = 48.0;

  // GAPS (Widgets)
  // MÊME constante dans une Row ou une Column
  static const Gap gapXS = Gap(xs);
  static const Gap gapS = Gap(s);
  static const Gap gapM = Gap(m);
  static const Gap gapL = Gap(l);
  static const Gap gapXL = Gap(xl);
  static const Gap gapXXL = Gap(xxl);

  // PADDINGS (EdgeInsets)
  // Gap ne gère pas le padding "interne" d'un Container
  static const EdgeInsets pS = EdgeInsets.all(s);
  static const EdgeInsets pM = EdgeInsets.all(m);
  static const EdgeInsets pL = EdgeInsets.all(l);

  static const EdgeInsets phM = EdgeInsets.symmetric(horizontal: m);
  static const EdgeInsets pvM = EdgeInsets.symmetric(vertical: m);

  // BORDURES (Radius)
  static BorderRadius brM = BorderRadius.circular(m);
  static BorderRadius brMs = BorderRadius.circular(ms);
  static BorderRadius brL = BorderRadius.circular(l);
  static BorderRadius brXL = BorderRadius.circular(xl);
  static BorderRadius brXXL = BorderRadius.circular(xxl);
}
