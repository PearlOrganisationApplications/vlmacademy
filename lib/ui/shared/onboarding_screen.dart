import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_images.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

// ─── Data model ──────────────────────────────────────────────────────────────

class _OnboardingData {
  const _OnboardingData({
    required this.image,
    required this.title,
    required this.subtitle,
  });

  final String image;
  final String title;
  final String subtitle;
}

// ─── Screen ──────────────────────────────────────────────────────────────────

/// Onboarding flow:
///   Page 0 — Role selection  (Student Explorer / Master Mentor)
///   Pages 1-3 — Feature slides (image + title + subtitle + dots + arrow)
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // ─── Constants ─────────────────────────────────────────────────────────────

  static const List<_OnboardingData> _slides = [
    _OnboardingData(
      image: AppImages.onboarding2,
      title: 'Online Learning',
      subtitle: 'We Provide Classes Online Classes and Pre\nRecorded Lectures.',
    ),
    _OnboardingData(
      image: AppImages.onboarding3,
      title: 'Learn from Anytime',
      subtitle: 'Booked or Save the Lectures for Future',
    ),
    _OnboardingData(
      image: AppImages.onboarding4,
      title: 'Performance visualization',
      subtitle: 'Check Your Performance and Track Your\nEducation',
    ),
  ];

  // ─── State ─────────────────────────────────────────────────────────────────

  final PageController _pageController = PageController();
  int _currentSlide = 0; // 0-based index into _slides

  // ─── Lifecycle ─────────────────────────────────────────────────────────────

  @override
  void initState() {
    super.initState();
    _setSystemUi();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // ─── System UI ─────────────────────────────────────────────────────────────

  void _setSystemUi() {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
  }

  // ─── Navigation helpers ────────────────────────────────────────────────────

  void _onNext() {
    if (_currentSlide < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeInOut,
      );
    } else {
      _finish();
    }
  }

  void _onSkip() => _finish();

  void _finish() {
    // TODO: persist onboarding-seen flag via SharedPreferences
    Navigator.pushReplacementNamed(context, AppRoutes.login);
  }

  // ─── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: PageView(
          controller: _pageController,
          physics:
              const NeverScrollableScrollPhysics(), // controlled via buttons
          onPageChanged: (i) => setState(() => _currentSlide = i),
          children: [
            // Slide 1 — Feature: Online Learning
            _SlidePage(
              data: _slides[0],
              currentIndex: 0,
              total: _slides.length,
              onNext: _onNext,
              onSkip: _onSkip,
            ),
            // Slide 2 — Feature: Learn from Anytime
            _SlidePage(
              data: _slides[1],
              currentIndex: 1,
              total: _slides.length,
              onNext: _onNext,
              onSkip: _onSkip,
            ),
            // Slide 3 — Feature: Performance visualization
            _SlidePage(
              data: _slides[2],
              currentIndex: 2,
              total: _slides.length,
              onNext: _onNext,
              onSkip: _onSkip,
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Slide Page ───────────────────────────────────────────────────────────────

class _SlidePage extends StatelessWidget {
  const _SlidePage({
    required this.data,
    required this.currentIndex,
    required this.total,
    required this.onNext,
    required this.onSkip,
  });

  final _OnboardingData data;
  final int currentIndex;
  final int total;
  final VoidCallback onNext;
  final VoidCallback onSkip;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ── Skip ───────────────────────────────────────────────────────────
          Align(
            alignment: Alignment.topRight,
            child: TextButton(
              onPressed: onSkip,
              child: Text(
                'Skip',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textSecondaryDark,
                ),
              ),
            ),
          ),

          // ── Illustration ───────────────────────────────────────────────────
          Expanded(
            child: Image.asset(
              data.image,
              fit: BoxFit.contain,
            ),
          ),

          SizedBox(height: 40.h),

          // ── Title ──────────────────────────────────────────────────────────
          Text(
            data.title,
            style: AppTextStyles.h3.copyWith(
              color: AppColors.textPrimaryDark,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 12.h),

          // ── Subtitle ───────────────────────────────────────────────────────
          Text(
            data.subtitle,
            style: AppTextStyles.bodyMedium.copyWith(
              color: AppColors.textSecondaryDark,
            ),
            textAlign: TextAlign.center,
          ),

          SizedBox(height: 40.h),

          // ── Dots + Arrow row ───────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Dot indicators
              Row(
                children: List.generate(
                    total, (i) => _Dot(active: i == currentIndex)),
              ),

              // Blue arrow FAB
              GestureDetector(
                onTap: onNext,
                child: Container(
                  width: 56.w,
                  height: 56.w,
                  decoration: const BoxDecoration(
                    gradient: AppColors.primaryGradient,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_rounded,
                    color: Colors.white,
                    size: 24.sp,
                  ),
                ),
              ),
            ],
          ),

          SizedBox(height: 32.h),

          // ── Home indicator ─────────────────────────────────────────────────
          Center(
            child: Container(
              width: 134.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: AppColors.textPrimaryDark,
                borderRadius: BorderRadius.circular(3.r),
              ),
            ),
          ),

          SizedBox(height: 8.h),
        ],
      ),
    );
  }
}

// ─── Dot Indicator ────────────────────────────────────────────────────────────

class _Dot extends StatelessWidget {
  const _Dot({required this.active});

  final bool active;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      margin: EdgeInsets.only(right: 6.w),
      width: active ? 20.w : 8.w,
      height: 8.h,
      decoration: BoxDecoration(
        color: active ? AppColors.primary : AppColors.surfaceDarkElevated,
        borderRadius: BorderRadius.circular(4.r),
      ),
    );
  }
}

// ─── Role Button ──────────────────────────────────────────────────────────────

class _RoleButton extends StatelessWidget {
  const _RoleButton({
    required this.emoji,
    required this.label,
    required this.tagline,
    required this.isHighlighted,
    required this.onTap,
  });

  final String emoji;
  final String label;
  final String tagline;
  final bool isHighlighted;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          gradient: isHighlighted ? AppColors.primaryGradient : null,
          color: isHighlighted ? null : AppColors.surfaceDark,
          borderRadius: BorderRadius.circular(16.r),
          border: isHighlighted
              ? null
              : Border.all(color: AppColors.borderDark, width: 1),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(emoji, style: TextStyle(fontSize: 20.sp)),
                SizedBox(width: 8.w),
                Text(
                  label,
                  style: AppTextStyles.h5.copyWith(
                    color: AppColors.textPrimaryDark,
                  ),
                ),
              ],
            ),
            SizedBox(height: 4.h),
            Text(
              tagline,
              style: AppTextStyles.bodySmall.copyWith(
                color: isHighlighted
                    ? Colors.white70
                    : AppColors.textSecondaryDark,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
