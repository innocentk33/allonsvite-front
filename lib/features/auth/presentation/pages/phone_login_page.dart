import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:gap/gap.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../core/config/app_router.dart';
import 'otp_page.dart';

/// Formatteur de numéro de téléphone personnalisé
/// Formate automatiquement le texte en XX XX XX XX XX sans déclencher onChanged
class _PhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    final digits = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digits.isEmpty) {
      return newValue.copyWith(
        text: '',
        selection: const TextSelection.collapsed(offset: 0),
      );
    }

    String formatted = '';
    for (int i = 0; i < digits.length; i++) {
      if (i > 0 && i % 2 == 0) {
        formatted += ' ';
      }
      formatted += digits[i];
    }

    // Calcul de la position du curseur
    int cursorPosition = formatted.length;
    if (oldValue.text.length < newValue.text.length) {
      // Caractère ajouté
      cursorPosition = formatted.length;
    }

    return newValue.copyWith(
      text: formatted,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}

class PhoneLoginPage extends StatefulWidget {
  const PhoneLoginPage({super.key});

  @override
  State<PhoneLoginPage> createState() => _PhoneLoginPageState();
}

class _PhoneLoginPageState extends State<PhoneLoginPage> {
  late TextEditingController _phoneController;
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _phoneController = TextEditingController();
  }

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  /// Valide le format du numéro de téléphone (simple validation)
  bool _isValidPhoneNumber(String phone) {
    // Accepte 8-12 chiffres
    final regex = RegExp(r'^\d{10}$');
    return regex.hasMatch(phone.replaceAll(' ', ''));
  }

  void _handleSendCode() {
    setState(() {
      _errorMessage = null;
    });

    final phone = _phoneController.text.replaceAll(' ', '');

    // Validation
    if (phone.isEmpty) {
      setState(() {
        _errorMessage = 'Veuillez entrer votre numéro de téléphone';
      });
      return;
    }

    if (!_isValidPhoneNumber(phone)) {
      setState(() {
        _errorMessage = 'Veuillez entrer un numéro valide (10 chiffres)';
      });
      return;
    }

    // Simulation de l'envoi du code
    setState(() {
      _isLoading = true;
    });
    // Simulation de l'envoi du code
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      // Simuler un succès
      _showSuccessToast();

      // Navigation vers la page de vérification du code
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          final formattedPhone = '+225 ${_phoneController.text}';
          Navigator.of(context).pushReplacementNamed(
            AppRouter.otpVerification,
            arguments: formattedPhone,
          );
        }
      });
    });
  }

  void _showSuccessToast() {
    ShadToaster.of(context).show(
      ShadToast(
        description: Text('Code envoyé à +225 ${_phoneController.text}'),
      ),
    );
  }

  void _clearPhoneField() {
    _phoneController.clear();
    setState(() {
      _errorMessage = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24, vertical: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Greeting Section
              Text(
                'Bonjour ! 👋',
                style: ShadTheme.of(
                  context,
                ).textTheme.h3.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: Text(
                  'Entrez votre numéro pour commencer',
                  style: ShadTheme.of(context).textTheme.p,
                  textAlign: TextAlign.start,
                ),
              ),
              // Phone Number Input
              Gap(20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShadInputFormField(
                    label: const Text('Numero de telephone'),
                    inputFormatters: [
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10),
                      _PhoneNumberFormatter(),
                    ],
                    controller: _phoneController,
                    placeholder: const Text('01 23 45 67 89'),
                    keyboardType: TextInputType.phone,
                    validator: (v) {
                      if (v.isEmpty || !_isValidPhoneNumber(v)) {
                        return 'Veuillez entrer votre numéro de téléphone';
                      }
                      return null;

                    },
                    leading: Padding(
                      padding: const EdgeInsets.only(left: 12),
                      child: Text(
                        '🇨🇮 +225',
                        style: ShadTheme.of(context).textTheme.p,
                      ),
                    ),
                    trailing: _phoneController.text.isNotEmpty
                        ? GestureDetector(
                            onTap: _clearPhoneField,
                            child: Padding(
                              padding: const EdgeInsets.only(right: 12),
                              child: Icon(
                                Icons.close,
                                size: 18,
                                color: ShadTheme.of(
                                  context,
                                ).colorScheme.mutedForeground,
                              ),
                            ),
                          )
                        : null,
                  ),
                  const SizedBox(height: 8),
                ],
              ),
              const SizedBox(height: 8),

              // Error Message
              if (_errorMessage != null)
                Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: ShadTheme.of(
                        context,
                      ).colorScheme.destructive.withValues(alpha: 0.1),
                      border: Border.all(
                        color: ShadTheme.of(
                          context,
                        ).colorScheme.destructive.withValues(alpha: 0.3),
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.error_outline,
                          size: 16,
                          color: ShadTheme.of(
                            context,
                          ).colorScheme.destructive,
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            _errorMessage!,
                            style: ShadTheme.of(context).textTheme.small
                                .copyWith(
                                  color: ShadTheme.of(
                                    context,
                                  ).colorScheme.destructive,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                const SizedBox(height: 16),

              // Send Code Button
              ShadButton(
                onPressed: _isLoading ? null : _handleSendCode,
                size: ShadButtonSize.lg,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (_isLoading) ...[
                      SizedBox(
                        width: 16,
                        height: 16,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            ShadTheme.of(
                              context,
                            ).colorScheme.primaryForeground,
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                    ],
                    Text(
                      _isLoading ? 'Envoi en cours...' : 'Continuer',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
