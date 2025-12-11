import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../../../../core/extension/build_context_ext.dart';
import '../../../../core/themes/app_spacing.dart';
import 'location_search_page.dart';

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
    final location = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LocationSearchPage()),
    );
    if (location != null) {
      setState(() {
        _fromController.text = location;
      });
    }
  }

  Future<void> _selectToLocation() async {
    final location = await Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => const LocationSearchPage()),
    );
    if (location != null) {
      setState(() {
        _toController.text = location;
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
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
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
                        child: const Text(
                          '−',
                          style: TextStyle(fontSize: 24),
                        ),
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
                        child: const Text(
                          '+',
                          style: TextStyle(fontSize: 24),
                        ),
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
                      'Hi, Naomi',
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
                    // Carte de recherche avec illustration en arrière-plan
                    Stack(
                      children: [
                        // Illustration de route décorative
                        Positioned(
                          bottom: 0,
                          left: 0,
                          right: 0,
                          child: CustomPaint(
                            size: const Size(double.infinity, 150),
                            painter: _RoadPainter(),
                          ),
                        ),
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
                                    child: GestureDetector(
                                      onTap: _selectFromLocation,
                                      child: _SearchTextField(
                                        controller: _fromController,
                                        placeholder: 'From',
                                        readOnly: true,
                                      ),
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
                              GestureDetector(
                                onTap: _selectToLocation,
                                child: _SearchTextField(
                                  controller: _toController,
                                  placeholder: 'To',
                                  readOnly: true,
                                ),
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
                    style: context.textTheme.labelLarge?.copyWith(
                      fontSize: 16,
                    ),
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

  const _SearchTextField({
    required this.controller,
    required this.placeholder,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
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

  const _InfoRow({
    required this.icon,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: context.colorScheme.onSurfaceVariant,
        ),
        AppSpacings.gapS,
        Text(
          label,
          style: context.textTheme.bodyMedium,
        ),
      ],
    );
  }
}

/// Painter pour dessiner l'illustration de route décorative
class _RoadPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = const Color(0xFFA6EB2E) // Vert lime
      ..strokeWidth = 8
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final borderPaint = Paint()
      ..color = const Color(0xFF031B1C) // Bordure foncée
      ..strokeWidth = 12
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final path = Path();

    // Créer une route ondulée
    path.moveTo(0, size.height * 0.3);

    // Première courbe
    path.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.1,
      size.width * 0.5,
      size.height * 0.3,
    );

    // Deuxième courbe
    path.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.5,
      size.width,
      size.height * 0.3,
    );

    // Dessiner la bordure foncée d'abord
    canvas.drawPath(path, borderPaint);

    // Puis la ligne verte par-dessus
    canvas.drawPath(path, paint);

    // Ajouter les pointillés de la route
    final dashedPaint = Paint()
      ..color = Colors.white
      ..strokeWidth = 2
      ..style = PaintingStyle.stroke;

    final dashPath = Path();
    dashPath.moveTo(0, size.height * 0.3);
    dashPath.quadraticBezierTo(
      size.width * 0.25,
      size.height * 0.1,
      size.width * 0.5,
      size.height * 0.3,
    );
    dashPath.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.5,
      size.width,
      size.height * 0.3,
    );

    _drawDashedPath(canvas, dashPath, dashedPaint);
  }

  void _drawDashedPath(Canvas canvas, Path path, Paint paint) {
    final pathMetrics = path.computeMetrics();
    for (final metric in pathMetrics) {
      double distance = 0;
      while (distance < metric.length) {
        final segment = metric.extractPath(distance, distance + 10);
        canvas.drawPath(segment, paint);
        distance += 20;
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}