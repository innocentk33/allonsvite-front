import 'package:flutter/material.dart';
import 'package:allonsvite/core/extension/build_context_ext.dart';
import 'package:allonsvite/core/themes/app_spacing.dart';
import 'package:allonsvite/core/widgets/header_with_subtitle.dart';
import 'package:allonsvite/core/widgets/button_with_loading.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


import '../../../../core/router/app_routes.dart';
import '../controllers/auth_controller.dart';



class CreateProfilPage extends ConsumerStatefulWidget {
  const CreateProfilPage({super.key});

  @override
  ConsumerState<CreateProfilPage> createState() => _CreateProfilPageState();
}



class _CreateProfilPageState extends ConsumerState<CreateProfilPage> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late FocusNode _firstNameFocusNode;
  late FocusNode _lastNameFocusNode;

  // Plus besoin de _isLoading ici, Riverpod s'en charge
  String? _localError;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _firstNameFocusNode = FocusNode();
    _lastNameFocusNode = FocusNode();

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

  bool _validateFields() {
    final firstName = _firstNameController.text.trim();
    final lastName = _lastNameController.text.trim();

    if (firstName.isEmpty) {
      setState(() => _localError = 'Le prénom est requis');
      return false;
    }

    if (lastName.isEmpty) {
      setState(() => _localError = 'Le nom est requis');
      return false;
    }

    setState(() => _localError = null);
    return true;
  }

  void _createProfile() {
    if (!_validateFields()) return;

    // Appel au Controller Riverpod
    ref.read(authControllerProvider.notifier).createProfile(
      firstName: _firstNameController.text.trim(),
      lastName: _lastNameController.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    // 1. Écouter l'état global de l'auth
    final authState = ref.watch(authControllerProvider);

    // 2. Écouter les changements d'état pour agir (Navigation / Erreur)
    ref.listen(authControllerProvider, (previous, next) {
      if (next.hasError && !next.isLoading) {
        // Afficher l'erreur serveur
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error.toString()),
            backgroundColor: context.colorScheme.error,
          ),
        );
      } else if (next.hasValue && !next.isLoading && !next.hasError) {
        // SUCCÈS : Navigation vers Home
        context.go(AppRoutes.home);
      }
    });

    return Scaffold(
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
                      title: "Profil", // context.l10n.profile (si tu as l'intl)
                      subtitle: 'Comment doit-on vous appeler ?',
                    ),
                    AppSpacings.gapXL,

                    _ProfileInputField(
                      label: "Prénom", // context.l10n.firstName
                      controller: _firstNameController,
                      focusNode: _firstNameFocusNode,
                      placeholder: 'ex. Arnaud',
                      onChanged: (_) {
                        if (_localError != null) setState(() => _localError = null);
                      },
                      onSubmitted: (_) => _lastNameFocusNode.requestFocus(),
                    ),
                    AppSpacings.gapL,

                    _ProfileInputField(
                      label: "Nom", // context.l10n.lastName
                      controller: _lastNameController,
                      focusNode: _lastNameFocusNode,
                      placeholder: 'ex. Bamba',
                      onChanged: (_) {
                        if (_localError != null) setState(() => _localError = null);
                      },
                      onSubmitted: (_) => _createProfile(),
                    ),
                    AppSpacings.gapL,

                    // Affichage des erreurs locales (validation) ou serveur (Riverpod)
                    if (_localError != null)
                      _ErrorMessage(message: _localError!)
                    else
                      const SizedBox.shrink(),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(AppSpacings.l),
              child: ButtonWithLoading(
                // L'état de chargement vient de Riverpod
                isLoading: authState.isLoading,
                onPressed:  _createProfile,
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

