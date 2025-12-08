import 'package:flutter/material.dart';
import 'package:allonsvite/features/auth/presentation/pages/phone_login_page.dart';

class AppRouter {
  static const String phoneLogin = '/phone-login';
  static const String otpVerification = '/otp-verification';
  static const String profile = '/profile';
  static const String home = '/home';
  static const String searchTrip = '/search-trip';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case phoneLogin:
        return MaterialPageRoute(
          builder: (_) => const PhoneLoginPage(),
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
