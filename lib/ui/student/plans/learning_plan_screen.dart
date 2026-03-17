import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:vlm_academy/ui/shared/background_screen.dart';

import '../../../../core/constants/app_images.dart';
import '../../../../core/routes/app_routes.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class LearningPlanScreen extends StatefulWidget {
  const LearningPlanScreen({super.key});

  @override
  State<LearningPlanScreen> createState() => _LearningPlanScreenState();
}

class _LearningPlanScreenState extends State<LearningPlanScreen> {
  int _selectedPlanIndex = 2; // Default to Premium/Most Popular

  final List<Map<String, dynamic>> _plans = [
    {
      'name': 'Basic Plan',
      'oldPrice': '499',
      'price': '199',
      'color': const Color(0xFF42A5F5),
      'icon': Icons.menu_book,
      'features': [
        '100 AI Credits',
        '50 Human Chat',
        '300 Audio Mins',
        'Live Classes',
      ],
    },
    {
      'name': 'Pro Plan',
      'oldPrice': '999',
      'price': '499',
      'color': const Color(0xFFAB47BC),
      'icon': Icons.rocket_launch,
      'features': [
        '300 AI Credits',
        '150 Human Chat',
        '600 Audio Mins',
        'Live Classes',
      ],
    },
    {
      'name': 'Premium Plan',
      'oldPrice': '1499',
      'price': '799',
      'color': const Color(0xFFFFA726),
      'icon': Icons.workspace_premium,
      'isPopular': true,
      'features': [
        '1000 AI Credits',
        'Unlimited Human Chat',
        '1200 Audio Mins',
        'Live Classes + Recordings',
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      useSafeArea: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: Column(
            children: [
              // Header Logo
              Center(
                child: Image.asset(
                  AppImages.vlmLogo,
                  width: 120.w,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 32.h),
              // Title and Subtitle
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  children: [
                    Text(
                      'Choose Your Learning Plan',
                      style: AppTextStyles.h4.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      'Unlock your full potential with our premium features',
                      style: AppTextStyles.bodySmall
                          .copyWith(color: Colors.white70),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 32.h),
              // Horizontal Plans List
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List.generate(_plans.length, (index) {
                    return _PlanCard(
                      plan: _plans[index],
                      isSelected: _selectedPlanIndex == index,
                      onSelect: () =>
                          setState(() => _selectedPlanIndex = index),
                    );
                  }),
                ),
              ),
              SizedBox(height: 32.h),
              // Action Button
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: _buildActivateButton(),
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActivateButton() {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          )
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          // Logic to activate trial
          Navigator.pushReplacementNamed(context, AppRoutes.studentDashboard);
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
        ),
        child: Text(
          'Activate Plan for Trial ₹1',
          style: AppTextStyles.buttonLarge
              .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({
    required this.plan,
    required this.isSelected,
    required this.onSelect,
  });

  final Map<String, dynamic> plan;
  final bool isSelected;
  final VoidCallback onSelect;

  @override
  Widget build(BuildContext context) {
    final bool isPopular = plan['isPopular'] ?? false;

    return GestureDetector(
      onTap: onSelect,
      child: Container(
        width: 260.w,
        margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(32.r),
          border: Border.all(
            color: isSelected ? plan['color'] : Colors.white10,
            width: isSelected ? 2.w : 1.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: plan['color'].withOpacity(0.2),
                    blurRadius: 20,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            if (isPopular)
              Positioned(
                top: -12.h,
                right: 20.w,
                child: Container(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  decoration: BoxDecoration(
                    color: plan['color'],
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    'Most Popular',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            Padding(
              padding: EdgeInsets.all(24.w),
              child: Column(
                children: [
                  // Plan Icon and Name
                  Container(
                    width: 50.w,
                    height: 50.w,
                    decoration: BoxDecoration(
                      color: plan['color'].withOpacity(0.2),
                      shape: BoxShape.circle,
                    ),
                    child:
                        Icon(plan['icon'], color: plan['color'], size: 28.sp),
                  ),
                  SizedBox(height: 16.h),
                  Text(
                    plan['name'],
                    style: AppTextStyles.h5.copyWith(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8.h),
                  // Trial Badge
                  Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                    decoration: BoxDecoration(
                      color: plan['color'].withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(color: plan['color'].withOpacity(0.3)),
                    ),
                    child: Text(
                      '3 Days Free Trial',
                      style: TextStyle(
                          color: plan['color'],
                          fontSize: 10.sp,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(height: 20.h),
                  // Pricing
                  Text(
                    '₹${plan['oldPrice']}/mo',
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14.sp,
                      decoration: TextDecoration.lineThrough,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        '₹${plan['price']}',
                        style: AppTextStyles.h3.copyWith(
                            color: plan['color'], fontWeight: FontWeight.bold),
                      ),
                      Text(
                        '/mo',
                        style:
                            TextStyle(color: Colors.white70, fontSize: 14.sp),
                      ),
                    ],
                  ),
                  SizedBox(height: 24.h),
                  // Features List
                  ...List.generate(plan['features'].length, (i) {
                    return Padding(
                      padding: EdgeInsets.only(bottom: 12.h),
                      child: Row(
                        children: [
                          Icon(Icons.check_circle,
                              color: plan['color'], size: 16.sp),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Text(
                              plan['features'][i],
                              style: AppTextStyles.bodySmall
                                  .copyWith(color: Colors.white70),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),
                  SizedBox(height: 24.h),
                  // Select Button in Card
                  Container(
                    width: double.infinity,
                    height: 40.h,
                    decoration: BoxDecoration(
                      color: isSelected
                          ? plan['color']
                          : Colors.white.withOpacity(0.05),
                      borderRadius: BorderRadius.circular(20.r),
                      border:
                          isSelected ? null : Border.all(color: Colors.white12),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      isSelected ? 'Selected' : 'Select Plan',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
