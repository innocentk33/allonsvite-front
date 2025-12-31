import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lucide_icons/lucide_icons.dart';

import '../../../../core/extension/build_context_ext.dart';
import '../../../../core/themes/app_spacing.dart';
import '../../domain/location.dart';
import '../controllers/location_controller.dart';

class LocationSearchPage extends ConsumerStatefulWidget {
  const LocationSearchPage({super.key});

  @override
  ConsumerState<LocationSearchPage> createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends ConsumerState<LocationSearchPage> {
  late TextEditingController _searchController;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  void _selectLocation(Location location) {
    Navigator.pop(context, location);
  }

  List<Location> _filterLocations(List<Location> locations) {
    if (_searchQuery.isEmpty) {
      return locations;
    }
    return locations
        .where((location) => location.name.toLowerCase().contains(_searchQuery))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final locationsAsync = ref.watch(locationListControllerProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Sélectionner une commune',
          style: context.textTheme.titleLarge,
        ),
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Champ de recherche
            Padding(
              padding: AppSpacings.pL,
              child: TextField(
                controller: _searchController,
                decoration: InputDecoration(
                  hintText: 'Chercher une commune...',
                  hintStyle: context.textTheme.bodyLarge?.copyWith(
                    color: context.colorScheme.onSurfaceVariant.withValues(
                      alpha: 0.4,
                    ),
                  ),
                  prefixIcon: Icon(
                    LucideIcons.search,
                    color: context.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            LucideIcons.x,
                            color: context.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
                          onPressed: () {
                            _searchController.clear();
                          },
                        )
                      : null,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: context.colorScheme.outline),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: context.colorScheme.outline),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: context.colorScheme.primary,
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: AppSpacings.m,
                    vertical: AppSpacings.m,
                  ),
                ),
                style: context.textTheme.bodyLarge,
              ),
            ),
            AppSpacings.gapL,
            // Liste des communes avec gestion d'état
            Expanded(
              child: locationsAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stack) => Center(
                  child: Text(
                    'Erreur lors du chargement des lieux',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.red,
                    ),
                  ),
                ),
                data: (locations) {
                  final filteredLocations = _filterLocations(locations);

                  if (filteredLocations.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            LucideIcons.mapPin,
                            size: 48,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          AppSpacings.gapL,
                          Text(
                            _searchQuery.isEmpty
                                ? 'Aucun lieu disponible'
                                : 'Aucune commune trouvée',
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  return ListView.separated(
                    padding: AppSpacings.phM,
                    itemCount: filteredLocations.length,
                    separatorBuilder: (context, index) =>
                        const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final location = filteredLocations[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          vertical: AppSpacings.m,
                        ),
                        leading: Icon(
                          LucideIcons.mapPin,
                          color: context.colorScheme.primary,
                          size: 20,
                        ),
                        title: Text(
                          location.name,
                          style: context.textTheme.bodyLarge,
                        ),
                        onTap: () => _selectLocation(location),
                        trailing: Icon(
                          LucideIcons.chevronRight,
                          color: context.colorScheme.onSurfaceVariant,
                          size: 20,
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
