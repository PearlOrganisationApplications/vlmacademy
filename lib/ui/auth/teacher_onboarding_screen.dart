import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/services/onboarding_service.dart';
import '../../core/theme/app_colors.dart';
import '../widgets/custom_stepper.dart';
import 'teacher_onboarding/document_verification_step.dart';
import 'teacher_onboarding/interview_scheduling_step.dart';
import 'teacher_onboarding/profile_review_screen.dart';

class TeacherOnboardingScreen extends StatefulWidget {
  const TeacherOnboardingScreen({super.key});

  @override
  State<TeacherOnboardingScreen> createState() =>
      _TeacherOnboardingScreenState();
}

class _TeacherOnboardingScreenState extends State<TeacherOnboardingScreen> {
  late OnboardingService _onboardingService;
  bool _isInitialized = false;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _initService();
  }

  Future<void> _initService() async {
    _onboardingService = await OnboardingService.init();

    // Determine initial page based on saved step
    int initialPage = 0;
    switch (_onboardingService.currentStep) {
      case TeacherOnboardingStep.signup:
      case TeacherOnboardingStep.documents:
        initialPage = 0;
        break;
      case TeacherOnboardingStep.interview:
        initialPage = 1;
        break;
      case TeacherOnboardingStep.review:
      case TeacherOnboardingStep.completed:
        // These are handled by redirecting to ProfileReviewScreen directly or dashboard
        break;
    }

    _pageController = PageController(initialPage: initialPage);
    setState(() => _isInitialized = true);
  }

  void _nextStep(TeacherOnboardingStep nextStep) async {
    await _onboardingService.setCurrentStep(nextStep);
    if (nextStep == TeacherOnboardingStep.review) {
      if (!mounted) return;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const ProfileReviewScreen()),
      );
    } else {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!_isInitialized) {
      return const Scaffold(
        backgroundColor: AppColors.backgroundDark,
        body: Center(child: CircularProgressIndicator()),
      );
    }

    // If already at review stage, show it directly
    if (_onboardingService.currentStep == TeacherOnboardingStep.review) {
      return const ProfileReviewScreen();
    }

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Column(
          children: [
            SizedBox(height: 16.h),
            // Logo or Header
            Center(
              child: Image.asset(
                'assets/icons/logo.png', // Fallback to a logo if defined
                height: 40.h,
                errorBuilder: (_, __, ___) => SizedBox(height: 40.h),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: CustomStepper(
                currentStep: _onboardingService.currentStep ==
                        TeacherOnboardingStep.interview
                    ? 2
                    : 1,
              ),
            ),

            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    DocumentVerificationStep(
                      onNext: () => _nextStep(TeacherOnboardingStep.interview),
                    ),
                    InterviewSchedulingStep(
                      onNext: () => _nextStep(TeacherOnboardingStep.review),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
