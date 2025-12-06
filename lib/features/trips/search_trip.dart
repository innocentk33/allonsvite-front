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
  String _selectedDate = "Aujourd'hui";
  String _selectedTime = 'Maintenant';

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
    // Ouvrir un modal pour sélectionner date et heure
    showShadSheet(
      context: context,
      builder: (context) => _DateTimePickerSheet(
        selectedDate: _selectedDate,
        selectedTime: _selectedTime,
        onConfirm: (date, time) {
          setState(() {
            _selectedDate = date;
            _selectedTime = time;
          });
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Stack(
        children: [
          // Carte en arrière-plan
          const _MapView(),
          // Carte de recherche en overlay
          _SearchCard(
            departureController: _departureController,
            destinationController: _destinationController,
            selectedDate: _selectedDate,
            selectedTime: _selectedTime,
            onSearch: _searchTrip,
            onSelectDateTime: _selectDateTime,
          ),
        ],
      ),
      bottomNavigationBar: _BottomTabBar(
        currentIndex: _currentTabIndex,
        onTabChanged: _onTabChanged,
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: ShadTheme.of(context).colorScheme.background,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: Center(
          child: CircleAvatar(
            radius: 18,
            backgroundColor: ShadTheme.of(context).colorScheme.primary,
            child: Text(
              'A',
              style: ShadTheme.of(context).textTheme.small.copyWith(
                    color: ShadTheme.of(context).colorScheme.primaryForeground,
                    fontWeight: FontWeight.bold,
                  ),
            ),
          ),
        ),
      ),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            lucide.LucideIcons.mapPin,
            size: 18,
            color: ShadTheme.of(context).colorScheme.foreground,
          ),
          const Gap(8),
          Text(
            'Abidjan',
            style: ShadTheme.of(context).textTheme.p.copyWith(
                  fontWeight: FontWeight.w600,
                ),
          ),
        ],
      ),
      actions: [
        ShadButton.ghost(
          onPressed: () {
            // Ouvrir les notifications
          },
          child: Icon(
            lucide.LucideIcons.bell,
            size: 20,
            color: ShadTheme.of(context).colorScheme.foreground,
          ),
        ),
        const Gap(8),
      ],
    );
  }
}

/// Widget pour la carte de recherche
class _SearchCard extends StatelessWidget {
  final TextEditingController departureController;
  final TextEditingController destinationController;
  final String selectedDate;
  final String selectedTime;
  final VoidCallback onSearch;
  final VoidCallback onSelectDateTime;

  const _SearchCard({
    required this.departureController,
    required this.destinationController,
    required this.selectedDate,
    required this.selectedTime,
    required this.onSearch,
    required this.onSelectDateTime,
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
              // Date et heure
              GestureDetector(
                onTap: onSelectDateTime,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
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
                      Row(
                        children: [
                          Icon(
                            lucide.LucideIcons.calendar,
                            size: 18,
                            color: ShadTheme.of(context)
                                .colorScheme
                                .mutedForeground,
                          ),
                          const Gap(8),
                          Text(
                            '$selectedDate • $selectedTime',
                            style: ShadTheme.of(context).textTheme.p,
                          ),
                        ],
                      ),
                      Icon(
                        lucide.LucideIcons.chevronRight,
                        size: 18,
                        color:
                            ShadTheme.of(context).colorScheme.mutedForeground,
                      ),
                    ],
                  ),
                ),
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

/// Sheet pour sélectionner date et heure
class _DateTimePickerSheet extends StatefulWidget {
  final String selectedDate;
  final String selectedTime;
  final Function(String, String) onConfirm;

  const _DateTimePickerSheet({
    required this.selectedDate,
    required this.selectedTime,
    required this.onConfirm,
  });

  @override
  State<_DateTimePickerSheet> createState() => _DateTimePickerSheetState();
}

class _DateTimePickerSheetState extends State<_DateTimePickerSheet> {
  late String _date;
  late String _time;

  @override
  void initState() {
    super.initState();
    _date = widget.selectedDate;
    _time = widget.selectedTime;
  }

  @override
  Widget build(BuildContext context) {
    return ShadSheet(
      title: const Text('Choisir la date et l\'heure'),
      description: const Text('Sélectionnez quand vous souhaitez partir'),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Options de date
            _buildOption(
              'Aujourd\'hui',
              _date == 'Aujourd\'hui',
              () => setState(() => _date = 'Aujourd\'hui'),
            ),
            const Gap(8),
            _buildOption(
              'Demain',
              _date == 'Demain',
              () => setState(() => _date = 'Demain'),
            ),
            const Gap(24),
            // Options d'heure
            _buildOption(
              'Maintenant',
              _time == 'Maintenant',
              () => setState(() => _time = 'Maintenant'),
            ),
            const Gap(8),
            _buildOption(
              'Dans 1 heure',
              _time == 'Dans 1 heure',
              () => setState(() => _time = 'Dans 1 heure'),
            ),
            const Gap(24),
            ShadButton(
              onPressed: () {
                widget.onConfirm(_date, _time);
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

  Widget _buildOption(String label, bool isSelected, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? ShadTheme.of(context).colorScheme.primary.withValues(alpha: 0.1)
              : Colors.transparent,
          border: Border.all(
            color: isSelected
                ? ShadTheme.of(context).colorScheme.primary
                : ShadTheme.of(context).colorScheme.input,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              label,
              style: ShadTheme.of(context).textTheme.p.copyWith(
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                  ),
            ),
            if (isSelected)
              Icon(
                lucide.LucideIcons.check,
                size: 20,
                color: ShadTheme.of(context).colorScheme.primary,
              ),
          ],
        ),
      ),
    );
  }
}

