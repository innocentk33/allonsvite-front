import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'core/config/app_router.dart';

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
      onGenerateRoute: AppRouter.generateRoute,
      initialRoute: AppRouter.phoneLogin,
    );
  }
}
