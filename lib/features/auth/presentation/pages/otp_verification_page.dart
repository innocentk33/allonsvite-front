import 'dart:async';
import 'package:allonsvite/core/router/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:allonsvite/core/themes/app_spacing.dart';
import 'package:allonsvite/core/extension/build_context_ext.dart';
import 'package:allonsvite/core/widgets/header_with_subtitle.dart';
import 'package:allonsvite/core/widgets/button_with_loading.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';

import '../controllers/auth_controller.dart';

class OtpVerificationPage extends ConsumerStatefulWidget {
  final String phoneNumber;

  const OtpVerificationPage({
    super.key,
    required this.phoneNumber,
  });

  @override
  ConsumerState<OtpVerificationPage> createState() => _OtpVerificationPageState();
}

class _OtpVerificationPageState extends ConsumerState<OtpVerificationPage> {
  final TextEditingController _pinController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  // Gestion du Timer
  Timer? _timer;
  static const int _otpDuration = 120; // 2 minutes
  int _remainingSeconds = _otpDuration;
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startCountdown();
    // Auto-focus retardé pour laisser le temps à la transition de page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _pinController.dispose();
    _focusNode.dispose();
    _timer?.cancel();
    super.dispose();
  }

  void _startCountdown() {
    _timer?.cancel();
    setState(() {
      _remainingSeconds = _otpDuration;
      _canResend = false;
    });

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) return;
      if (_remainingSeconds <= 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _remainingSeconds--;
        });
      }
    });
  }

  Future<void> _verifyOtp() async {
    // La navigation sera gérée automatiquement par le Router qui écoute l'état d'auth.
    await ref.read(authControllerProvider.notifier).verifyOtp(
      widget.phoneNumber,
      _pinController.text,
    );
  }

  Future<void> _resendOtp() async {
    _pinController.clear();
    await ref.read(authControllerProvider.notifier).requestOtp(widget.phoneNumber);
    _startCountdown();
  }

  String _formatTime(int seconds) {
    final minutes = seconds ~/ 60;
    final secs = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);
    final isLoading = authState.isLoading;

    // ÉCOUTEUR : Pour afficher les SnackBar (Succès/Erreur)
    ref.listen(authControllerProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
      else if (next.hasValue && !next.isLoading && !next.hasError) {
         context.go(AppRoutes.home);
      }
    });

    // Configuration du Thème Pinput
    final defaultPinTheme = PinTheme(
      width: 50,
      height: 50,
      textStyle: context.textTheme.headlineSmall?.copyWith(
        fontWeight: FontWeight.bold,
        color: context.colorScheme.onSurface,
      ),
      decoration: BoxDecoration(
        color: context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.colorScheme.primary, width: 2),
    );

    final errorPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: context.colorScheme.error, width: 2),
    );

    return PopScope(
      canPop: !isLoading, // On empêche le retour arrière seulement si chargement
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: AppSpacings.pL,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderWithSubtitle(
                        title:   context.l10n.verificationCodeTitle,
                        subtitle: '${context.l10n.pleaseEnterYourVerificationCode} ${widget.phoneNumber}',
                      ),
                      AppSpacings.gapXL,
                      Center(
                        child: Pinput(
                          length: 6,
                          controller: _pinController,
                          focusNode: _focusNode,
                          defaultPinTheme: defaultPinTheme,
                          focusedPinTheme: focusedPinTheme,
                          errorPinTheme: errorPinTheme,
                          // UX : Clavier numérique avec autofill SMS
                          pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                        ),
                      ),

                      AppSpacings.gapXL,

                      // --- RESEND SECTION ---
                      Center(
                        child: _canResend
                            ? TextButton(
                          onPressed: isLoading ? null : _resendOtp,
                          child: Text(
                            context.l10n.sendCodeAgain,
                            style: context.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: context.colorScheme.secondary,
                            ),
                          ),
                        )
                            : Text(
                          "${context.l10n.resendCode} ${_formatTime(_remainingSeconds)}",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.secondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacings.l),
                child: ButtonWithLoading(
                  isLoading: isLoading,
                  onPressed: _verifyOtp ,
                  buttonText:  context.l10n.verifyCode,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}