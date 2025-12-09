import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart' as lucide;
import '../../core/extension/build_context_ext.dart';
import '../../core/themes/app_spacing.dart';

class FindingRidePage extends StatelessWidget {
  const FindingRidePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête avec localisation et détails
              Padding(
                padding: AppSpacings.pL,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Localisation
                    Row(
                      children: [
                        Text(
                          'Cold Stone ..., Yaba',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        AppSpacings.gapS,
                        Icon(
                          lucide.LucideIcons.arrowRight,
                          size: 16,
                          color: context.colorScheme.primary,
                        ),
                        AppSpacings.gapS,
                        Text(
                          'Lekki Phase 1, Lekki',
                          style: context.textTheme.titleMedium?.copyWith(
                            color: context.colorScheme.primary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                    AppSpacings.gapS,
                    // Détails du trajet
                    Text(
                      'Fri 18 Aug • 06:00 AM • 2 Seats',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacings.gapL,
              // Filtres
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: AppSpacings.phM,
                child: Row(
                  children: [
                    _FilterChip(
                      label: 'All',
                      isActive: true,
                    ),
                    AppSpacings.gapS,
                    _FilterChip(
                      label: 'Male only',
                      isActive: false,
                    ),
                    AppSpacings.gapS,
                    _FilterChip(
                      label: 'Female only',
                      isActive: false,
                    ),
                  ],
                ),
              ),
              AppSpacings.gapXL,
              // Section: Trajets disponibles
              Padding(
                padding: AppSpacings.phM,
                child: Text(
                  'AVAILABLE RIDES',
                  style: context.textTheme.labelSmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontSize: 12,
                  ),
                ),
              ),
              AppSpacings.gapM,
              // Sous-titre: Drivers previously shared
              Padding(
                padding: AppSpacings.phM,
                child: Text(
                  'Drivers you previously shared a ride with',
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              AppSpacings.gapM,
              // Cards des chauffeurs
              _RideCard(
                driverName: 'Olakunle Diran',
                departureTime: 'Departs at 06:00 AM',
                distance: '0.3km away',
                price: '₦2,500',
                rating: 4.9,
                seats: 1,
                avatarColor: Colors.blue,
              ),
              AppSpacings.gapM,
              _RideCard(
                driverName: 'Oduola Toyosi',
                departureTime: 'Departs at 06:15 AM',
                distance: '0.4km away',
                price: '₦4,000',
                rating: 4.8,
                seats: 2,
                avatarColor: Colors.orange,
              ),
              AppSpacings.gapM,
              _RideCard(
                driverName: 'Emmanuel Ismail',
                departureTime: 'Departs at 06:15 AM',
                distance: '0.4km away',
                price: '₦3,500',
                rating: 4.7,
                seats: 1,
                avatarColor: Colors.green,
              ),
              AppSpacings.gapXL,
              // Section: People in contact
              Padding(
                padding: AppSpacings.phM,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'People in you contact',
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    AppSpacings.gapS,
                    Text(
                      'These suggestions are based off people in your contact\nwho are on Hitch.',
                      style: context.textTheme.bodySmall?.copyWith(
                        color: context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              AppSpacings.gapL,
              // Cards des contacts
              _RideCard(
                driverName: 'Ogunderu Noah',
                departureTime: 'Departs at 06:00 AM',
                distance: '0.3km away',
                price: '₦2,500',
                rating: 4.2,
                seats: 1,
                avatarColor: Colors.cyan,
              ),
              AppSpacings.gapM,
              _RideCard(
                driverName: 'Subomi Fortune',
                departureTime: 'Departs at 06:15 AM',
                distance: '0.4km away',
                price: '₦4,000',
                rating: 4.6,
                seats: 2,
                avatarColor: Colors.purple,
              ),
              AppSpacings.gapXL,
            ],
          ),
        ),
      ),
    );
  }
}

/// Widget stateless pour une carte de trajet
class _RideCard extends StatelessWidget {
  final String driverName;
  final String departureTime;
  final String distance;
  final String price;
  final double rating;
  final int seats;
  final Color avatarColor;

  const _RideCard({
    required this.driverName,
    required this.departureTime,
    required this.distance,
    required this.price,
    required this.rating,
    required this.seats,
    required this.avatarColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: AppSpacings.phM,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(
            color: context.colorScheme.outline,
            width: 1,
          ),
          borderRadius: BorderRadius.circular(12),
        ),
        padding: AppSpacings.pL,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // En-tête: Avatar, nom, prix
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Avatar
                CircleAvatar(
                  radius: 28,
                  backgroundColor: avatarColor,
                  child: Text(
                    rating.toString(),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                AppSpacings.gapM,
                // Informations du chauffeur
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        driverName,
                        style: context.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      AppSpacings.gapS,
                      Row(
                        children: [
                          Text(
                            departureTime,
                            style: context.textTheme.bodySmall?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                          AppSpacings.gapS,
                          Icon(
                            lucide.LucideIcons.users,
                            size: 14,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ],
                      ),
                      AppSpacings.gapS,
                      Text(
                        distance,
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),
                // Prix
                Text(
                  price,
                  style: context.textTheme.titleSmall?.copyWith(
                    color: context.colorScheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Widget stateless pour un chip de filtre
class _FilterChip extends StatelessWidget {
  final String label;
  final bool isActive;

  const _FilterChip({
    required this.label,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacings.l,
        vertical: AppSpacings.s,
      ),
      decoration: BoxDecoration(
        color: isActive
            ? context.colorScheme.primary
            : context.colorScheme.secondaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        label,
        style: context.textTheme.labelSmall?.copyWith(
          color: isActive
              ? context.colorScheme.onPrimary
              : context.colorScheme.onSecondaryContainer,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}

