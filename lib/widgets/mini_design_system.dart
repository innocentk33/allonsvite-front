import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MiniDesignSystem extends StatelessWidget {
  const MiniDesignSystem({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            spacing: 16,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Mon Titre Jokker",
                style: Theme.of(
                  context,
                ).textTheme.headlineMedium, // Utilisera Jokker
              ),
              Text('Mon titre Inter',style: GoogleFonts.inter(fontSize: 28,fontWeight: .w600),),
              Text(
                "Ceci est un paragraphe écrit avec la police Inter. Elle est très lisible pour les longues descriptions.",
                style: Theme.of(context).textTheme.bodyLarge, // Utilisera Inter
              ),

              ElevatedButton(
                onPressed: () {},
                child: const Text(
                  "Bouton Jokker",
                ), // Utilisera Jokker (défini dans le thème bouton)
              ),
              OutlinedButton(onPressed: (){}, child: Text('Outline boutton')),
              FilledButton(onPressed: (){}, child: Text('Filled boutton')),
            ],
          ),
        ),
      ),
    );
  }
}
