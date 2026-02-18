class AppConstants {
  // App Info
  static const String appName = 'VLM Academy';
  static const String appVersion = '1.0.0';

  // API Endpoints (Mock for now)
  static const String baseUrl = 'https://api.vlmacademy.com';
  static const String loginEndpoint = '/auth/login';
  static const String otpEndpoint = '/auth/verify-otp';
  static const String coursesEndpoint = '/courses';
  static const String testsEndpoint = '/tests';
  static const String walletEndpoint = '/wallet';

  // User Roles
  static const String roleStudent = 'student';
  static const String roleTeacher = 'teacher';
  static const String roleParent = 'parent';
  static const String roleAdmin = 'admin';

  // Feature Flags
  static const bool enableLiveClasses = true;
  static const bool enableSpinAndWin = true;
  static const bool enableReferrals = true;
  static const bool enableAIPlanner = false; // Phase 3

  // Wallet
  static const double minRechargeAmount = 100.0;
  static const double maxRechargeAmount = 10000.0;
  static const int pointsToRupeesConversion = 10; // 10 points = 1 rupee

  // Rewards
  static const int dailyLoginPoints = 10;
  static const int videoCompletionPoints = 20;
  static const int testCompletionPoints = 50;
  static const int streakBonusPoints = 100;

  // Tests
  static const int dailyTestDuration = 30; // minutes
  static const int mockTestDuration = 180; // minutes

  // Doubt Solving
  static const double emergencyDoubtCost = 50.0;
  static const double regularDoubtCost = 20.0;

  // Session
  static const String authTokenKey = 'auth_token';
  static const String userRoleKey = 'user_role';
  static const String userIdKey = 'user_id';
}
