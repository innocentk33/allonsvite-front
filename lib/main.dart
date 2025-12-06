import 'package:allonsvite/features/auth/presentation/pages/phone_login_page.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ShadApp(
      debugShowCheckedModeBanner: false,
      title: 'AllonsVite',
      theme: ShadThemeData(colorScheme: ShadColorScheme.fromName('orange')),
      home: const PhoneLoginPage(),
    );
  }
}
