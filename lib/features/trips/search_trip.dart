import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart' as lucide;
import '../../core/extension/build_context_ext.dart';
import '../../core/themes/app_spacing.dart';

class SearchTrip extends StatefulWidget {
  const SearchTrip({super.key});

  @override
  State<SearchTrip> createState() => _SearchTripState();
}

class _SearchTripState extends State<SearchTrip> {
  late TextEditingController _fromController;
  late TextEditingController _toController;
  int _numberOfPeople = 0;

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
    _fromController.text = _toController.text;
    _toController.text = temp;
  }

  void _findRide() {
    // Action pour trouver un trajet
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Recherche de trajet...')),
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
                                    child: _SearchTextField(
                                      controller: _fromController,
                                      placeholder: 'From',
                                    ),
                                  ),
                                  AppSpacings.gapS,
                                  IconButton(
                                    onPressed: _swapLocations,
                                    icon: Icon(
                                      lucide.LucideIcons.arrowUpDown,
                                      color: context.colorScheme.onSurfaceVariant,
                                      size: 20,
                                    ),
                                  ),
                                ],
                              ),
                              AppSpacings.gapM,
                              // Champ To
                              _SearchTextField(
                                controller: _toController,
                                placeholder: 'To',
                              ),
                              AppSpacings.gapM,
                              // Date
                              _InfoRow(
                                icon: lucide.LucideIcons.calendarSearch,
                                label: 'Today',
                              ),
                              AppSpacings.gapM,
                              // Heure et nombre de personnes
                              Row(
                                children: [
                                  Expanded(
                                    child: _InfoRow(
                                      icon: lucide.LucideIcons.clock,
                                      label: 'Time',
                                    ),
                                  ),
                                  AppSpacings.gapL,
                                  Row(
                                    children: [
                                      Icon(
                                        lucide.LucideIcons.userCircle,
                                        size: 18,
                                        color: context.colorScheme.onSurfaceVariant,
                                      ),
                                      AppSpacings.gapS,
                                      Text(
                                        '$_numberOfPeople',
                                        style: context.textTheme.bodyMedium,
                                      ),
                                    ],
                                  ),
                                ],
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

  const _SearchTextField({
    required this.controller,
    required this.placeholder,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
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