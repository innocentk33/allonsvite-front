import 'package:flutter/material.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo ou icône de l'app
            const Icon(
              Icons.directions_car,
              size: 64,
            ),
            const SizedBox(height: 24),
            // Texte
            Text(
              'AllonsVite',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: 48),
            // Loader
            const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}