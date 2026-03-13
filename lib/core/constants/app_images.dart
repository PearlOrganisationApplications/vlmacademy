/// Centralized constants for all image asset paths.
/// Use these constants instead of hardcoding paths throughout the app.
class AppImages {
  AppImages._(); // Prevent instantiation

  // Base paths
  static const String _imagesBase = 'assets/images';
  static const String _iconsBase = 'assets/icons';
  static const String _animationsBase = 'assets/animations';

  // ─── Brand / Logo ───────────────────────────────────────────────────────────
  static const String vlmLogo = '$_imagesBase/vlm_logo.png'; // primary — PNG
  static const String bgImage = '$_imagesBase/bgimage.png'; // background — PNG
  static const String roleStudent = '$_imagesBase/role_student.png';
  static const String roleParent = '$_imagesBase/role_parent.png';
  static const String roleTeacher = '$_imagesBase/role_teacher.png';
  static const String otpVerification = '$_imagesBase/otp_verification.png';

  // ─── Onboarding ─────────────────────────────────────────────────────────────
  static const String onboarding1 = '$_imagesBase/onboarding1.png';
  static const String onboarding2 = '$_imagesBase/onboarding2.png';
  static const String onboarding3 = '$_imagesBase/onboarding3.png';
  static const String onboarding4 = '$_imagesBase/onboarding4.png';

  // ─── Icons ───────────────────────────────────────────────────────────────────
  static const String googleIcon = '$_iconsBase/googleIcon.png';

  // ─── Animations ──────────────────────────────────────────────────────────────
  // Add Lottie animation paths here as they are added to assets/animations/
}
