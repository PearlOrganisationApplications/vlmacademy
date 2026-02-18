import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_images.dart';
import '../../core/routes/app_routes.dart';

/// Entry point screen shown on app launch.
///
/// Plays a brief fade + scale animation while the app initialises,
/// then routes the user to the appropriate screen based on auth state.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  // ─── Constants ───────────────────────────────────────────────────────────────

  static const Duration _animDuration = Duration(milliseconds: 1200);
  static const Duration _splashDuration = Duration(seconds: 3);

  // ─── Animation ───────────────────────────────────────────────────────────────

  late final AnimationController _animController;
  late final Animation<double> _fadeAnim;
  late final Animation<double> _scaleAnim;

  // ─── Lifecycle ───────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _scheduleNavigation();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // ─── Private helpers ─────────────────────────────────────────────────────────

  void _initAnimations() {
    _animController = AnimationController(
      vsync: this,
      duration: _animDuration,
    );

    _fadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeIn),
    );

    _scaleAnim = Tween<double>(begin: 0.75, end: 1.0).animate(
      CurvedAnimation(parent: _animController, curve: Curves.easeOutBack),
    );

    _animController.forward();
  }

  void _scheduleNavigation() {
    Timer(_splashDuration, _navigateToNext);
  }

  void _navigateToNext() {
    if (!mounted) return;

    // TODO: Replace with real checks from SharedPreferences / auth service
    final bool isLoggedIn = _checkIsLoggedIn();
    final bool hasSeenOnboarding = _checkHasSeenOnboarding();

    final String route;
    if (isLoggedIn) {
      route = AppRoutes.studentDashboard;
    } else if (hasSeenOnboarding) {
      route = AppRoutes.login;
    } else {
      route = AppRoutes.onboarding;
    }

    Navigator.pushReplacementNamed(context, route);
  }

  // TODO: Replace stubs with SharedPreferences / auth service reads
  bool _checkIsLoggedIn() => false;
  bool _checkHasSeenOnboarding() => false;

  void _applySystemUiStyle(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
  }

  // ─── Build ───────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    _applySystemUiStyle(context);

    return Scaffold(
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnim,
          child: ScaleTransition(
            scale: _scaleAnim,
            child: Image.asset(
              AppImages.vlmLogo,
              width: 180.w,
              height: 180.w, // square — use .w for both so it stays proportional
              fit: BoxFit.contain,
            ),
          ),
        ),
      ),
    );
  }
}
