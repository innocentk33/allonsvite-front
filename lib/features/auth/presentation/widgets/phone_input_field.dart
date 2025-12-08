import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extension/build_context_ext.dart';
import '../../../../core/themes/app_spacing.dart';

class PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? errorMessage;
  final Function(String) onChanged;

  const PhoneInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.errorMessage,
    required this.onChanged,
  });

  @override
  State<PhoneInputField> createState() => PhoneInputFieldState();
}

class PhoneInputFieldState extends State<PhoneInputField> {
  @override
  Widget build(BuildContext context) {
    final hasError = widget.errorMessage != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppSpacings.gapS,
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Container avec drapeau
            _CountryFlag(),
            AppSpacings.gapS,
            // Champ de saisie
            Expanded(
              child: TextField(
                controller: widget.controller,
                focusNode: widget.focusNode,
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10),
                ],
                onChanged: widget.onChanged,
                style: context.textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                decoration: InputDecoration(
                  hintText: '07 10 20 30 40',
                  hintStyle: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.5,
                    ),
                  ),
                  filled: true,
                  fillColor: context.colorScheme.secondaryContainer,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: AppSpacings.brMs,
                    borderSide: BorderSide(
                      color: hasError
                          ? context.colorScheme.error
                          : Colors.transparent,
                      width: 1,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: AppSpacings.brM,
                    borderSide: BorderSide(
                      color: hasError
                          ? context.colorScheme.error
                          : context.colorScheme.primary,
                      width: 1,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: AppSpacings.brM,
                    borderSide: BorderSide(
                      color: context.colorScheme.error,
                      width: 1.5,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: AppSpacings.brM,
                    borderSide: BorderSide(
                      color: context.colorScheme.error,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacings.m,
                    vertical: AppSpacings.m,
                  ),
                ),
              ),
            ),
          ],
        ),
        if (widget.errorMessage != null) ...[
          AppSpacings.gapS,
          Text(
            widget.errorMessage!,
            style: context.textTheme.bodySmall?.copyWith(
              color: context.colorScheme.error,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
        AppSpacings.gapS,
      ],
    );
  }
}

class _CountryFlag extends StatelessWidget {
  const _CountryFlag();

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
