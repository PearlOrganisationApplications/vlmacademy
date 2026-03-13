import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_images.dart';
import '../../core/routes/app_routes.dart';
import '../../core/services/onboarding_service.dart';
import 'background_screen.dart';

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

  static const Duration _splashDuration = Duration(seconds: 4);

  // ─── Animation ───────────────────────────────────────────────────────────────

  late final AnimationController _animController;
  late final Animation<double> _logoFadeAnim;
  late final Animation<double> _logoScaleAnim;
  late final Animation<double> _taglineFadeAnim;
  late final Animation<double> _taglineSlideAnim;
  late final Animation<double> _pulseAnim;

  // ─── Lifecycle ───────────────────────────────────────────────────────────────

  @override
  void initState() {
    debugPrint('SplashScreen: initState');
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
    debugPrint('SplashScreen: _initAnimations');
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );

    // 1. Logo Entry (0.0 - 0.5)
    _logoFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
      ),
    );

    _logoScaleAnim = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.0, 0.5, curve: Curves.easeOutBack),
      ),
    );

    // 2. Tagline Entry (0.4 - 0.8)
    _taglineFadeAnim = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeIn),
      ),
    );

    _taglineSlideAnim = Tween<double>(begin: 20.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.4, 0.8, curve: Curves.easeOutQuart),
      ),
    );

    // 3. Subtle Pulse (0.6 - 1.0)
    _pulseAnim = Tween<double>(begin: 1.0, end: 1.05).animate(
      CurvedAnimation(
        parent: _animController,
        curve: const Interval(0.6, 1.0, curve: Curves.easeInOutSine),
      ),
    );

    _animController.forward();
  }

  void _scheduleNavigation() {
    debugPrint('SplashScreen: _scheduleNavigation ($_splashDuration)');
    Timer(_splashDuration, _navigateToNext);
  }

  void _navigateToNext() {
    debugPrint('SplashScreen: _navigateToNext');
    if (!mounted) return;

    final bool isLoggedIn = _checkIsLoggedIn();

    if (isLoggedIn) {
      Navigator.pushReplacementNamed(context, AppRoutes.studentDashboard);
      return;
    }

    // Check Teacher Onboarding Status
    OnboardingService.init().then((onboardingService) {
      if (!mounted) return;

      if (onboardingService.currentStep != TeacherOnboardingStep.signup &&
          onboardingService.currentStep != TeacherOnboardingStep.completed) {
        Navigator.pushReplacementNamed(context, AppRoutes.teacherOnboarding);
      } else {
        Navigator.pushReplacementNamed(context, AppRoutes.roleSelection);
      }
    });
  }

  // TODO: Replace stubs with SharedPreferences / auth service reads
  bool _checkIsLoggedIn() => false;

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

    return BackgroundScreen(
      useSafeArea: false,
      backgroundGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withOpacity(0.3),
          Colors.black.withOpacity(0.5),
        ],
      ),
      body: Stack(
        children: [
          // Center Content (Logo + Tagline)
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Animated Logo
                AnimatedBuilder(
                  animation: _animController,
                  builder: (context, child) {
                    return FadeTransition(
                      opacity: _logoFadeAnim,
                      child: Transform.scale(
                        scale: _logoScaleAnim.value * _pulseAnim.value,
                        child: child,
                      ),
                    );
                  },
                  child: Image.asset(
                    AppImages.vlmLogo,
                    width: 180.w,
                    height: 180.w,
                    fit: BoxFit.contain,
                  ),
                ),
                SizedBox(height: 24.h),
                FadeTransition(
                  opacity: _taglineFadeAnim,
                  child: AnimatedBuilder(
                    animation: _taglineSlideAnim,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(0, _taglineSlideAnim.value),
                        child: child,
                      );
                    },
                    child: Text(
                      'Your Gateway to Learning',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 2.0,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Version Info
          Positioned(
            bottom: 30.h,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _taglineFadeAnim,
              child: Center(
                child: Text(
                  'Version 1.0.0',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.6),
                    fontSize: 12.sp,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
