import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../shared/background_screen.dart';
import 'mcq_quiz_screen.dart';
import 'dart:ui';

class DailyMcqScreen extends StatefulWidget {
  const DailyMcqScreen({super.key});

  @override
  State<DailyMcqScreen> createState() => _DailyMcqScreenState();
}

class _DailyMcqScreenState extends State<DailyMcqScreen> {
  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      useSafeArea: false,
      backgroundColor: const Color(0xFF020617), // Deep dark fallback
      body: SingleChildScrollView(
        child: SafeArea(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(children: [
                  SizedBox(height: 20.h),
                  _buildHeader(),
                  SizedBox(height: 40.h),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(20.r),
                    child: BackdropFilter(
                      filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.only(top: 24.w),
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(color: AppColors.borderLight),
                        ),
                        child: Column(
                          children: [
                            _buildTitleSection(),
                            SizedBox(height: 30.h),
                            _buildInfoCards(),
                            SizedBox(height: 30.h),
                            _buildMainChallengeCard(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 30.h),
                  _buildStartButton(),
                  SizedBox(height: 30.h),
                ]))),
      ),
    );
  }

  Widget _buildHeader() {
    final bool canPop = Navigator.canPop(context);
    return Row(
      children: [
        if (canPop)
          IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back, color: Colors.white),
          )
        else
          SizedBox(width: 48.w), // Spacer to balance header when no back button
        const Spacer(),
      ],
    );
  }

  Widget _buildTitleSection() {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Today's 20 MCQ",
              style: AppTextStyles.h1.copyWith(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Challenge",
              style: AppTextStyles.h1.copyWith(
                color: Colors.white,
                fontSize: 32.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 8.w),
            Icon(Icons.auto_awesome, color: Colors.cyanAccent, size: 28.sp),
          ],
        ),
      ],
    );
  }

  Widget _buildInfoCards() {
    return Container(
      padding: EdgeInsets.all(26.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.9),
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(24.r), topRight: Radius.circular(24.r)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildInfoItem(
            icon: Icons.school,
            iconBg: Colors.teal.shade700,
            label: 'Class:',
            value: '10th',
          ),
          Container(
            height: 40.h,
            width: 1.w,
            color: Colors.grey.withValues(alpha: 0.3),
          ),
          _buildInfoItem(
            icon: Icons.menu_book,
            iconBg: Colors.indigo.shade800,
            label: 'Subject:',
            value: 'Mathematics\n& Science',
          ),
        ],
      ),
    );
  }

  Widget _buildInfoItem({
    required IconData icon,
    required Color iconBg,
    required String label,
    required String value,
  }) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: iconBg,
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: Colors.white, size: 24.sp),
        ),
        SizedBox(width: 12.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: TextStyle(color: Colors.grey.shade600, fontSize: 12.sp),
            ),
            Text(
              value,
              style: TextStyle(
                color: Colors.black,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMainChallengeCard() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20.r),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.all(24.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(20.r),
            border: Border.all(color: AppColors.borderLight),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildTimerSection(),
                  _buildRewardSection(),
                ],
              ),
              SizedBox(height: 30.h),
              Text(
                'Boost your score and climb the\nleaderboard! 🏆',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTimerSection() {
    return Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            SizedBox(
              width: 100.w,
              height: 100.w,
              child: CircularProgressIndicator(
                value: 0.8,
                strokeWidth: 8.w,
                backgroundColor: Colors.white10,
                valueColor:
                    const AlwaysStoppedAnimation<Color>(Colors.cyanAccent),
              ),
            ),
            Text(
              '20:00',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        SizedBox(height: 12.h),
        Text(
          'Time Left',
          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildRewardSection() {
    return Column(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCoinStack(),
          ],
        ),
        SizedBox(height: 8.h),
        Text(
          '250 PTS',
          style: TextStyle(
            color: Colors.orangeAccent,
            fontSize: 28.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          'Points Reward',
          style: TextStyle(color: Colors.white70, fontSize: 14.sp),
        ),
      ],
    );
  }

  Widget _buildCoinStack() {
    return Stack(
      children: [
        Icon(FontAwesomeIcons.coins, color: Colors.orangeAccent, size: 50.sp),
      ],
    );
  }

  Widget _buildStartButton() {
    return Container(
      width: double.infinity,
      height: 60.h,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF2DD4BF), Color(0xFF3B82F6)],
          begin: Alignment.centerLeft,
          end: Alignment.centerRight,
        ),
        borderRadius: BorderRadius.circular(30.r),
        boxShadow: [
          BoxShadow(
            color: Colors.cyan.withValues(alpha: 0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const McqQuizScreen()),
            );
          },
          borderRadius: BorderRadius.circular(30.r),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Start Task',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
              SizedBox(width: 8.w),
              Icon(Icons.north_east, color: Colors.white, size: 20.sp),
            ],
          ),
        ),
      ),
    );
  }
}
