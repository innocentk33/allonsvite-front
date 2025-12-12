import 'package:allonsvite/core/extension/build_context_ext.dart';
import 'package:allonsvite/core/themes/app_spacing.dart';
import 'package:allonsvite/features/rides/domain/model/ride_detail.dart';
import 'package:allonsvite/core/widgets/button_with_loading.dart';

import 'package:allonsvite/features/rides/presentation/providers/ride_detail_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RideDetailPage extends ConsumerWidget {
  final int rideId;

  const RideDetailPage({super.key, required this.rideId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final rideAsync = ref.watch(rideDetailControllerProvider(rideId));

    return Scaffold(
      backgroundColor: context.colorScheme.surface, // Standard background
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'BOOK RIDE',
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: Colors.black,
            letterSpacing: 1.2,
          ),
        ),
      ),
      body: rideAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (ride) {
          return Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  padding: AppSpacings.pL,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _AddressCard(ride: ride),
                      AppSpacings.gapL,
                      _RideOptions(ride: ride),
                      AppSpacings.gapL,
                      _DriverCard(ride: ride),
                      AppSpacings.gapL,
                    ],
                  ),
                ),
              ),
              _BottomSection(ride: ride),
            ],
          );
        },
      ),
    );
  }
}

class _AddressCard extends StatelessWidget {
  final RideDetail ride;

  const _AddressCard({required this.ride});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: context.colorScheme.outlineVariant, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: AppSpacings.pL,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Departure',
            style: context.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          AppSpacings.gapM,
          _buildAddressRow(context, 'FROM', ride.pickupSpot),
          const Divider(height: 24, thickness: 0.5),
          _buildAddressRow(context, 'TO', ride.arrivalSpot),
          const Divider(height: 24, thickness: 0.5),
          // Using pickupSpot/arrivalSpot again as we don't have separate fields
          _buildAddressRow(context, 'PICK UP', ride.pickupSpot),
          const Divider(height: 24, thickness: 0.5),
          _buildAddressRow(context, 'DROP OFF', ride.arrivalSpot),
        ],
      ),
    );
  }

  Widget _buildAddressRow(BuildContext context, String label, String value) {
    return Row(
      children: [
        Icon(LucideIcons.mapPin, size: 18, color: context.colorScheme.primary),
        AppSpacings.gapM,
        Text(
          label,
          style: context.textTheme.labelSmall?.copyWith(
            color: context.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
        AppSpacings.gapM,
        Expanded(
          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                value,
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _RideOptions extends StatelessWidget {
  final RideDetail ride;

  const _RideOptions({required this.ride});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildOptionRow(
              context,
              LucideIcons.clock,
              'Start',
              DateFormat('HH:mm').format(ride.startAt),
            ),
            _buildOptionRow(
              context,
              LucideIcons.clock,
              'End',
              DateFormat('HH:mm').format(ride.endAt),
            ),
          ],
        ),

        AppSpacings.gapM,
        _buildOptionRow(
          context,
          LucideIcons.user,
          'Seats',
          '${ride.numberOfSeats}',
          isDropdown: true,
        ),
      ],
    );
  }

  Widget _buildOptionRow(
    BuildContext context,
    IconData icon,
    String label,
    String value, {
    bool isDropdown = false,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 20, color: context.colorScheme.onSurface),
        AppSpacings.gapS,
        Text(
          label,
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w500,
          ),
        ),
        AppSpacings.gapM,
        if (isDropdown)
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                Text(
                  value,
                  style: context.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(width: 4),
                const Icon(Icons.keyboard_arrow_down, size: 16),
              ],
            ),
          )
        else
          Text(
            value,
            style: context.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
      ],
    );
  }
}

class _DriverCard extends StatelessWidget {
  final RideDetail ride;

  const _DriverCard({required this.ride});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: AppSpacings.pL,
      child: Row(
        children: [
          CircleAvatar(
            radius: 24,
            backgroundColor: context.colorScheme.primaryContainer,
            child: Text(
              ride.driver.firstname[0].toUpperCase(),
              style: context.textTheme.titleMedium?.copyWith(
                color: context.colorScheme.onPrimaryContainer,
              ),
            ),
          ),
          AppSpacings.gapM,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${ride.driver.firstname} ${ride.driver.lastname}',
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Toyota Camry • JJJ 452 FZ', // Placeholder
                  style: context.textTheme.bodySmall?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Text(
                    '4.9',
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(width: 4),
                  const Icon(Icons.star, size: 16, color: Colors.amber),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BottomSection extends StatelessWidget {
  final RideDetail ride;

  const _BottomSection({required this.ride});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: AppSpacings.pL,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total price',
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colorScheme.onSurfaceVariant,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  '${ride.price} FCFA',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
              ],
            ),
            AppSpacings.gapL,
            ButtonWithLoading(
              onPressed: () {
                // TODO: Implement Booking Logic
              },
              isLoading: false, // TODO: Connect to controller state
              buttonText: 'Confirm',
            ),
          ],
        ),
      ),
    );
  }
}
