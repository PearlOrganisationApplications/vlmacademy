import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../student/student_dashboard.dart';

class TeacherHomeScreen extends StatelessWidget {
  const TeacherHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Inherit from dashboard
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16.h),
              _buildTopBar(context)
                  .animate()
                  .fadeIn(duration: 600.ms)
                  .slideY(begin: -0.2, end: 0, curve: Curves.easeOutQuad),
              SizedBox(height: 24.h),
              _buildEarningsCard()
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 800.ms)
                  .scale(
                      begin: const Offset(0.95, 0.95),
                      end: const Offset(1, 1),
                      curve: Curves.easeOutBack),
              SizedBox(height: 32.h),
              Text(
                'QUICK ACTIONS',
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.textSecondaryDark,
                  letterSpacing: 1.2,
                  fontWeight: FontWeight.bold,
                ),
              ).animate().fadeIn(delay: 400.ms),
              SizedBox(height: 16.h),
              _buildQuickActions(),
              SizedBox(height: 32.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "TODAY'S SCHEDULE",
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.textSecondaryDark,
                      letterSpacing: 1.2,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'View All',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ).animate().fadeIn(delay: 600.ms),
              SizedBox(height: 16.h),
              _buildScheduleTimeline(),
              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Row(
            children: [
              Container(
                width: 52.w,
                height: 52.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.primary, width: 2),
                ),
                child: Center(
                  child: Container(
                    width: 44.w,
                    height: 44.w,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: AppColors.primaryGradient,
                    ),
                    child: Center(
                      child: Text(
                        'PR',
                        style: AppTextStyles.labelMedium.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'WELCOME BACK,',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondaryDark,
                        fontSize: 10.sp,
                        letterSpacing: 0.5,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    Text(
                      'Priya',
                      style: AppTextStyles.h5.copyWith(
                        color: AppColors.textPrimaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Row(
          children: [
            GestureDetector(
              onTap: () {
                Navigator.of(context, rootNavigator: true).pushReplacement(
                  MaterialPageRoute(builder: (context) => const StudentDashboard()),
                );
              },
              child: _buildIconButton(Icons.swap_horiz, hasBadge: false),
            ),
            SizedBox(width: 12.w),
            _buildIconButton(Icons.notifications_outlined, hasBadge: true),
            SizedBox(width: 12.w),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
              decoration: BoxDecoration(
                color: const Color(0xFF064E3B).withOpacity(0.3),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(color: const Color(0xFF10B981), width: 2),
              ),
              child: Row(
                children: [
                  Icon(Icons.account_balance_wallet_outlined,
                      color: const Color(0xFF10B981), size: 18.sp),
                  SizedBox(width: 8.w),
                  Text(
                    '₹12,500',
                    style: AppTextStyles.labelSmall.copyWith(
                      color: const Color(0xFF10B981),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildIconButton(IconData icon, {bool hasBadge = false}) {
    return Stack(
      children: [
        Container(
          padding: EdgeInsets.all(12.r),
          decoration: BoxDecoration(
            color: const Color(0xFF1E293B),
            shape: BoxShape.circle,
            border: Border.all(color: Colors.white, width: 1.5),
          ),
          child: Icon(icon, color: Colors.white, size: 22.sp),
        ),
        if (hasBadge)
          Positioned(
            top: 10.r,
            right: 10.r,
            child: Container(
              width: 10.r,
              height: 10.r,
              decoration: BoxDecoration(
                color: const Color(0xFFEF4444),
                shape: BoxShape.circle,
                border: Border.all(color: const Color(0xFF070B18), width: 2),
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildEarningsCard() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(28.r),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(32.r),
        gradient: const LinearGradient(
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
          colors: [
            Color(0xFF1E293B),
            Color(0xFF476489),
          ],
        ),
        border: Border.all(color: AppColors.primary, width: 2),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.5),
            blurRadius: 30,
            spreadRadius: 2,
            offset: Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Earnings Summary',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.textSecondaryDark,
                  fontSize: 14.sp,
                ),
              ),
              Container(
                padding: EdgeInsets.all(10.r),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Icon(Icons.north_east_rounded,
                    color: const Color(0xFF10B981), size: 22.sp),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            '₹45,200',
            style: AppTextStyles.h2.copyWith(
              color: const Color(0xFF10B981),
              fontWeight: FontWeight.bold,
              fontSize: 38.sp,
            ),
          ),
          Text(
            'Total This Month',
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryDark,
              fontStyle: FontStyle.italic,
            ),
          ),
          SizedBox(height: 32.h),
          Divider(color: Colors.white.withOpacity(0.05)),
          SizedBox(height: 24.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildEarningsStat('BASE PAY', '₹35,000'),
              _buildEarningsStat('BONUS', '₹10,200'),
              _buildEarningsStat('RATING', '4.8 ⭐', isRating: true),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildEarningsStat(String label, String value,
      {bool isRating = false}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: AppTextStyles.bodySmall.copyWith(
            color: AppColors.textSecondaryDark,
            fontSize: 10.sp,
            letterSpacing: 0.8,
          ),
        ),
        SizedBox(height: 4.h),
        Row(
          children: [
            if (isRating)
              Icon(Icons.star, color: const Color(0xFFF59E0B), size: 14.sp),
            if (isRating) SizedBox(width: 4.w),
            Text(
              value,
              style: AppTextStyles.labelMedium.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.sp,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildQuickActions() {
    return Row(
      children: [
        Expanded(
          child: _buildActionCard(
            'Go Live Now',
            'Start instant session',
            Icons.play_circle_fill_rounded,
            const Color(0xFF3B82F6),
            0,
          ),
        ),
        SizedBox(width: 16.w),
        Expanded(
          child: _buildActionCard(
            'Upload Video',
            'Add recorded class',
            Icons.cloud_upload_rounded,
            const Color(0xFF6366F1),
            1,
          ),
        ),
      ],
    );
  }

  Widget _buildActionCard(
      String title, String subtitle, IconData icon, Color color, int index) {
    return Container(
      padding: EdgeInsets.all(22.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: AppColors.primary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(14.r),
            decoration: BoxDecoration(
              border: Border.all(color: AppColors.primary.withOpacity(0.5)),
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Icon(icon, color: color, size: 30.sp),
          ),
          SizedBox(height: 18.h),
          Text(
            title,
            style: AppTextStyles.labelLarge.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16.sp,
            ),
          ),
          SizedBox(height: 6.h),
          Text(
            subtitle,
            style: AppTextStyles.bodySmall.copyWith(
              color: AppColors.textSecondaryDark,
              fontSize: 10.sp,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(delay: (500 + (index * 100)).ms)
        .slideX(begin: 0.1, end: 0);
  }

  Widget _buildScheduleTimeline() {
    return Column(
      children: [
        _buildScheduleItem(
          time: '9:00 AM',
          title: 'Algebra Class (Live)',
          isCompleted: true,
          delay: 700,
        ),
        _buildScheduleItem(
          time: '11:00 AM',
          title: '1:1 Session with Rahul',
          isCompleted: true,
          delay: 800,
        ),
        _buildScheduleItem(
          time: '2:00 PM',
          title: 'Grade Assignments',
          isActive: true,
          delay: 900,
        ),
        _buildScheduleItem(
          time: '4:30 PM',
          title: 'Physics Q&A Live',
          delay: 1000,
        ),
      ],
    );
  }

  Widget _buildScheduleItem({
    required String time,
    required String title,
    bool isCompleted = false,
    bool isActive = false,
    int delay = 0,
  }) {
    return IntrinsicHeight(
      child: Row(
        children: [
          Column(
            children: [
              Container(
                width: 28.r,
                height: 28.r,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isCompleted
                      ? const Color(0xFF10B981).withOpacity(0.1)
                      : isActive
                          ? const Color(0xFF3B82F6).withOpacity(0.1)
                          : Colors.transparent,
                  border: Border.all(
                    color: isCompleted
                        ? const Color(0xFF10B981)
                        : isActive
                            ? const Color(0xFF3B82F6)
                            : AppColors.textSecondaryDark.withOpacity(0.2),
                    width: 2,
                  ),
                ),
                child: isCompleted
                    ? Icon(Icons.check,
                        color: const Color(0xFF10B981), size: 16.sp)
                    : null,
              ),
              Expanded(
                child: Container(
                  width: 2,
                  color: Colors.white.withOpacity(0.05),
                ),
              ),
            ],
          ),
          SizedBox(width: 20.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: 28.h),
              child: Container(
                padding: EdgeInsets.all(18.r),
                decoration: BoxDecoration(
                  color:
                      isActive ? const Color(0xFF1E293B) : Colors.transparent,
                  borderRadius: BorderRadius.circular(20.r),
                  border: isActive
                      ? Border.all(color: AppColors.primary, width: 2)
                      : null,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      time,
                      style: AppTextStyles.labelSmall.copyWith(
                        color: isActive
                            ? const Color(0xFF3B82F6)
                            : AppColors.textSecondaryDark,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 6.h),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: AppTextStyles.labelMedium.copyWith(
                              color: isCompleted
                                  ? AppColors.textSecondaryDark
                                  : Colors.white,
                              decoration: isCompleted
                                  ? TextDecoration.lineThrough
                                  : null,
                              fontSize: 15.sp,
                            ),
                          ),
                        ),
                        Icon(Icons.more_vert,
                            color: AppColors.textSecondaryDark, size: 20.sp),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    ).animate().fadeIn(delay: delay.ms).slideX(begin: 0.1, end: 0);
  }
}
