import 'package:allonsvite/features/rides/presentation/pages/search_ride_page.dart';

import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart' as lucide;
import 'package:allonsvite/core/extension/build_context_ext.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _selectedIndex,
        children: const [
          SearchRidePage(),
          _PublishTripPage(),
          _TripsPage(),
          _ProfilePage(),
        ],
      ),
      bottomNavigationBar: _buildBottomAppBar(context),
    );
  }

  /// Construit la BottomAppBar
  Widget _buildBottomAppBar(BuildContext context) {
    final colorScheme = context.colorScheme;
    final activeColor = colorScheme.primary;
    final inactiveColor = colorScheme.onSurfaceVariant;

    return BottomAppBar(
      elevation: 8,
      child: SizedBox(
        height: 70,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            // Recherche - Home
            _NavBarItem(
              icon: lucide.LucideIcons.search,
              label: 'Recherche',
              isActive: _selectedIndex == 0,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              onTap: () => setState(() => _selectedIndex = 0),
            ),
            // Publier
            _NavBarItem(
              icon: lucide.LucideIcons.plus,
              label: 'Publier',
              isActive: _selectedIndex == 1,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              onTap: () => setState(() => _selectedIndex = 1),
            ),
            // Trajets - Voiture
            _NavBarItem(
              icon: lucide.LucideIcons.car,
              label: 'Trajets',
              isActive: _selectedIndex == 2,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              onTap: () => setState(() => _selectedIndex = 2),
            ),
            // Profil
            _NavBarItem(
              icon: lucide.LucideIcons.user,
              label: 'Profil',
              isActive: _selectedIndex == 3,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              onTap: () => setState(() => _selectedIndex = 3),
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget stateless pour chaque élément de la BottomAppBar
class _NavBarItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isActive;
  final Color activeColor;
  final Color inactiveColor;
  final VoidCallback onTap;

  const _NavBarItem({
    required this.icon,
    required this.label,
    required this.isActive,
    required this.activeColor,
    required this.inactiveColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 20, color: isActive ? activeColor : inactiveColor),
            const SizedBox(height: 2),
            Text(
              label,
              style: context.textTheme.labelSmall?.copyWith(
                color: isActive ? activeColor : inactiveColor,
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Page placeholder - Publier un trajet
class _PublishTripPage extends StatelessWidget {
  const _PublishTripPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            lucide.LucideIcons.plus,
            size: 64,
            color: context.colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text('Publier un trajet', style: context.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Partagez votre trajet',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// Page placeholder - Trajets
class _TripsPage extends StatelessWidget {
  const _TripsPage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            lucide.LucideIcons.car,
            size: 64,
            color: context.colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text('Mes trajets', style: context.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Vos trajets en cours',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

/// Page placeholder - Profil
class _ProfilePage extends StatelessWidget {
  const _ProfilePage();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            lucide.LucideIcons.user,
            size: 64,
            color: context.colorScheme.primary,
          ),
          const SizedBox(height: 16),
          Text('Mon profil', style: context.textTheme.headlineSmall),
          const SizedBox(height: 8),
          Text(
            'Gérez votre profil',
            style: context.textTheme.bodyMedium?.copyWith(
              color: context.colorScheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
