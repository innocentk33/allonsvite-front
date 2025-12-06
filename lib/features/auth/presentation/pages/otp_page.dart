import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../config/app_router.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({super.key, required this.phoneNumber});

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _focusNodes;
  String? _errorMessage;
  bool _isLoading = false;
  late int _remainingSeconds;

  static const int _countdownDuration = 60;
  static const String _validOtpCode = '1234';

  @override
  void initState() {
    super.initState();
    _otpControllers = List.generate(4, (_) => TextEditingController());
    _focusNodes = List.generate(4, (_) => FocusNode());
    _remainingSeconds = _countdownDuration;
    _startCountdown();

    // Auto-focus le premier champ
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _focusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  /// Lance le compte à rebours
  Future<void> _startCountdown() async {
    while (_remainingSeconds > 0) {
      await Future.delayed(const Duration(seconds: 1));
      if (mounted) {
        setState(() {
          _remainingSeconds--;
        });
      }
    }
  }

  /// Récupère le code OTP complet
  String _getOtpCode() {
    return _otpControllers.map((c) => c.text).join();
  }

  /// Valide le code OTP
  void _verifyOtp() {
    final otpCode = _getOtpCode();

    if (otpCode.length < 4) {
      setState(() {
        _errorMessage = 'Veuillez entrer les 4 chiffres';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulation de vérification
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      if (otpCode == _validOtpCode) {
        ShadToaster.of(context).show(
          const ShadToast(description: Text('Code vérifié avec succès !')),
        );
        setState(() {
          _isLoading = false;
        });
        // Navigation vers la page de profil
        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            Navigator.of(context).pushReplacementNamed(AppRouter.profile);
          }
        });
      } else {
        setState(() {
          _isLoading = false;
          _errorMessage = 'Code incorrect, réessayez';
        });
      }
    });
  }

  /// Renvoie le code
  void _resendOtp() {
    if (_remainingSeconds > 0) return;

    setState(() {
      _remainingSeconds = _countdownDuration;
      _errorMessage = null;
    });

    // Réinitialiser tous les champs
    for (var controller in _otpControllers) {
      controller.clear();
    }

    _startCountdown();

    // Auto-focus le premier champ
    _focusNodes[0].requestFocus();

    ShadToaster.of(context).show(
      const ShadToast(description: Text('Code renvoyé')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: isMobile ? 24 : 48,
            vertical: 32,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _OtpHeader(phoneNumber: widget.phoneNumber),
              const SizedBox(height: 32),
              _OtpInputFields(
                controllers: _otpControllers,
                focusNodes: _focusNodes,
                onChanged: () {
                  setState(() {
                    _errorMessage = null;
                  });
                },
              ),
              const SizedBox(height: 16),
              if (_errorMessage != null)
                _ErrorMessage(message: _errorMessage!)
              else
                const SizedBox(height: 16),
              _VerifyButton(isLoading: _isLoading, onPressed: _verifyOtp),
              const SizedBox(height: 24),
              Center(
                child: _ResendCodeSection(
                  remainingSeconds: _remainingSeconds,
                  onResend: _resendOtp,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget stateless pour l'en-tête OTP
class _OtpHeader extends StatelessWidget {
  final String phoneNumber;

  const _OtpHeader({required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Entrez le code SMS',
          style: ShadTheme.of(context).textTheme.h3.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.start,
        ),
        const SizedBox(height: 12),
        Text(
          'Nous avons envoyé un code à $phoneNumber',
          style: ShadTheme.of(context).textTheme.muted,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}

/// Widget stateless pour le message d'erreur
class _ErrorMessage extends StatelessWidget {
  final String message;

  const _ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Text(
        message,
        style: ShadTheme.of(context).textTheme.small.copyWith(
              color: ShadTheme.of(context).colorScheme.destructive,
              fontWeight: FontWeight.w500,
            ),
      ),
    );
  }
}

/// Widget stateless pour le bouton de vérification
class _VerifyButton extends StatelessWidget {
  final bool isLoading;
  final VoidCallback onPressed;

  const _VerifyButton({required this.isLoading, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ShadButton(
        onPressed: isLoading ? null : onPressed,
        size: ShadButtonSize.lg,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (isLoading) ...[
              SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    ShadTheme.of(context).colorScheme.primaryForeground,
                  ),
                ),
              ),
              const SizedBox(width: 8),
            ],
            Text(isLoading ? 'Vérification...' : 'Vérifier'),
          ],
        ),
      ),
    );
  }
}

/// Widget stateless pour la section de renvoi du code
class _ResendCodeSection extends StatelessWidget {
  final int remainingSeconds;
  final VoidCallback onResend;

  const _ResendCodeSection({
    required this.remainingSeconds,
    required this.onResend,
  });

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (remainingSeconds > 0) ...[
          Text(
            'Renvoyer le code (${_formatTime(remainingSeconds)})',
            style: ShadTheme.of(context).textTheme.small.copyWith(
                  color: ShadTheme.of(context).colorScheme.mutedForeground,
                ),
          ),
        ] else ...[
          ShadButton.ghost(
            onPressed: onResend,
            child: const Text('Renvoyer le code'),
          ),
        ],
      ],
    );
  }
}

/// Widget stateless pour les champs OTP custom avec inputs larges
class _OtpInputFields extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final VoidCallback onChanged;

  const _OtpInputFields({
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
  });

  void _onFieldChanged(String value, int index) {
    onChanged();

    if (value.isEmpty) return;

    // Auto-advance au champ suivant
    if (index < 3) {
      focusNodes[index + 1].requestFocus();
    } else {
      // Dernier champ, masque le clavier
      focusNodes[index].unfocus();
    }
  }

  void _onBackspace(int index) {
    if (index > 0 && controllers[index].text.isEmpty) {
      focusNodes[index - 1].requestFocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        4,
        (index) => Padding(
          padding: EdgeInsets.only(right: index < 3 ? 16 : 0),
          child: _OtpTextField(
            controller: controllers[index],
            focusNode: focusNodes[index],
            onChanged: (value) => _onFieldChanged(value, index),
            onBackspace: () => _onBackspace(index),
          ),
        ),
      ),
    );
  }
}

/// Widget stateful pour un champ OTP individuel avec design large et lisible
class _OtpTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode focusNode;
  final Function(String) onChanged;
  final VoidCallback onBackspace;

  const _OtpTextField({
    required this.controller,
    required this.focusNode,
    required this.onChanged,
    required this.onBackspace,
  });

  @override
  State<_OtpTextField> createState() => _OtpTextFieldState();
}

class _OtpTextFieldState extends State<_OtpTextField> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 64,
      height: 80,
      child: ShadInput(
        decoration: ShadDecoration(

        ),
        inputPadding: EdgeInsets.symmetric(vertical: 10),
        controller: widget.controller,
        focusNode: widget.focusNode,
        textAlign: TextAlign.center,
        keyboardType: TextInputType.number,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(1),
        ],
        onChanged: (value) {
          if (value.isEmpty) {
            widget.onBackspace();
          }
          widget.onChanged(value);
        },
        style: ShadTheme.of(context).textTheme.h1.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 32,
            ),
        placeholder: const Text(''),
      ),
    );
  }
}

