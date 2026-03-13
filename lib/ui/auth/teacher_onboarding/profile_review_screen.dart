import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../teacher/teacher_dashboard.dart';

class ProfileReviewScreen extends StatelessWidget {
  final String teacherName;
  final String teacherId;

  const ProfileReviewScreen({
    super.key,
    this.teacherName = 'Priya',
    this.teacherId = 'AVER-99201',
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 16.h),
                _buildTopBar(),
                SizedBox(height: 48.h),

                // Review Icon
                _buildReviewIcon(),
                SizedBox(height: 32.h),

                // Title
                Text(
                  'Profile Under Review',
                  style: AppTextStyles.h4.copyWith(
                    color: AppColors.textPrimaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Our admin team is currently verifying your\ncredentials. This usually takes 24-48 hours.',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryDark,
                    height: 1.5,
                  ),
                ),

                SizedBox(height: 48.h),

                // Status Steps
                _buildStatusItem(
                  icon: Icons.check_circle,
                  title: 'Registration Completed',
                  isCompleted: true,
                ),
                SizedBox(height: 16.h),
                _buildStatusItem(
                  icon: Icons.access_time_filled,
                  title: 'Admin Verification',
                  isCompleted: false,
                  isActive: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TeacherDashboard(),
                      ),
                    );
                  },
                ),
                SizedBox(height: 16.h),
                _buildStatusItem(
                  icon: Icons.privacy_tip_outlined,
                  title: 'Access to Dashboard',
                  isCompleted: false,
                  isLocked: true,
                ),

                SizedBox(height: 32.h),

                // Action Buttons
                _buildActionButton(
                  icon: Icons.edit_outlined,
                  text: 'Edit Profile Information',
                  onPressed: () {},
                  isOutline: true,
                ),
                SizedBox(height: 16.h),
                _buildActionButton(
                  icon: Icons.chat_bubble_outline,
                  text: 'Contact Support',
                  onPressed: () {},
                  isGradient: true,
                ),

                SizedBox(height: 24.h),
                Text(
                  'TEACHER ID: $teacherId',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.textSecondaryDark,
                    letterSpacing: 1,
                    fontSize: 10.sp,
                  ),
                ),
                SizedBox(height: 16.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            Container(
              width: 44.w,
              height: 44.w,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: const Color(0xFF1E293B),
                border: Border.all(color: Colors.white.withOpacity(0.05)),
              ),
              child: Center(
                child: Text(
                  teacherName[0],
                  style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16.sp),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'WELCOME BACK,',
                  style: AppTextStyles.bodySmall.copyWith(
                    color: AppColors.textSecondaryDark,
                    fontSize: 8.sp,
                    letterSpacing: 0.5,
                  ),
                ),
                Text(
                  teacherName,
                  style: AppTextStyles.labelMedium.copyWith(
                    color: AppColors.textPrimaryDark,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: const Color(0xFF064E3B).withOpacity(0.3),
            borderRadius: BorderRadius.circular(10.r),
            border: Border.all(color: const Color(0xFF059669).withOpacity(0.2)),
          ),
          child: Text(
            '₹0.00',
            style: AppTextStyles.labelSmall.copyWith(
              color: const Color(0xFF10B981),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildReviewIcon() {
    return Container(
      width: 100.w,
      height: 100.w,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: AppColors.primary,
            blurRadius: 30,
            spreadRadius: 1,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: const Color(0xFF1E293B),
          border: Border.all(
            color: AppColors.primary.withOpacity(0.8),
            width: 2,
          ),
        ),
        child: Center(
          child: Icon(
            Icons.access_time_rounded,
            color: AppColors.primary,
            size: 38.sp,
          ),
        ),
      ),
    );
  }

  Widget _buildStatusItem({
    required IconData icon,
    required String title,
    bool isCompleted = false,
    bool isActive = false,
    bool isLocked = false,
    VoidCallback? onTap,
  }) {
    final color = isCompleted
        ? AppColors.accent
        : isActive
            ? AppColors.primary
            : AppColors.textSecondaryDark.withOpacity(0.3);

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        decoration: BoxDecoration(
          color: const Color(0xFF1E293B),
          borderRadius: BorderRadius.circular(14.r),
          border: Border.all(color: Colors.white.withOpacity(0.08)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              blurRadius: 10,
              offset: const Offset(0, 4),
            )
          ],
        ),
        child: Row(
          children: [
            Icon(icon, color: color, size: 20.sp),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                title,
                style: AppTextStyles.labelMedium.copyWith(
                  color: isLocked
                      ? AppColors.textSecondaryDark.withOpacity(0.3)
                      : AppColors.textPrimaryDark,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            if (isCompleted)
              Icon(Icons.check_circle, color: AppColors.accent, size: 16.sp),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String text,
    required VoidCallback onPressed,
    bool isOutline = false,
    bool isGradient = false,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 52.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: isOutline ? const Color(0xFF1E293B) : null,
          gradient: isGradient ? AppColors.primaryGradient : null,
          borderRadius: BorderRadius.circular(12.r),
          border: isOutline
              ? Border.all(color: AppColors.primary.withOpacity(0.3))
              : null,
        ),
        child: MaterialButton(
          onPressed: onPressed,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon,
                  color: isGradient ? Colors.white : AppColors.primary,
                  size: 18.sp),
              SizedBox(width: 12.w),
              Text(
                text,
                style: AppTextStyles.labelMedium.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
