import 'package:flutter/material.dart';
import 'package:allonsvite/features/auth/presentation/pages/phone_login_page.dart';
import 'package:allonsvite/features/auth/presentation/pages/otp_page.dart';
import 'package:allonsvite/features/auth/presentation/pages/profile_page.dart';

class AppRouter {
  static const String phoneLogin = '/phone-login';
  static const String otpVerification = '/otp-verification';
  static const String profile = '/profile';
  static const String home = '/home';

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
          builder: (_) => const ProfilePage(),
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

