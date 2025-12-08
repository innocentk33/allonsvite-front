import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart' as lucide;
import '../../core/extension/build_context_ext.dart';
import '../../core/themes/app_spacing.dart';

class LocationSearchPage extends StatefulWidget {
  const LocationSearchPage({super.key});

  @override
  State<LocationSearchPage> createState() => _LocationSearchPageState();
}

class _LocationSearchPageState extends State<LocationSearchPage> {
  late TextEditingController _searchController;
  late List<String> _communes;
  late List<String> _filteredCommunes;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();

    // Liste des communes d'Abidjan
    _communes = [
      'Abobo',
      'Abidjan',
      'Adjamé',
      'Attécoubé',
      'Cocody',
      'Koumassi',
      'Marcory',
      'Plateau',
      'Port-Bouët',
      'Treichville',
      'Yopougon',
      'Bingerville',
      'Songon',
      'Anyama',
    ];

    _filteredCommunes = List.from(_communes);

    _searchController.addListener(_filterCommunes);
  }

  @override
  void dispose() {
    _searchController.removeListener(_filterCommunes);
    _searchController.dispose();
    super.dispose();
  }

  void _filterCommunes() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      if (query.isEmpty) {
        _filteredCommunes = List.from(_communes);
      } else {
        _filteredCommunes = _communes
            .where((commune) => commune.toLowerCase().contains(query))
            .toList();
      }
    });
  }

  void _selectCommune(String commune) {
    Navigator.pop(context, commune);
  }

  @override
  Widget build(BuildContext context) {
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
                    color: context.colorScheme.onSurfaceVariant.withValues(alpha: 0.4),
                  ),
                  prefixIcon: Icon(
                    lucide.LucideIcons.search,
                    color: context.colorScheme.onSurfaceVariant,
                    size: 20,
                  ),
                  suffixIcon: _searchController.text.isNotEmpty
                      ? IconButton(
                          icon: Icon(
                            lucide.LucideIcons.x,
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
                    borderSide: BorderSide(
                      color: context.colorScheme.outline,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(
                      color: context.colorScheme.outline,
                    ),
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
            // Liste des communes
            Expanded(
              child: _filteredCommunes.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            lucide.LucideIcons.mapPin,
                            size: 48,
                            color: context.colorScheme.onSurfaceVariant,
                          ),
                          AppSpacings.gapL,
                          Text(
                            'Aucune commune trouvée',
                            style: context.textTheme.bodyLarge?.copyWith(
                              color: context.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.separated(
                      padding: AppSpacings.pL,
                      itemCount: _filteredCommunes.length,
                      separatorBuilder: (context, index) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final commune = _filteredCommunes[index];
                        return ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            vertical: AppSpacings.m,
                          ),
                          leading: Icon(
                            lucide.LucideIcons.mapPin,
                            color: context.colorScheme.primary,
                            size: 20,
                          ),
                          title: Text(
                            commune,
                            style: context.textTheme.bodyLarge,
                          ),
                          onTap: () => _selectCommune(commune),
                          trailing: Icon(
                            lucide.LucideIcons.chevronRight,
                            color: context.colorScheme.onSurfaceVariant,
                            size: 20,
                          ),
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

