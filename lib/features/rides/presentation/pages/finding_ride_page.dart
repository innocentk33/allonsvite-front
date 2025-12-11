import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extension/build_context_ext.dart';
import '../../../../core/themes/app_spacing.dart';
import '../../domain/ride.dart';
import '../controllers/ride_list_controller.dart';

class FindingRidePage extends ConsumerWidget {
  final RideSearchParams params;

  const FindingRidePage({super.key, this.params = const RideSearchParams()});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ridesAsync = ref.watch(rideListControllerProvider(params));

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
        child: ridesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, stack) => Center(child: Text('Erreur: $error')),
          data: (rides) {
            if (rides.isEmpty) {
              return const Center(child: Text('Aucun trajet trouvé.'));
            }
            return SingleChildScrollView(
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
                              params.fromLocation ?? '',
                              style: context.textTheme.titleMedium?.copyWith(
                                color: context.colorScheme.primary,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            AppSpacings.gapS,
                            Icon(
                              LucideIcons.arrowRight,
                              size: 16,
                              color: context.colorScheme.primary,
                            ),
                            AppSpacings.gapS,
                            Text(
                              params.toLocation ?? '',
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
                          '${params.date?.toLocal().toString().split(' ')[0] ?? ''} • ${params.seats ?? 1} Seats',
                          style: context.textTheme.bodySmall?.copyWith(
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  AppSpacings.gapL,
                  // Filtres (Statique pour l'instant)
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: AppSpacings.phM,
                    child: Row(
                      children: const [
                        _FilterChip(label: 'All', isActive: true),
                        AppSpacings.gapS,
                        _FilterChip(label: 'Male only', isActive: false),
                        AppSpacings.gapS,
                        _FilterChip(label: 'Female only', isActive: false),
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

                  // Liste des trajets
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: rides.length,
                    separatorBuilder: (context, index) => AppSpacings.gapM,
                    itemBuilder: (context, index) {
                      final ride = rides[index];
                      return _RideCard(
                        driverName:
                            'Chauffeur ${ride.id}', // Placeholder, pas de nom dans le modèle Ride pour l'instant
                        departureTime:
                            'Départ: ${ride.startAt.hour}:${ride.startAt.minute}',
                        distance: '', // Pas de distance dans le JSON
                        price: '${ride.price} FCFA',
                        rating: 4.5, // Placeholder
                        seats: ride.numberOfSeats,
                        avatarColor: Colors.blue, // Placeholder
                      );
                    },
                  ),
                  AppSpacings.gapXL,
                ],
              ),
            );
          },
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
          border: Border.all(color: context.colorScheme.outline, width: 1),
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
                            LucideIcons.users,
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

  const _FilterChip({required this.label, required this.isActive});

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
