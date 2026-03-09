import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class CustomStepper extends StatelessWidget {
  final int currentStep; // 0, 1, 2
  final List<String> steps;

  const CustomStepper({
    super.key,
    required this.currentStep,
    this.steps = const ['SIGNUP', 'DOCUMENTS', 'INTERVIEW'],
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 20.h),
      child: Row(
        children: List.generate(steps.length * 2 - 1, (index) {
          if (index.isEven) {
            final stepIndex = index ~/ 2;
            return _buildStepCircle(stepIndex);
          } else {
            final stepIndex = index ~/ 2;
            return _buildStepLine(stepIndex);
          }
        }),
      ),
    );
  }

  Widget _buildStepCircle(int index) {
    final isActive = index <= currentStep;
    final isCompleted = index < currentStep;

    return Column(
      children: [
        Container(
          width: 32.w,
          height: 32.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? Colors.transparent : AppColors.surfaceDark,
            border: Border.all(
              color: isActive ? AppColors.accent : AppColors.borderDark,
              width: 2,
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: AppColors.accent.withOpacity(0.5),
                      blurRadius: 10,
                      spreadRadius: 2,
                    )
                  ]
                : null,
          ),
          child: Center(
            child: isCompleted
                ? Icon(Icons.check, color: AppColors.accent, size: 18.sp)
                : Text(
                    '${index + 1}',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: isActive
                          ? AppColors.accent
                          : AppColors.textSecondaryDark,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          steps[index],
          style: AppTextStyles.bodySmall.copyWith(
            fontSize: 10.sp,
            color: isActive ? AppColors.accent : AppColors.textSecondaryDark,
            fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            letterSpacing: 0.5,
          ),
        ),
      ],
    );
  }

  Widget _buildStepLine(int index) {
    final isPassed = index < currentStep;
    return Expanded(
      child: Container(
        height: 2,
        margin: EdgeInsets.only(bottom: 24.h), // align with circles
        color: isPassed ? AppColors.accent : AppColors.borderDark,
      ),
    );
  }
}
