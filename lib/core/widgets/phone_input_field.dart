import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../core/extension/build_context_ext.dart';

class PhoneInputField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final String? errorMessage;
  final String? hintText;
  final Function(String) onChanged;

  const PhoneInputField({
    super.key,
    required this.controller,
    required this.focusNode,
    required this.errorMessage,
    required this.onChanged,
    this.hintText,
  });

  @override
  State<PhoneInputField> createState() => PhoneInputFieldState();
}

class PhoneInputFieldState extends State<PhoneInputField> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: true,
      forceErrorText: widget.errorMessage,
      controller: widget.controller,
      focusNode: widget.focusNode,
      keyboardType: TextInputType.phone,
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        LengthLimitingTextInputFormatter(10),
      ],
      onChanged: widget.onChanged,
      style: context.textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w500),
      decoration: InputDecoration(hintText: widget.hintText),
    );
  }
}
