import 'package:allonsvite/widgets/mini_design_system.dart';
import 'package:flutter/material.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

import 'core/config/app_router.dart';
import 'core/themes/app_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'AllonsVite',
      onGenerateRoute: AppRouter.generateRoute,
      theme: AppTheme.lightTheme,
      //initialRoute: AppRouter.phoneLogin,
      home: MiniDesignSystem(),
    );
  }
}
