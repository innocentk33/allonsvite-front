import 'package:allonsvite/core/extension/build_context_ext.dart';
import 'package:allonsvite/core/widgets/button_with_loading.dart';
import 'package:allonsvite/core/widgets/header_with_subtitle.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:allonsvite/core/themes/app_spacing.dart';


import '../../../../core/router/app_router.dart';
import '../providers/auth_controller.dart';
import '../widgets/phone_input_field.dart';


class PhoneLoginPage extends ConsumerStatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  ConsumerState<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends ConsumerState<PhoneLoginPage> {
  late TextEditingController _phoneController;
  late FocusNode _phoneFocusNode;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
    _phoneFocusNode = FocusNode();

    // Ajouter un listener pour formater le numéro en temps réel
    _phoneController.addListener(_formatPhoneNumber);
  }

  @override
  void dispose() {
    _phoneController.removeListener(_formatPhoneNumber);
    _phoneController.dispose();
    _phoneFocusNode.dispose();
    super.dispose();
  }

  /// Formate le numéro de téléphone en temps réel
  void _formatPhoneNumber() {
    final text = _phoneController.text.replaceAll(' ', '');
    if (text.length <= 10) {
      final formatted = _formatIvorianPhone(text);
      if (formatted != _phoneController.text) {
        final cursorPosition = _phoneController.selection.baseOffset;
        final newCursorPosition =
            cursorPosition + (formatted.length - _phoneController.text.length);
        _phoneController.value = TextEditingValue(
          text: formatted,
          selection: TextSelection.collapsed(
            offset: newCursorPosition.clamp(0, formatted.length),
          ),
        );
      }
    }
  }

  /// Formate un numéro ivoirien (10 chiffres) => 07 10 20 30 40
  String _formatIvorianPhone(String phone) {
    if (phone.isEmpty) return '';

    final digitsOnly = phone.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();

    for (int i = 0; i < digitsOnly.length; i++) {
      if (i > 0 && i % 2 == 0 && i < 10) {
        buffer.write(' ');
      }
      buffer.write(digitsOnly[i]);
    }

    return buffer.toString();
  }

  /// Valide le numéro de téléphone
  bool _validatePhone() {
    final phone = _phoneController.text.replaceAll(' ', '');

    if (phone.isEmpty) {
      setState(() {
        _errorMessage = 'Le numéro de téléphone est requis';
      });
      return false;
    }

    if (phone.length != 10) {
      setState(() {
        _errorMessage = 'Le numéro doit contenir 10 chiffres';
      });
      return false;
    }

    // Vérifier que le numéro commence par 0
    if (!phone.startsWith('0')) {
      setState(() {
        _errorMessage = 'Le numéro doit commencer par 0';
      });
      return false;
    }

    setState(() {
      _errorMessage = null;
    });
    return true;
  }

  /// Envoie le code de vérification
  Future<void> _sendVerificationCode() async {
    if (!_validatePhone()) return;

    setState(() {
      _errorMessage = null;
    });

    final phone = _phoneController.text.replaceAll(' ', '');

    // Appel au provider pour demander l'OTP
    await ref.read(otpRequestProvider.notifier).requestOtp(phone);

    if (!mounted) return;

    // Vérifier l'état après la requête
    final otpState = ref.read(otpRequestProvider);

    otpState.when(
      data: (_) {
        // Succès
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Code envoyé par SMS'),
            duration: Duration(seconds: 2),
          ),
        );

        Future.delayed(const Duration(milliseconds: 500), () {
          if (mounted) {
            context.push(AppRoutes.otpVerification, extra: phone);
          }
        });
      },
      loading: () {
        // Ne rien faire, le bouton affiche déjà le loading
      },
      error: (error, _) {
        // Erreur
        setState(() {
          _errorMessage = error.toString();
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error.toString()),
            backgroundColor: Colors.red,
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final otpRequestState = ref.watch(otpRequestProvider);
    final isLoading = otpRequestState.isLoading;

    return Scaffold(
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
                    // Titre et description
                    HeaderWithSubtitle(title: context.l10n.phoneLoginTitle,subtitle: context.l10n.phoneLoginSubtitle,),
                    AppSpacings.gapL,
                    // Champ téléphone avec drapeau
                    PhoneInputField(
                      controller: _phoneController,
                      focusNode: _phoneFocusNode,
                      errorMessage: _errorMessage,
                      onChanged: (value) {
                        if (_errorMessage != null) {
                          setState(() {
                            _errorMessage = null;
                          });
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            // Bouton fixé en bas
            Padding(
              padding: const EdgeInsets.all(AppSpacings.l),
              child: ButtonWithLoading(
                isLoading: isLoading,
                onPressed: () => _sendVerificationCode(),
                buttonText: context.l10n.sendCode,
              ),
            ),
          ],
        ),
      ),
    );
  }
}