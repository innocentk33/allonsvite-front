import 'package:flutter/material.dart';

import '../extension/build_context_ext.dart';
import '../themes/app_spacing.dart';

class CountryFlag extends StatelessWidget {
  const CountryFlag({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.l,
        vertical: 15,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.surface,
        border: Border.all(color: context.colorScheme.outline, width: 1),
        borderRadius: AppSpacings.brMs,
      ),
      child: const Text('🇨🇮', style: TextStyle(fontSize: AppSpacings.m)),
    );
  }
}
