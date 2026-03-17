import 'package:flutter/material.dart';
import '../../ui/shared/splash_screen.dart';
import '../../ui/shared/onboarding_screen.dart';
import '../../ui/auth/login_screen.dart';
import '../../ui/auth/otp_screen.dart';
import '../../ui/auth/email_login_screen.dart';
import '../../ui/auth/signup_screen.dart';
import '../../ui/student/dashboard/student_dashboard.dart';
import '../../ui/student/courses/learning_screen.dart';
import '../../ui/student/exams/tests_screen.dart';
import '../../ui/student/wallet/wallet_screen.dart';
import '../../ui/student/profile/profile_screen.dart';
import '../../ui/teacher/teacher_dashboard.dart';
import '../../ui/auth/teacher_onboarding_screen.dart';
import '../../ui/auth/teacher_onboarding/profile_review_screen.dart';
import '../../ui/auth/role_selection_screen.dart';
import '../../ui/student/profile/student_profile_setup_screen.dart';
import '../../ui/student/plans/learning_plan_screen.dart';
import '../../ui/student/chat/ask_doubt_screen.dart';

class AppRoutes {
  // Core routes
  static const String splash = '/';
  static const String onboarding = '/onboarding'; // feature slides → login

  // Auth routes
  static const String login = '/login';
  static const String otp = '/otp';
  static const String emailLogin = '/email-login';
  static const String signup = '/signup';
  static const String roleSelection = '/role-selection';
  static const String teacherOnboarding = '/teacher/onboarding';
  static const String teacherProfileReview = '/teacher/profile-review';

  // Student routes
  static const String studentDashboard = '/student/dashboard';
  static const String studentLearning = '/student/learning';
  static const String studentTests = '/student/tests';
  static const String studentWallet = '/student/wallet';
  static const String studentProfile = '/student/profile';
  static const String studentProfileSetup = '/student/profile-setup';
  static const String learningPlan = '/student/learning-plan';
  static const String askDoubt = '/student/ask-doubt';

  // Teacher routes
  static const String teacherDashboard = '/teacher/dashboard';

  // Route generator
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case roleSelection:
        return MaterialPageRoute(builder: (_) => const RoleSelectionScreen());

      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case otp:
        final args = settings.arguments as Map<String, dynamic>?;
        return MaterialPageRoute(
          builder: (_) => OtpScreen(
            contactInfo: args?['phoneNumber'] ?? '',
          ),
        );

      case emailLogin:
        return MaterialPageRoute(builder: (_) => const EmailLoginScreen());

      case signup:
        return MaterialPageRoute(builder: (_) => const SignupScreen());

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

      case studentProfileSetup:
        return MaterialPageRoute(
            builder: (_) => const StudentProfileSetupScreen());

      case learningPlan:
        return MaterialPageRoute(builder: (_) => const LearningPlanScreen());

      case askDoubt:
        return MaterialPageRoute(builder: (_) => const AskDoubtScreen());

      case teacherDashboard:
        return MaterialPageRoute(builder: (_) => const TeacherDashboard());

      case teacherOnboarding:
        return MaterialPageRoute(
            builder: (_) => const TeacherOnboardingScreen());

      case teacherProfileReview:
        return MaterialPageRoute(builder: (_) => const ProfileReviewScreen());

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
