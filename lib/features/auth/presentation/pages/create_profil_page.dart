import 'package:flutter/material.dart';
import 'package:allonsvite/core/extension/build_context_ext.dart';
import 'package:allonsvite/core/themes/app_spacing.dart';
import 'package:allonsvite/core/widgets/header_with_subtitle.dart';
import 'package:allonsvite/core/widgets/button_with_loading.dart';
import 'package:allonsvite/core/config/app_router.dart';

class CreateProfilPage extends StatefulWidget {
  const CreateProfilPage({super.key});

  @override
  State<CreateProfilPage> createState() => _CreateProfilPageState();
}

class _CreateProfilPageState extends State<CreateProfilPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late FocusNode _firstNameFocusNode;
  late FocusNode _lastNameFocusNode;
  String? _errorMessage;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();

    // Auto-focus sur le premier champ
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _firstNameFocusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _firstNameFocusNode.dispose();
    _lastNameFocusNode.dispose();
    super.dispose();
  }

  /// Valide les champs requis
  bool _validateFields() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    if (firstName.isEmpty) {
      setState(() {
        _errorMessage = 'Le prénom est requis';
      });
      return false;
    }

    if (lastName.isEmpty) {
      setState(() {
        _errorMessage = 'Le nom est requis';
      });
      return false;
    }

    setState(() {
      _errorMessage = null;
    });
    return true;
  }

  /// Crée le profil
  void _createProfile() {
    if (!_validateFields()) return;

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    // Simulation de la création du profil
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Bienvenue ${_firstNameController.text} ${_lastNameController.text}!',
          ),
          duration: const Duration(seconds: 2),
        ),
      );

      // Navigation vers la page de recherche de trajet
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(AppRouter.home);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
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
                    // En-tête
                    HeaderWithSubtitle(
                      title: context.l10n.profile,
                      subtitle: 'Comment doit-on vous appeler ?',
                    ),
                    AppSpacings.gapXL,
                    // Champs de saisie
                    _ProfileInputField(
                      label: context.l10n.firstName,
                      controller: _firstNameController,
                      focusNode: _firstNameFocusNode,
                      placeholder: 'ex. Arnaud',
                      onChanged: (value) {
                        if (_errorMessage != null) {
                          setState(() {
                            _errorMessage = null;
                          });
                        }
                      },
                      onSubmitted: (_) {
                        _lastNameFocusNode.requestFocus();
                      },
                    ),
                    AppSpacings.gapL,
                    _ProfileInputField(
                      label: context.l10n.lastName,
                      controller: _lastNameController,
                      focusNode: _lastNameFocusNode,
                      placeholder: 'ex. Bamba',
                      onChanged: (value) {
                        if (_errorMessage != null) {
                          setState(() {
                            _errorMessage = null;
                          });
                        }
                      },
                      onSubmitted: (_) {
                        _createProfile();
                      },
                    ),
                    AppSpacings.gapL,
                    // Message d'erreur
                    if (_errorMessage != null)
                      _ErrorMessage(message: _errorMessage!)
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
            ),
            // Bouton créer mon compte en bas
            Padding(
              padding: const EdgeInsets.all(AppSpacings.l),
              child: ButtonWithLoading(
                isLoading: _isLoading,
                onPressed: _createProfile,
                buttonText: "C'est parti !",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget stateful pour un champ de profil
class _ProfileInputField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final FocusNode focusNode;
  final String placeholder;
  final Function(String) onChanged;
  final Function(String) onSubmitted;

  const _ProfileInputField({
    required this.label,
    required this.controller,
    required this.focusNode,
    required this.placeholder,
    required this.onChanged,
    required this.onSubmitted,
  });

  @override
  State<_ProfileInputField> createState() => _ProfileInputFieldState();
}

class _ProfileInputFieldState extends State<_ProfileInputField> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: context.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        AppSpacings.gapS,
        TextField(
          controller: widget.controller,
          focusNode: widget.focusNode,
          textInputAction: TextInputAction.next,
          onChanged: widget.onChanged,
          onSubmitted: widget.onSubmitted,
          style: context.textTheme.bodyLarge,
          decoration: InputDecoration(
            hintText: widget.placeholder,
            hintStyle: context.textTheme.bodyLarge?.copyWith(
              color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
            ),
            filled: true,
            fillColor: context.colorScheme.secondaryContainer,
            border: InputBorder.none,
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            errorBorder: InputBorder.none,
            focusedErrorBorder: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppSpacings.m,
              vertical: AppSpacings.m,
            ),
          ),
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
    return Text(
      message,
      style: context.textTheme.bodySmall?.copyWith(
        color: context.colorScheme.error,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

