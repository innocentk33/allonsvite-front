import 'package:flutter/material.dart';

class ButtonWithLoading extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;
  final String buttonText;

  const ButtonWithLoading({
    super.key,
    required this.isLoading,
    required this.onPressed,
    required this.buttonText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              )
            : Text(buttonText),
      ),
    );
  }
}
