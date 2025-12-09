import 'package:allonsvite/core/extension/build_context_ext.dart';
import 'package:flutter/material.dart';

import '../themes/app_spacing.dart';



class HeaderWithSubtitle extends StatelessWidget {
  const HeaderWithSubtitle({
    super.key,
    this.title,
    this.subtitle,
  });
  final String? title;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title ?? '', style: context.textTheme.headlineSmall),
        AppSpacings.gapS,
        Text(subtitle ?? '', style: context.textTheme.bodyLarge),
      ],
    );
  }
}
