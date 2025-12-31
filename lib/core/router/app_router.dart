import 'package:allonsvite/features/auth/data/auth_providers.dart';
import 'package:allonsvite/features/rides/domain/model/ride.dart';
import 'package:allonsvite/features/rides/presentation/pages/location_search_page.dart';
import 'package:allonsvite/features/rides/presentation/pages/ride_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:allonsvite/features/auth/presentation/pages/phone_login_page.dart';
import 'package:allonsvite/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:allonsvite/features/auth/presentation/pages/create_profil_page.dart';
import 'package:allonsvite/features/navigation/home_page.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/navigation/splash_page.dart';
import '../../features/rides/presentation/pages/finding_ride_page.dart';
import 'app_routes.dart';
part 'app_router.g.dart';

// Provider pour GoRouter
// Dépend de l'état d'authentification pour rediriger correctement
@riverpod
GoRouter appRouter(Ref ref) {
  // Watch l'état d'authentification
  final authRepo = ref.watch(authRepositoryProvider);

  return GoRouter(
    initialLocation: AppRoutes.home,
    debugLogDiagnostics: true,
    redirect: (context, state) async {
      // 1. Récupération des données asynchrones
      // Est-ce que j'ai un token ?
      final tokenOption = await authRepo.checkAuthStatus();
      final isLoggedIn = tokenOption.isSome();

      // Est-ce que mon profil est complété ? (Tu dois implémenter cette méthode dans ton repo)
      // Par défaut false si pas connecté
      final bool isProfileComplete = isLoggedIn
          ? await authRepo.checkProfileCompletion()
          : false;

      // 2. Analyse de la route actuelle
      final String location = state.uri.toString();

      final bool isLoggingIn = location == AppRoutes.phoneLogin;
      final bool isVerifyingOtp = location == AppRoutes.otpVerification;
      final bool isCreatingProfile = location == AppRoutes.createProfile;
      final bool isSplash = location == AppRoutes.splash;

      // --- LOGIQUE DE REDIRECTION ---

      // CAS A : PAS CONNECTÉ (Pas de token)
      if (!isLoggedIn) {
        // On autorise l'accès au Login, OTP et Splash sans redirection
        if (isLoggingIn || isVerifyingOtp || isSplash) {
          return null;
        }
        // Sinon, on renvoie au Login
        return AppRoutes.phoneLogin;
      }

      // CAS B : CONNECTÉ MAIS PROFIL INCOMPLET (Token OK, mais pas de Nom/Prénom)
      if (isLoggedIn && !isProfileComplete) {
        // Si l'utilisateur est déjà sur la page de création, on le laisse tranquille
        if (isCreatingProfile) {
          return null;
        }
        // Sinon, on le force à aller sur la création de profil
        return AppRoutes.createProfile;
      }

      // CAS C : CONNECTÉ ET PROFIL COMPLET (Utilisateur normal)
      // S'il essaie de retourner sur Login, OTP ou Création de profil -> On le renvoie à Home
      if (isLoggingIn || isVerifyingOtp || isCreatingProfile || isSplash) {
        return AppRoutes.home;
      }

      // CAS D : Tout est OK, pas de redirection nécessaire
      return null;
    },
    routes: [
      // Route Splash
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashPage(),
      ),

      // Route Login - Saisie du numéro
      GoRoute(
        path: AppRoutes.phoneLogin,
        builder: (context, state) => const PhoneLoginPage(),
      ),

      // Route OTP - Vérification du code
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (context, state) {
          final phoneNumber = state.extra as String? ?? '07 XX XX XX XX';
          return OtpVerificationPage(phoneNumber: phoneNumber);
        },
      ),

      // Route Profil - Création
      GoRoute(
        path: AppRoutes.createProfile,
        builder: (context, state) => const CreateProfilPage(),
      ),

      // Route Home - Page principale avec navigation en bas
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
        routes: [
          // Routes imbriquées sous home
          GoRoute(
            path: AppRoutes.notifications,
            builder: (context, state) =>
                const SizedBox.shrink(), // À implémenter
          ),
          GoRoute(
            path: AppRoutes.settings,
            builder: (context, state) =>
                const SizedBox.shrink(), // À implémenter
          ),
        ],
      ),

      // Route Finding Ride - Recherche de trajet
      GoRoute(
        path: AppRoutes.findingRide,
        builder: (context, state) {
          final query = state.uri.queryParameters;

          RideSearchParams? params;
          if (query.isNotEmpty) {
            params = RideSearchParams(
              fromLocation: query['fromLocation'],
              toLocation: query['toLocation'],
              date: query['date'] != null
                  ? DateTime.tryParse(query['date']!)
                  : null,
              seats: query['seats'] != null
                  ? int.tryParse(query['seats']!)
                  : 1, // Default to 1
            );
          } else {
            // Fallback to extra if still used somewhere (optional, but good for backward compat during dev)
            params = state.extra as RideSearchParams?;
          }

          return FindingRidePage(params: params ?? const RideSearchParams());
        },
      ),
      GoRoute(
        path: AppRoutes.findLocation,
        builder: (context, state) => const LocationSearchPage(),
      ),

      // Route Ride Details
      GoRoute(
        path: '${AppRoutes.rideDetails}/:id',
        builder: (context, state) {
          final id = int.parse(state.pathParameters['id']!);
          return RideDetailPage(rideId: id);
        },
      ),

      // Route Payment
      GoRoute(
        path: AppRoutes.payment,
        builder: (context, state) => const SizedBox.shrink(), // À implémenter
      ),

      // Route Trip History
      GoRoute(
        path: AppRoutes.tripHistory,
        builder: (context, state) => const SizedBox.shrink(), // À implémenter
      ),

      // Route Trip Details
      GoRoute(
        path: AppRoutes.tripDetails,
        builder: (context, state) => const SizedBox.shrink(), // À implémenter
      ),

      // Route About Us
      GoRoute(
        path: AppRoutes.aboutUs,
        builder: (context, state) => const SizedBox.shrink(), // À implémenter
      ),

      // Route Contact Us
      GoRoute(
        path: AppRoutes.contactUs,
        builder: (context, state) => const SizedBox.shrink(), // À implémenter
      ),

      // Route Privacy Policy
      GoRoute(
        path: AppRoutes.privacyPolicy,
        builder: (context, state) => const SizedBox.shrink(), // À implémenter
      ),

      // Route Terms and Conditions
      GoRoute(
        path: AppRoutes.termsAndConditions,
        builder: (context, state) => const SizedBox.shrink(), // À implémenter
      ),

      // Route Help and Support
      GoRoute(
        path: AppRoutes.helpAndSupport,
        builder: (context, state) => const SizedBox.shrink(), // À implémenter
      ),

      // Route Language
      GoRoute(
        path: AppRoutes.language,
        builder: (context, state) => const SizedBox.shrink(), // À implémenter
      ),
    ],
    errorBuilder: (context, state) =>
        Scaffold(body: Center(child: Text('Erreur 404: ${state.error}'))),
  );
}
