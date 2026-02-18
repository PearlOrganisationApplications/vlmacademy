import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'core/routes/app_routes.dart';
import 'core/theme/app_theme.dart';
import 'providers/auth_provider.dart';
import 'providers/learning_provider.dart';
import 'providers/test_provider.dart';
import 'providers/wallet_provider.dart';

void main() {
  runApp(const VlmAcademyApp());
}

class VlmAcademyApp extends StatelessWidget {
  const VlmAcademyApp({super.key});

  // Design reference frame — match your Figma canvas size.
  // All .w / .h / .sp values scale relative to this.
  static const Size _designSize = Size(390, 844); // iPhone 14 Pro

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: _designSize,
      minTextAdapt: true,       // scales text down on small screens
      splitScreenMode: true,    // handles split-screen / foldables
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => AuthProvider()),
            ChangeNotifierProvider(create: (_) => LearningProvider()),
            ChangeNotifierProvider(create: (_) => WalletProvider()),
            ChangeNotifierProvider(create: (_) => TestProvider()),
          ],
          child: MaterialApp(
            title: 'VLM Academy',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: ThemeMode.dark,
            initialRoute: AppRoutes.splash,
            onGenerateRoute: AppRoutes.generateRoute,
          ),
        );
      },
    );
  }
}
