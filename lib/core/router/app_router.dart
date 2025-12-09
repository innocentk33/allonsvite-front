import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:allonsvite/features/auth/presentation/pages/phone_login_page.dart';
import 'package:allonsvite/features/auth/presentation/pages/otp_verification_page.dart';
import 'package:allonsvite/features/auth/presentation/pages/create_profil_page.dart';
import 'package:allonsvite/features/navigation/home_page.dart';
import 'package:allonsvite/features/trips/finding_ride.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../features/auth/presentation/providers/auth_controller.dart';
import '../../features/navigation/splash_page.dart';
part 'app_router.g.dart';
/// Routes de l'application
abstract class AppRoutes {
  static const String phoneLogin = '/phone-login';
  static const String otpVerification = '/otp-verification';
  static const String profile = '/profile';
  static const String home = '/home';
  static const String splash = '/splash';
  static const String searchTrip = '/search-trip';
  static const String findingRide = '/finding-ride';
  static const String rideDetails = '/ride-details';
  static const String payment = '/payment';
  static const String tripHistory = '/trip-history';
  static const String tripDetails = '/trip-details';
  static const String notifications = '/notifications';
  static const String settings = '/settings';
  static const String aboutUs = '/about-us';
  static const String contactUs = '/contact-us';
  static const String privacyPolicy = '/privacy-policy';
  static const String termsAndConditions = '/terms-and-conditions';
  static const String helpAndSupport = '/help-and-support';
  static const String language = '/language';
}

/// Provider pour GoRouter
/// Dépend de l'état d'authentification pour rediriger correctement
@riverpod
GoRouter appRouter(Ref ref) {
  // Watch l'état d'authentification
  final authCheck = ref.watch(authCheckProvider);

  return GoRouter(
    initialLocation: AppRoutes.splash,
    debugLogDiagnostics: true,
    redirect: (context, state) {
      // Vérifier si on est en train de charger l'authentification
      if (authCheck.isLoading) {
        return AppRoutes.splash;
      }

      final isAuthenticated = authCheck.whenData((value) => value).value ?? false;
      final isLoggingIn = state.matchedLocation == AppRoutes.phoneLogin ||
          state.matchedLocation == AppRoutes.otpVerification ||
          state.matchedLocation == AppRoutes.splash;

      // Si pas authentifié et pas en train de se connecter → login
      if (!isAuthenticated && !isLoggingIn) {
        return AppRoutes.phoneLogin;
      }

      // Si authentifié et en train de se connecter → home
      if (isAuthenticated && isLoggingIn) {
        return AppRoutes.home;
      }

      return null; // Pas de redirection
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
          final phoneNumber = state.extra as String? ?? '+225 XX XX XX XX';
          return OtpVerificationPage(phoneNumber: phoneNumber);
        },
      ),

      // Route Profil - Création/Modification du profil
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const CreateProfilPage(),
      ),

      // Route Home - Page principale avec navigation en bas
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
        routes: [
          // Routes imbriquées sous home
          GoRoute(
            path: 'search-trip',
            builder: (context, state) => const SizedBox.shrink(), // À implémenter
          ),
          GoRoute(
            path: 'notifications',
            builder: (context, state) => const SizedBox.shrink(), // À implémenter
          ),
          GoRoute(
            path: 'settings',
            builder: (context, state) => const SizedBox.shrink(), // À implémenter
          ),
        ],
      ),

      // Route Finding Ride - Recherche de trajet
      GoRoute(
        path: AppRoutes.findingRide,
        builder: (context, state) => const FindingRidePage(),
      ),

      // Route Ride Details
      GoRoute(
        path: AppRoutes.rideDetails,
        builder: (context, state) => const SizedBox.shrink(), // À implémenter
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
    errorBuilder: (context, state) => Scaffold(
      body: Center(
        child: Text('Erreur 404: ${state.error}'),
      ),
    ),
  );
}

