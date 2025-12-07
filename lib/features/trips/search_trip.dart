import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart' as lucide;
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:gap/gap.dart';

class SearchTripPage extends StatefulWidget {
  const SearchTripPage({super.key});

  @override
  State<SearchTripPage> createState() => _SearchTripPageState();
}

class _SearchTripPageState extends State<SearchTripPage> {
  int _currentTabIndex = 0;
  late TextEditingController _departureController;
  late TextEditingController _destinationController;
  DateTime _selectedDate = DateTime.now();
  TimeOfDay _selectedTime = TimeOfDay.now();
  int _numberOfPeople = 1;

  @override
  void initState() {
    super.initState();
    _departureController = TextEditingController(text: 'Votre position actuelle');
    _destinationController = TextEditingController();
  }

  @override
  void dispose() {
    _departureController.dispose();
    _destinationController.dispose();
    super.dispose();
  }

  void _onTabChanged(int index) {
    setState(() {
      _currentTabIndex = index;
    });

    // Navigation selon l'onglet sélectionné
    switch (index) {
      case 0:
        // Déjà sur la page de recherche
        break;
      case 1:
        // Navigator.pushNamed(context, '/bookings');
        break;
      case 2:
        // Navigator.pushNamed(context, '/profile');
        break;
    }
  }

  void _searchTrip() {
    if (_destinationController.text.isEmpty) {
      ShadToaster.of(context).show(
        const ShadToast(
          description: Text('Veuillez entrer une destination'),
        ),
      );
      return;
    }

    // Navigation vers les résultats de recherche
    ShadToaster.of(context).show(
      ShadToast(
        description: Text(
          'Recherche de trajets vers ${_destinationController.text}...',
        ),
      ),
    );
  }

  void _selectDateTime() {
    showShadSheet(
      context: context,
      builder: (context) => _DateTimePickerSheet(
        selectedDate: _selectedDate,
        selectedTime: _selectedTime,
        onConfirm: (DateTime date, TimeOfDay time) {
          setState(() {
            _selectedDate = date;
            _selectedTime = time;
          });
        },
      ),
    );
  }

  void _selectNumberOfPeople() {
    showShadSheet(
      context: context,
      builder: (context) => _PeoplePickerSheet(
        selectedNumber: _numberOfPeople,
        onConfirm: (int number) {
          setState(() {
            _numberOfPeople = number;
          });
        },
      ),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final tomorrow = today.add(const Duration(days: 1));
    final selectedDay = DateTime(date.year, date.month, date.day);

    if (selectedDay == today) {
      return "Aujourd'hui";
    } else if (selectedDay == tomorrow) {
      return 'Demain';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  String _formatTime(TimeOfDay time) {
    return '${time.hour.toString().padLeft(2, '0')}:${time.minute.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Carte en arrière-plan
            const _MapView(),
            // Carte de recherche en overlay
            _SearchCard(
              departureController: _departureController,
              destinationController: _destinationController,
              selectedDate: _formatDate(_selectedDate),
              selectedTime: _formatTime(_selectedTime),
              numberOfPeople: _numberOfPeople,
              onSearch: _searchTrip,
              onSelectDateTime: _selectDateTime,
              onSelectPeople: _selectNumberOfPeople,
            ),
          ],
        ),
      ),
      bottomNavigationBar: _BottomTabBar(
        currentIndex: _currentTabIndex,
        onTabChanged: _onTabChanged,
      ),
    );
  }
}

/// Widget pour la carte de recherche
class _SearchCard extends StatelessWidget {
  final TextEditingController departureController;
  final TextEditingController destinationController;
  final String selectedDate;
  final String selectedTime;
  final int numberOfPeople;
  final VoidCallback onSearch;
  final VoidCallback onSelectDateTime;
  final VoidCallback onSelectPeople;

