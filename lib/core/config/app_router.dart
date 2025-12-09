import 'package:allonsvite/features/auth/presentation/pages/create_profil_page.dart';
import 'package:flutter/material.dart';
import 'package:allonsvite/features/auth/presentation/pages/phone_login_page.dart';

import '../../features/auth/presentation/pages/otp_verification_page.dart';
import '../../features/navigation/home_page.dart';
import '../../features/trips/finding_ride.dart';

class AppRouter {
  static const String phoneLogin = '/phone-login';
  static const String otpVerification = '/otp-verification';
  static const String profile = '/profile';
  static const String home = '/home';
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
  static const String logout = '/logout';



  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case phoneLogin:
        return MaterialPageRoute(
          builder: (_) => const PhoneLoginPage(),
          settings: settings,
        );
      case otpVerification:
        final phoneNumber = settings.arguments as String? ?? '+225 XX XX XX XX';
        return MaterialPageRoute(
          builder: (_) => OtpVerificationPage(phoneNumber: phoneNumber),
          settings: settings,
        );
        case profile:
        return MaterialPageRoute(
          builder: (_) => const CreateProfilPage(),
          settings: settings,
        );
        case home:
        return MaterialPageRoute(
          builder: (_) => const HomePage(),
          settings: settings,
        );
        case findingRide:
        return MaterialPageRoute(
          builder: (_) => const FindingRidePage(),
          settings: settings,
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const PhoneLoginPage(),
          settings: settings,
        );
    }
  }
}
