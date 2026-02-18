import 'package:flutter/material.dart';
import '../../ui/shared/splash_screen.dart';
import '../../ui/shared/onboarding_screen.dart';
import '../../ui/auth/login_screen.dart';
import '../../ui/auth/otp_screen.dart';
import '../../ui/student/student_dashboard.dart';
import '../../ui/student/learning_screen.dart';
import '../../ui/student/tests_screen.dart';
import '../../ui/student/wallet_screen.dart';
import '../../ui/student/profile_screen.dart';
import '../../ui/teacher/teacher_dashboard.dart';

class AppRoutes {
  // Core routes
  static const String splash = '/';
  static const String onboarding = '/onboarding'; // feature slides → login

  // Auth routes
  static const String login = '/login';
  static const String otp = '/otp';
  static const String roleSelection = '/role-selection';

  // Student routes
  static const String studentDashboard = '/student/dashboard';
  static const String studentLearning = '/student/learning';
  static const String studentTests = '/student/tests';
  static const String studentWallet = '/student/wallet';
  static const String studentProfile = '/student/profile';

  // Teacher routes
  static const String teacherDashboard = '/teacher/dashboard';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case otp:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => OtpScreen(
            contactInfo: args?['phoneNumber'] ?? '',
          ),
        );

      case studentDashboard:
        return MaterialPageRoute(builder: (_) => const StudentDashboard());

      case studentLearning:
        return MaterialPageRoute(builder: (_) => const LearningScreen());

      case studentTests:
        return MaterialPageRoute(builder: (_) => const TestsScreen());

      case studentWallet:
        return MaterialPageRoute(builder: (_) => const WalletScreen());

      case studentProfile:
        return MaterialPageRoute(builder: (_) => const ProfileScreen());

      case teacherDashboard:
        return MaterialPageRoute(builder: (_) => const TeacherDashboard());

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }
}
