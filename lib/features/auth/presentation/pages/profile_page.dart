import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import '../../../../config/app_router.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  String? _firstNameError;
  String? _lastNameError;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    super.dispose();
  }

  /// Valide les champs requis
  bool _validateFields() {
    setState(() {
      _firstNameError = _firstNameController.text.isEmpty
          ? 'Le prénom est requis'
          : null;
      _lastNameError = _lastNameController.text.isEmpty
          ? 'Le nom est requis'
          : null;
    });
    return _firstNameError == null && _lastNameError == null;
  }

  /// Valide et soumet le profil
  void _submitProfile() {
    if (!_validateFields()) return;

    setState(() {
      _isLoading = true;
    });

    // Simulation de l'envoi
    Future.delayed(const Duration(seconds: 2), () {
      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      ShadToaster.of(context).show(
        ShadToast(
          description: Text(
            'Bienvenue ${_firstNameController.text} ${_lastNameController.text}!',
          ),
        ),
      );

      // Navigation vers la page de recherche
      Future.delayed(const Duration(milliseconds: 500), () {
        if (mounted) {
          Navigator.of(context).pushReplacementNamed(AppRouter.searchTrip);
        }
      });
    });
  }

  /// Valide en temps réel
  void _onFirstNameChanged(String value) {
    if (_firstNameError != null && value.isNotEmpty) {
      setState(() {
        _firstNameError = null;
      });
    }
  }

  void _onLastNameChanged(String value) {
    if (_lastNameError != null && value.isNotEmpty) {
      setState(() {
        _lastNameError = null;
      });
    }
  }

  /// Vérifie si les champs requis sont remplis
  bool _isFormValid() {
    return _firstNameController.text.isNotEmpty &&
        _lastNameController.text.isNotEmpty;
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _ProfileHeader(),
              const Gap(32),
              _ProfileForm(
                firstNameController: _firstNameController,
                lastNameController: _lastNameController,
                firstNameError: _firstNameError,
                lastNameError: _lastNameError,
                onFirstNameChanged: _onFirstNameChanged,
                onLastNameChanged: _onLastNameChanged,
              ),
              const Gap(32),
              _ProfileActionButtons(
                isLoading: _isLoading,
                isFormValid: _isFormValid(),
                onSubmit: _submitProfile,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget stateless pour l'en-tête du profil
class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Votre profil',
          style: ShadTheme.of(context).textTheme.h3.copyWith(
                fontWeight: FontWeight.bold,
              ),
          textAlign: TextAlign.start,
        ),
        const Gap(12),
        Text(
          'Comment doit-on vous appeler ?',
          style: ShadTheme.of(context).textTheme.muted,
          textAlign: TextAlign.start,
        ),
      ],
    );
  }
}

/// Widget stateless pour le formulaire de profil
class _ProfileForm extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController lastNameController;
  final String? firstNameError;
  final String? lastNameError;
  final Function(String) onFirstNameChanged;
  final Function(String) onLastNameChanged;

  const _ProfileForm({
    required this.firstNameController,
    required this.lastNameController,
    required this.firstNameError,
    required this.lastNameError,
    required this.onFirstNameChanged,
    required this.onLastNameChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ProfileFormField(
          label: 'Prénom',
          controller: firstNameController,
          placeholder: 'ex. Arnaud',
          errorMessage: firstNameError,
          onChanged: onFirstNameChanged,
        ),
        const Gap(20),
        _ProfileFormField(
          label: 'Nom',
          controller: lastNameController,
          placeholder: 'ex. Bamba',
          errorMessage: lastNameError,
          onChanged: onLastNameChanged,
        ),
      ],
    );
  }
}

/// Widget stateless pour un champ de formulaire de profil
class _ProfileFormField extends StatefulWidget {
  final String label;
  final TextEditingController controller;
  final String placeholder;
  final String? errorMessage;
  final Function(String) onChanged;

  const _ProfileFormField({
    required this.label,
    required this.controller,
    required this.placeholder,
    required this.errorMessage,
    required this.onChanged,
  });

  @override
  State<_ProfileFormField> createState() => _ProfileFormFieldState();
}

class _ProfileFormFieldState extends State<_ProfileFormField> {
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = _focusNode.hasFocus;
    final hasError = widget.errorMessage != null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: ShadTheme.of(context).textTheme.small.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const Gap(8),
        ShadInput(
          controller: widget.controller,
          focusNode: _focusNode,
          placeholder: Text(widget.placeholder),
          onChanged: widget.onChanged,
          style: ShadTheme.of(context).textTheme.p,
          decoration: ShadDecoration(
            border: ShadBorder(
              top: ShadBorderSide(
                color: hasError
                    ? ShadTheme.of(context).colorScheme.destructive
                    : isFocused
                        ? ShadTheme.of(context).colorScheme.primary
                        : ShadTheme.of(context).colorScheme.input,
                width: isFocused || hasError ? 2 : 1.5,
              ),
              bottom: ShadBorderSide(
                color: hasError
                    ? ShadTheme.of(context).colorScheme.destructive
                    : isFocused
                        ? ShadTheme.of(context).colorScheme.primary
                        : ShadTheme.of(context).colorScheme.input,
                width: isFocused || hasError ? 2 : 1.5,
              ),
              left: ShadBorderSide(
                color: hasError
                    ? ShadTheme.of(context).colorScheme.destructive
                    : isFocused
                        ? ShadTheme.of(context).colorScheme.primary
                        : ShadTheme.of(context).colorScheme.input,
                width: isFocused || hasError ? 2 : 1.5,
              ),
              right: ShadBorderSide(
                color: hasError
                    ? ShadTheme.of(context).colorScheme.destructive
                    : isFocused
                        ? ShadTheme.of(context).colorScheme.primary
                        : ShadTheme.of(context).colorScheme.input,
                width: isFocused || hasError ? 2 : 1.5,
              ),
              radius: const BorderRadius.all(Radius.circular(8)),
            ),
            color: isFocused
                ? ShadTheme.of(context).colorScheme.primary.withValues(
                      alpha: 0.02,
                    )
                : Colors.transparent,
          ),
        ),
        if (widget.errorMessage != null) ...[
          const Gap(8),
          Text(
            widget.errorMessage!,
            style: ShadTheme.of(context).textTheme.small.copyWith(
                  color: ShadTheme.of(context).colorScheme.destructive,
                  fontWeight: FontWeight.w500,
                ),
          ),
        ],
      ],
    );
  }
}

/// Widget stateless pour les boutons d'action du profil
class _ProfileActionButtons extends StatelessWidget {
  final bool isLoading;
  final bool isFormValid;
  final VoidCallback onSubmit;

  const _ProfileActionButtons({
    required this.isLoading,
    required this.isFormValid,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        ShadButton(
          onPressed: isLoading ? null : onSubmit,
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
                const Gap(8),
              ],
              Text(isLoading ? 'Chargement...' : "C'est parti !"),
            ],
          ),
        ),
        const Gap(12),
        ShadButton.outline(
          onPressed: isFormValid && !isLoading ? () => Navigator.of(context).pop() : null,
          size: ShadButtonSize.lg,
          child: const Text('Passer'),
        ),
      ],
    );
  }
}

/// Gap widget pour l'espacement
class Gap extends StatelessWidget {
  final double size;

  const Gap(this.size, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(height: size);
  }
}

