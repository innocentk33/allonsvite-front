import 'package:flutter/material.dart';
import 'package:allonsvite/core/themes/app_spacing.dart';
import 'package:allonsvite/core/extension/build_context_ext.dart';
import 'package:allonsvite/core/widgets/header_with_subtitle.dart';
import 'package:allonsvite/core/widgets/button_with_loading.dart';
import 'package:allonsvite/core/config/app_router.dart';

class OtpVerificationPage extends StatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  State<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends State<OtpVerificationPage> {
  late List<TextEditingController> _otpControllers;
  late List<FocusNode> _otpFocusNodes;
  String? _errorMessage;
  bool _isLoading = false;
  late int _remainingSeconds;
  late int _totalSeconds;
  bool _canResend = false;
  bool _canGoBack = false;

  static const int _otpDuration = 10; // 2 minutes
  static const int _otpLength = 6;
  static const String _validOtpCode = '123456';

  @override
  void initState() {
    super.initState();
    _totalSeconds = _otpDuration;
    _remainingSeconds = _otpDuration;
    _otpControllers = List.generate(_otpLength, (_) => TextEditingController());
    _otpFocusNodes = List.generate(_otpLength, (_) => FocusNode());
    _startCountdown();

    // Auto-focus sur le premier champ OTP
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _otpFocusNodes[0].requestFocus();
    });
  }

  @override
  void dispose() {
    for (var controller in _otpControllers) {
      controller.dispose();
    }
    for (var node in _otpFocusNodes) {
      node.dispose();
    }
    super.dispose();
  }

  /// Lance le compte à rebours
  void _startCountdown() {
    _remainingSeconds = _totalSeconds;
    _canResend = false;
    _canGoBack = false;

    Future.doWhile(() async {
      if (!mounted) return false;

      await Future.delayed(const Duration(seconds: 1));

      if (!mounted) return false;

      setState(() {
        _remainingSeconds--;
        _canGoBack = _remainingSeconds <= 0;
        _canResend = _remainingSeconds <= 0;
      });

      return _remainingSeconds > 0;
    });
  }




  /// Récupère le code OTP complet
  String _getOtpCode() {
    return _otpControllers.map((c) => c.text).join();
  }

  /// Gère le changement de chaque champ OTP
  void _onOtpFieldChanged(String value, int index) {
    setState(() {
      _errorMessage = null;
    });

    if (value.isEmpty) return;

    // Auto-advance au champ suivant
    if (index < _otpLength - 1) {
      _otpFocusNodes[index + 1].requestFocus();
    } else {
      // Dernier champ, masque le clavier
      _otpFocusNodes[index].unfocus();
    }
  }

  /// Gère le backspace pour revenir au champ précédent
  void _onOtpBackspace(int index) {
    if (index > 0 && _otpControllers[index].text.isEmpty) {
      _otpFocusNodes[index - 1].requestFocus();
    }
  }

  /// Valide et vérifie le code OTP
  void _verifyOtp() {
    final otpCode = _getOtpCode();

    if (otpCode.length < _otpLength) {
      setState(() {
        _errorMessage = 'Veuillez entrer les $_otpLength chiffres';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulation de la vérification
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      if (otpCode == _validOtpCode) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Code vérifié avec succès !'),
            duration: Duration(seconds: 2),
          ),
        );

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

  /// Renvoie le code OTP
  void _resendOtp() {
    if (!_canResend) return;

    setState(() {
      // Réinitialiser tous les champs
      for (var controller in _otpControllers) {
        controller.clear();
      }
      _errorMessage = null;
    });

    _startCountdown();

    // Auto-focus le premier champ
    _otpFocusNodes[0].requestFocus();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Code renvoyé'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: _canGoBack,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              // Contenu scrollable
              Expanded(
                child: SingleChildScrollView(
                  padding: AppSpacings.pL,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // En-tête avec titre et sous-titre
                      HeaderWithSubtitle(
                        title: context.l10n.sendYouSMS,
                        subtitle:
                            '${context.l10n.pleaseEnterYourVerificationCode} ${widget.phoneNumber}',
                      ),
                      AppSpacings.gapXL,
                      // Champs OTP
                      _OtpInputFields(
                        controllers: _otpControllers,
                        focusNodes: _otpFocusNodes,
                        onChanged: _onOtpFieldChanged,
                        onBackspace: _onOtpBackspace,
                      ),
                      AppSpacings.gapL,
                      // Message d'erreur
                      if (_errorMessage != null)
                        _ErrorMessage(message: _errorMessage!)
                      else
                        const SizedBox.shrink(),
                      AppSpacings.gapL,
                      // Section renvoi du code
                      _ResendCodeSection(
                        remainingSeconds: _remainingSeconds,
                        canResend: _canResend,
                        onResend: _resendOtp,
                      ),
                    ],
                  ),
                ),
              ),
              // Bouton de vérification en bas
              Padding(
                padding: const EdgeInsets.all(AppSpacings.l),
                child: ButtonWithLoading(
                  isLoading: _isLoading,
                  onPressed: _verifyOtp,
                  buttonText: context.l10n.verifyCode,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget stateless pour les champs OTP
class _OtpInputFields extends StatelessWidget {
  final List<TextEditingController> controllers;
  final List<FocusNode> focusNodes;
  final Function(String, int) onChanged;
  final Function(int) onBackspace;

  const _OtpInputFields({
    required this.controllers,
    required this.focusNodes,
    required this.onChanged,
    required this.onBackspace,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(
        controllers.length,
        (index) => Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4),
            child: _OtpTextField(
              controller: controllers[index],
              focusNode: focusNodes[index],
              onChanged: (value) => onChanged(value, index),
              onBackspace: () => onBackspace(index),
            ),
          ),
        ),
      ),
    );
  }
}

/// Widget stateful pour un champ OTP individuel
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
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(AppSpacings.ms),
      ),
      child: TextField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        keyboardType: TextInputType.number,
        textAlign: TextAlign.center,
        maxLength: 1,
        onChanged: (value) {
          if (value.isEmpty) {
            widget.onBackspace();
          }
          widget.onChanged(value);
        },
        decoration: InputDecoration(
          counterText: '',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(8),
            borderSide: BorderSide.none,
          ),
          fillColor: context.colorScheme.secondaryContainer,

          contentPadding: const EdgeInsets.all(AppSpacings.s),
        ),
        style: context.textTheme.headlineSmall?.copyWith(
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}

/// Widget stateless pour le message d'erreur
class _ErrorMessage extends StatelessWidget {
  final String message;

  const _ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Text(
      message,
      style: context.textTheme.bodySmall?.copyWith(
        color: colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

/// Widget stateless pour la section de renvoi du code
class _ResendCodeSection extends StatelessWidget {
  final int remainingSeconds;
  final bool canResend;
  final VoidCallback onResend;

  const _ResendCodeSection({
    required this.remainingSeconds,
    required this.canResend,
    required this.onResend,
  });

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          if (!canResend)
            Text(
              '${context.l10n.resendCode} (${_formatTime(remainingSeconds)})',
              style: context.textTheme.labelLarge?.copyWith(
                color: context.colorScheme.secondary,
                fontWeight: .w600
              ),
            )
          else
            TextButton(
              onPressed: onResend,
              child: Text(context.l10n.sendCodeAgain,style: context.textTheme.labelLarge?.copyWith(
                fontWeight: .w600,
                color: context.colorScheme.secondary,)
              ),
            ),
        ],
      ),
    );
  }
}