  const _SearchCard({
    required this.departureController,
    required this.destinationController,
    required this.selectedDate,
    required this.selectedTime,
    required this.numberOfPeople,
    required this.onSearch,
    required this.onSelectDateTime,
    required this.onSelectPeople,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        margin: const EdgeInsets.all(16),
        child: ShadCard(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Champ Départ
              _LocationField(
                icon: lucide.LucideIcons.circle,
                label: 'Départ',
                controller: departureController,
                iconColor: ShadTheme.of(context).colorScheme.primary,
              ),
              const Gap(16),
              // Champ Destination
              _LocationField(
                icon: lucide.LucideIcons.mapPin,
                label: 'Destination',
                controller: destinationController,
                placeholder: 'Où allez-vous ?',
                iconColor: ShadTheme.of(context).colorScheme.destructive,
              ),
              const Gap(16),
              // Date/heure et nombre de personnes
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: GestureDetector(
                      onTap: onSelectDateTime,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ShadTheme.of(context).colorScheme.input,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              lucide.LucideIcons.calendar,
                              size: 18,
                              color: ShadTheme.of(context)
                                  .colorScheme
                                  .mutedForeground,
                            ),
                            const Gap(8),
                            Expanded(
                              child: Text(
                                '$selectedDate • $selectedTime',
                                style: ShadTheme.of(context).textTheme.small,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Icon(
                              lucide.LucideIcons.chevronDown,
                              size: 16,
                              color: ShadTheme.of(context)
                                  .colorScheme
                                  .mutedForeground,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: GestureDetector(
                      onTap: onSelectPeople,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: ShadTheme.of(context).colorScheme.input,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              lucide.LucideIcons.users,
                              size: 18,
                              color: ShadTheme.of(context)
                                  .colorScheme
                                  .mutedForeground,
                            ),
                            const Gap(8),
                            Text(
                              '$numberOfPeople',
                              style: ShadTheme.of(context).textTheme.small,
                            ),
                            Icon(
                              lucide.LucideIcons.chevronDown,
                              size: 16,
                              color: ShadTheme.of(context)
                                  .colorScheme
                                  .mutedForeground,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
              // Bouton de recherche
              ShadButton(
                onPressed: onSearch,
                size: ShadButtonSize.lg,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      lucide.LucideIcons.search,
                      size: 20,
                      color: ShadTheme.of(context).colorScheme.primaryForeground,
                    ),
                    const Gap(8),
                    const Text('Trouver un trajet'),
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

/// Widget pour un champ de localisation
class _LocationField extends StatelessWidget {
  final IconData icon;
  final String label;
  final TextEditingController controller;
  final String? placeholder;
  final Color? iconColor;

  const _LocationField({
    required this.icon,
    required this.label,
    required this.controller,
    this.placeholder,
    this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: iconColor ?? ShadTheme.of(context).colorScheme.primary,
        ),
        const Gap(12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label,
                style: ShadTheme.of(context).textTheme.small.copyWith(
                      color: ShadTheme.of(context).colorScheme.mutedForeground,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              const Gap(4),
              ShadInput(
                controller: controller,
                placeholder: Text(placeholder ?? ''),
                style: ShadTheme.of(context).textTheme.p.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

/// Widget pour la vue carte (placeholder)
class _MapView extends StatelessWidget {
  const _MapView();

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ShadTheme.of(context).colorScheme.muted.withValues(alpha: 0.3),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              lucide.LucideIcons.map,
              size: 64,
              color: ShadTheme.of(context).colorScheme.mutedForeground,
            ),
            const Gap(16),
            Text(
              'Carte d\'Abidjan',
              style: ShadTheme.of(context).textTheme.large.copyWith(
                    color: ShadTheme.of(context).colorScheme.mutedForeground,
                  ),
            ),
            const Gap(8),
            Text(
              'Intégration Google Maps à venir',
              style: ShadTheme.of(context).textTheme.small.copyWith(
                    color: ShadTheme.of(context).colorScheme.mutedForeground,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget pour la barre d'onglets en bas
class _BottomTabBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTabChanged;

  const _BottomTabBar({
    required this.currentIndex,
    required this.onTabChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: ShadTheme.of(context).colorScheme.background,
        border: Border(
          top: BorderSide(
            color: ShadTheme.of(context).colorScheme.border,
            width: 1,
          ),
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _TabItem(
                icon: lucide.LucideIcons.search,
                label: 'Trajets',
                isActive: currentIndex == 0,
                onTap: () => onTabChanged(0),
              ),
              _TabItem(
                icon: lucide.LucideIcons.ticket,
                label: 'Réservations',
                isActive: currentIndex == 1,
                onTap: () => onTabChanged(1),
              ),
              _TabItem(
                icon: lucide.LucideIcons.user,
                label: 'Profil',
                isActive: currentIndex == 2,
                onTap: () => onTabChanged(2),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget pour un élément d'onglet
class _TabItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = ShadTheme.of(context).colorScheme;
    final activeColor = const Color(0xFFF97316); // Orange

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 24,
              color: isActive ? activeColor : colorScheme.mutedForeground,
            ),
            const Gap(4),
            Text(
              label,
              style: ShadTheme.of(context).textTheme.small.copyWith(
                    color: isActive ? activeColor : colorScheme.mutedForeground,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sheet pour sélectionner date et heure avec ShadCalendar et ShadTimePicker
class _DateTimePickerSheet extends StatefulWidget {
  final DateTime selectedDate;
  final TimeOfDay selectedTime;
  final Function(DateTime, TimeOfDay) onConfirm;

  const _DateTimePickerSheet({
    required this.selectedDate,
    required this.selectedTime,
    required this.onConfirm,
  });

  @override
  State<_DateTimePickerSheet> createState() => _DateTimePickerSheetState();
}

class _DateTimePickerSheetState extends State<_DateTimePickerSheet> {
  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    _selectedDate = widget.selectedDate;
    _selectedTime = widget.selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    return ShadSheet(
      title: const Text('Choisir la date et l\'heure'),
      description: const Text('Sélectionnez quand vous souhaitez partir'),
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Calendrier
            ShadCalendar(
              selected: _selectedDate,
              onChanged: (date) {
                if (date != null) {
                  setState(() {
                    _selectedDate = date;
                  });
                }
              },
            ),
            const Gap(24),
            // Sélection de l'heure avec ShadTimePicker
            Text(
              'Heure',
              style: ShadTheme.of(context).textTheme.small.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
            ),
            const Gap(12),
            ShadTimePicker(
              initialValue: ShadTimeOfDay(
                hour: _selectedTime.hour,
                minute: _selectedTime.minute,
                second: 0,
              ),
              onChanged: (time) {
                setState(() {
                  _selectedTime = TimeOfDay(
                    hour: time.hour,
                    minute: time.minute,
                  );
                });
              },
            ),
            const Gap(24),
            ShadButton(
              onPressed: () {
                widget.onConfirm(_selectedDate, _selectedTime);
                Navigator.pop(context);
              },
              size: ShadButtonSize.lg,
              child: const Text('Confirmer'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Sheet pour sélectionner le nombre de personnes
class _PeoplePickerSheet extends StatefulWidget {
  final int selectedNumber;
  final Function(int) onConfirm;

  const _PeoplePickerSheet({
    required this.selectedNumber,
    required this.onConfirm,
  });

  @override
  State<_PeoplePickerSheet> createState() => _PeoplePickerSheetState();
}

class _PeoplePickerSheetState extends State<_PeoplePickerSheet> {
  late int _selectedNumber;

  @override
  void initState() {
    super.initState();
    _selectedNumber = widget.selectedNumber;
  }

  @override
  Widget build(BuildContext context) {
    return ShadSheet(
      title: const Text('Nombre de personnes'),
      description: const Text('Combien de places souhaitez-vous réserver ?'),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Sélecteur de nombre
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShadButton.outline(
                  onPressed: _selectedNumber > 1
                      ? () {
                          setState(() {
                            _selectedNumber--;
                          });
                        }
                      : null,
                  child: const Icon(lucide.LucideIcons.minus, size: 20),
                ),
                const Gap(32),
                Text(
                  '$_selectedNumber',
                  style: ShadTheme.of(context).textTheme.h2.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
                const Gap(32),
                ShadButton.outline(
                  onPressed: _selectedNumber < 8
                      ? () {
                          setState(() {
                            _selectedNumber++;
                          });
                        }
                      : null,
                  child: const Icon(lucide.LucideIcons.plus, size: 20),
                ),
              ],
            ),
            const Gap(16),
            Text(
              _selectedNumber == 1 ? '1 personne' : '$_selectedNumber personnes',
              textAlign: TextAlign.center,
              style: ShadTheme.of(context).textTheme.muted,
            ),
            const Gap(32),
            ShadButton(
              onPressed: () {
                widget.onConfirm(_selectedNumber);
                Navigator.pop(context);
              },
              size: ShadButtonSize.lg,
              child: const Text('Confirmer'),
            ),
          ],
        ),
      ),
    );
  }
}

