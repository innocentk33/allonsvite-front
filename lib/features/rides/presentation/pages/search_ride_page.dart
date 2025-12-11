import 'package:allonsvite/core/router/app_routes.dart';
import 'package:allonsvite/features/rides/domain/location.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/extension/build_context_ext.dart';
import '../../../../core/themes/app_spacing.dart';

class SearchRidePage extends StatefulWidget {
  const SearchRidePage({super.key});

  @override
  State<SearchRidePage> createState() => _SearchRidePageState();
}

class _SearchRidePageState extends State<SearchRidePage> {
  late TextEditingController _fromController;
  late TextEditingController _toController;
  int _numberOfPeople = 0;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fromController = TextEditingController();
    _toController = TextEditingController();
  }

  @override
  void dispose() {
    _fromController.dispose();
    _toController.dispose();
    super.dispose();
  }

  void _swapLocations() {
    final temp = _fromController.text;
    setState(() {
      _fromController.text = _toController.text;
      _toController.text = temp;
    });
  }

  Future<void> _selectFromLocation() async {
    debugPrint('_selectFromLocation() called');
    final location = await context.push<Location>(AppRoutes.findLocation);
    if (location != null) {
      setState(() {
        _fromController.text = location.name;
      });
    }
  }

  Future<void> _selectToLocation() async {
    final location = await context.push<Location>(AppRoutes.findLocation);
    if (location != null) {
      setState(() {
        _toController.text = location.name;
      });
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: context.colorScheme.primary,
              onPrimary: context.colorScheme.onPrimary,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final selectedDay = DateTime(date.year, date.month, date.day);

    if (selectedDay == today) {
      return 'Today';
    } else if (selectedDay == tomorrow) {
      return 'Tomorrow';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  void _findRide() {
    // Action pour trouver un trajet
    Navigator.of(context).pushNamed('/finding-ride');
  }

  void _showPeopleDialog() {
    int tempPeople = _numberOfPeople;

    showDialog(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: StatefulBuilder(
          builder: (context, setState) => Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            padding: AppSpacings.pL,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppSpacings.gapL,
                Text(
                  'Combien de sièges voulez-vous ?',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                AppSpacings.gapXL,
                // Sélecteur avec - chiffre +
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Bouton moins
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: tempPeople > 0
                            ? () => setState(() => tempPeople--)
                            : null,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('−', style: TextStyle(fontSize: 24)),
                      ),
                    ),
                    AppSpacings.gapXL,
                    // Chiffre
                    Text(
                      '$tempPeople',
                      style: context.textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSpacings.gapXL,
                    // Bouton plus
                    SizedBox(
                      width: 50,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: tempPeople < 8
                            ? () => setState(() => tempPeople++)
                            : null,
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: EdgeInsets.zero,
                        ),
                        child: const Text('+', style: TextStyle(fontSize: 24)),
                      ),
                    ),
                  ],
                ),
                AppSpacings.gapXL,
                // Bouton de confirmation
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _numberOfPeople = tempPeople;
                      });
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                    child: Text(
                      'Confirmer',
                      style: context.textTheme.labelLarge,
                    ),
                  ),
                ),
                AppSpacings.gapL,
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: AppSpacings.pL,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppSpacings.gapL,
                    // Titre avec nom de l'utilisateur
                    Text(
                      'Bonjour',
                      style: context.textTheme.headlineLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    AppSpacings.gapS,
                    Text(
                      'What would you like to do today?',
                      style: context.textTheme.bodyLarge?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                    AppSpacings.gapXL,
                    // Carte de recherche
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.08),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: AppSpacings.pL,
                      child: Column(
                        children: [
                          // Champ From avec icône swap
                          Row(
                            children: [
                              Expanded(
                                child: _SearchTextField(
                                  onTap: _selectFromLocation,
                                  controller: _fromController,
                                  placeholder: 'From de ouf',
                                  readOnly: true,
                                ),
                              ),
                              AppSpacings.gapS,
                              IconButton(
                                onPressed: _swapLocations,
                                icon: Icon(
                                  LucideIcons.arrowUpDown,
                                  color: context.colorScheme.onSurfaceVariant,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                          // Séparateur
                          const Divider(height: 1),
                          AppSpacings.gapM,
                          // Champ To
                          _SearchTextField(
                            onTap: _selectToLocation,
                            controller: _toController,
                            placeholder: 'To',
                            readOnly: true,
                          ),
                          AppSpacings.gapM,
                          // Séparateur
                          const Divider(height: 1),
                          AppSpacings.gapM,
                          // Date - cliquable
                          GestureDetector(
                            onTap: _selectDate,
                            child: _InfoRow(
                              icon: LucideIcons.calendar,
                              label: _formatDate(_selectedDate),
                            ),
                          ),
                          AppSpacings.gapM,
                          // Séparateur
                          const Divider(height: 1),
                          AppSpacings.gapM,
                          // Nombre de personnes - cliquable
                          GestureDetector(
                            onTap: _showPeopleDialog,
                            child: Row(
                              children: [
                                Icon(
                                  LucideIcons.users,
                                  size: 18,
                                  color: context.colorScheme.onSurfaceVariant,
                                ),
                                AppSpacings.gapS,
                                Text(
                                  '$_numberOfPeople ${_numberOfPeople == 1 ? 'personne' : 'personnes'}',
                                  style: context.textTheme.bodyMedium,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Bouton Find a Ride en bas
            Padding(
              padding: AppSpacings.pL,
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _findRide,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: context.colorScheme.primary,
                    foregroundColor: context.colorScheme.onPrimary,
                    padding: const EdgeInsets.symmetric(vertical: 18),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    'Find a Ride',
                    style: context.textTheme.labelLarge?.copyWith(fontSize: 16),
                  ),
                ),
              ),
            ),
            AppSpacings.gapL,
          ],
        ),
      ),
    );
  }
}

/// Widget pour les champs de texte de recherche
class _SearchTextField extends StatelessWidget {
  final TextEditingController controller;
  final String placeholder;
  final bool readOnly;
  final GestureTapCallback? onTap;

  const _SearchTextField({
    required this.controller,
    required this.placeholder,
    this.readOnly = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTap: onTap,
      controller: controller,
      readOnly: readOnly,
      decoration: InputDecoration(
        hintText: placeholder,
        hintStyle: context.textTheme.bodyLarge?.copyWith(
          color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
        ),
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        focusedBorder: InputBorder.none,
        contentPadding: EdgeInsets.zero,
      ),
      style: context.textTheme.bodyLarge,
    );
  }
}

/// Widget pour les lignes d'information (date, heure)
class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoRow({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: context.colorScheme.onSurfaceVariant),
        AppSpacings.gapS,
        Text(label, style: context.textTheme.bodyMedium),
      ],
    );
  }
}
