import 'package:allonsvite/core/router/app_routes.dart';
import 'package:allonsvite/features/rides/presentation/controllers/ride_list_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extension/build_context_ext.dart';
import '../../../../core/themes/app_spacing.dart';
import '../../domain/model/ride.dart';

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
          error: (error, stack) =>
              Center(child: Text(context.l10n.errorPrefix(error.toString()))),
          data: (rides) {
            if (rides.isEmpty) {
              return Center(child: Text(context.l10n.noRidesFound));
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
                            const Spacer(),
                            // Selected Date at the top
                            if (params.date != null)
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: context.colorScheme.primaryContainer,
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  DateFormat('EEE, d MMM').format(params.date!),
                                  style: context.textTheme.labelMedium
                                      ?.copyWith(
                                        color: context
                                            .colorScheme
                                            .onPrimaryContainer,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                          ],
                        ),
                        AppSpacings.gapS,
                        // Détails du trajet
                        Text(
                          '${params.seats ?? 1} ${(params.seats ?? 1) > 1 ? context.l10n.passengers : context.l10n.passenger}',
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
                  ),
                  AppSpacings.gapXL,
                  // Section: Trajets disponibles
                  Padding(
                    padding: AppSpacings.phM,
                    child: Text(
                      '${context.l10n.availableRides} (${rides.length})',
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
                        ride: ride,
                        onTap: () {
                          context.push('${AppRoutes.rideDetails}/${ride.id}');
                        },
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
  final Ride ride;
  final VoidCallback? onTap;

  const _RideCard({required this.ride, this.onTap});

  @override
  Widget build(BuildContext context) {
    // Calcul de la durée
    final duration = ride.endAt.difference(ride.startAt);
    final durationString =
        '${duration.inHours}h${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}';

    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: AppSpacings.phM,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(
              color: context.colorScheme.outlineVariant,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.03),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          padding: AppSpacings.pL,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        // Start Time & Pickup
                        Row(
                          children: [
                            Text(
                              DateFormat('HH:mm').format(ride.startAt),
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AppSpacings.gapM,
                            Icon(
                              LucideIcons.circleDot, // Start icon
                              size: 14,
                              color: context.colorScheme.primary,
                            ),
                            AppSpacings.gapM,
                            Expanded(
                              child: Text(
                                ride.pickupSpot,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                        // Connector line
                        Row(
                          children: [
                            const SizedBox(width: 53), // Align with dots
                            Container(
                              height: 20,
                              width: 2,
                              color: context.colorScheme.outlineVariant,
                            ),
                            AppSpacings.gapM,
                            Text(
                              durationString,
                              style: context.textTheme.labelSmall?.copyWith(
                                color: context.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                        // End Time & Dropoff
                        Row(
                          children: [
                            Text(
                              DateFormat('HH:mm').format(ride.endAt),
                              style: context.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            AppSpacings.gapM,
                            Icon(
                              LucideIcons.mapPin, // End icon
                              size: 14,
                              color: context.colorScheme.primary,
                            ),
                            AppSpacings.gapM,
                            Expanded(
                              child: Text(
                                ride.arrivalSpot,
                                style: context.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w500,
                                ),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  // Price and Seats
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${ride.price} FCFA',
                        style: context.textTheme.titleMedium?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      AppSpacings.gapS,
                      Row(
                        children: [
                          Icon(
                            LucideIcons.armchair,
                            size: 14,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(width: 4),
                          Text(
                            '${ride.numberOfSeats}',
                            style: context.textTheme.labelMedium?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              AppSpacings.gapM,
              // Driver info placeholder (since not in Ride model yet)
              const Divider(),
              AppSpacings.gapS,
              Row(
                children: [
                  const CircleAvatar(
                    radius: 12,
                    // Placeholder color
                    backgroundColor: Colors.grey,
                    child: Icon(Icons.person, size: 16, color: Colors.white),
                  ),
                  AppSpacings.gapS,
                  Text(
                    context.l10n.driver,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                  const Spacer(),
                  const Icon(Icons.star, size: 14, color: Colors.amber),
                  const SizedBox(width: 4),
                  Text(
                    '4.8',
                    style: context.textTheme.labelSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
