import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:ui';
import 'package:provider/provider.dart';
import '../../providers/navigation_provider.dart';

import '../../core/constants/app_images.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../shared/background_screen.dart';
import 'chat/ai_chat_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      useSafeArea: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBrandedHeader(),
              SizedBox(height: 24.h),
              _buildGreetingSection(),
              SizedBox(height: 24.h),
              _buildActivityGrid(context),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(child: _buildSpinWinCard()),
                  SizedBox(width: 16.w),
                  Expanded(child: _buildLiveClassCard()),
                ],
              ),
              SizedBox(height: 24.h),
              _buildFeedSection('SHORT LIVE SESSIONS', true),
              SizedBox(height: 24.h),
              _buildFeedSection('SHORT VIDEO FEED', false),
              SizedBox(height: 40.h),
              _buildSecondActivityGrid(),
            ],
          ),
        ),
      ),
    );
  }

  // 1. Branded Header
  Widget _buildBrandedHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.school_outlined, color: Colors.white, size: 28.sp),
        ),
        Image.asset(
          AppImages.vlmLogo,
          width: 80.w,
          fit: BoxFit.contain,
        ),
        Stack(
          children: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_none_outlined,
                  color: Colors.white, size: 28.sp),
            ),
            Positioned(
              top: 12.h,
              right: 12.w,
              child: Container(
                width: 8.w,
                height: 8.w,
                decoration: const BoxDecoration(
                  color: Colors.redAccent,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // 2. Greeting Section
  Widget _buildGreetingSection() {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 12.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Hi Aryan 👋',
            style: AppTextStyles.h5.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }

  // 3. Activity Grid
  Widget _buildActivityGrid(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 8.h,
      crossAxisSpacing: 8.w,
      childAspectRatio: 0.7,
      children: [
        GestureDetector(
          onTap: () => context.read<NavigationProvider>().setIndex(1),
          child: _buildGridItem(
            label: 'ASK DOUBT',
            icon: FontAwesomeIcons.circleNodes,
            color: const Color(0xFF60A5FA),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AiChatScreen()),
            );
          },
          child: _buildGridItem(
            label: 'AI TUTOR',
            icon: FontAwesomeIcons.brain,
            color: const Color(0xFF818CF8),
          ),
        ),
        _buildGridItem(
          label: 'LIVE TEACHER',
          icon: Icons.person_pin_outlined,
          color: const Color(0xFFFACC15),
          hasBadge: true,
        ),
        GestureDetector(
          onTap: () => context.read<NavigationProvider>().setIndex(2),
          child: _buildGridItem(
            label: 'DAILY MCQ TASK',
            icon: FontAwesomeIcons.comments,
            color: const Color(0xFF2DD4BF),
            subtitle: 'Completed: 3/5',
            hasProgress: true,
          ),
        ),
        _buildGridItem(
          label: 'LEADERBOARD',
          icon: FontAwesomeIcons.trophy,
          color: const Color(0xFFF472B6),
          subtitle: 'Your Rank: #12',
          trend: '+3 Positions',
        ),
        _buildGridItem(
          label: 'REWARD POINTS',
          icon: FontAwesomeIcons.coins,
          color: const Color(0xFFFB923C),
          subtitle: 'Total: 1250 pts',
        ),
      ],
    );
  }

  // 3. Activity Grid
  Widget _buildSecondActivityGrid() {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 16.h,
      crossAxisSpacing: 16.w,
      childAspectRatio: 0.73,
      children: [
        _buildGridItem(
          label: 'HISTORY',
          icon: Icons.history,
          color: const Color(0xFF94A3B8),
        ),
        _buildGridItem(
          label: 'FAVORITES',
          icon: Icons.favorite_border,
          color: const Color(0xFFF87171),
        ),
        _buildGridItem(
          label: 'SETTINGS',
          icon: Icons.settings_outlined,
          color: const Color(0xFF94A3B8),
        ),
        _buildGridItem(
          label: 'SUPPORT',
          icon: Icons.support_agent,
          color: const Color(0xFF4ADE80),
        ),
        _buildGridItem(
          label: 'PARENT MODE',
          icon: Icons.family_restroom,
          color: const Color(0xFFA78BFA),
        ),
      ],
    );
  }

  Widget _buildGridItem({
    required String label,
    required IconData icon,
    required Color color,
    String? subtitle,
    String? trend,
    bool hasBadge = false,
    bool hasProgress = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: color.withOpacity(0.3), width: 1.w),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 1,
          )
        ],
      ),
      child: Stack(
        children: [
          if (hasBadge)
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Text('NEW',
                    style: TextStyle(color: Colors.white, fontSize: 8.sp)),
              ),
            ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  FaIcon(icon, color: color, size: 40.sp),
                  SizedBox(height: 12.h),
                  Text(
                    label,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14.5.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.3,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  if (subtitle != null) ...[
                    SizedBox(height: 6.h),
                    Text(
                      subtitle,
                      style: TextStyle(color: Colors.white54, fontSize: 8.5.sp),
                      textAlign: TextAlign.center,
                    ),
                  ],
                  if (hasProgress) ...[
                    SizedBox(height: 8.h),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(2.r),
                      child: LinearProgressIndicator(
                        value: 3 / 5,
                        backgroundColor: Colors.white10,
                        valueColor: AlwaysStoppedAnimation<Color>(color),
                        minHeight: 4.h,
                      ),
                    ),
                  ],
                  if (trend != null) ...[
                    SizedBox(height: 4.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.arrow_upward,
                            color: Colors.greenAccent, size: 10.sp),
                        Text(
                          trend,
                          style: TextStyle(
                              color: Colors.greenAccent, fontSize: 9.sp),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // 4. Feature Cards (Spin & Live Class)
  Widget _buildSpinWinCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        children: [
          Text(
            'SPIN & WIN TIMER',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 4.h),
          Text(
            'Next Spin in: 00:45:12',
            style: TextStyle(color: Colors.white38, fontSize: 8.sp),
          ),
          SizedBox(height: 16.h),
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60.w,
                height: 60.w,
                child: CircularProgressIndicator(
                  value: 0.7,
                  strokeWidth: 4.w,
                  backgroundColor: Colors.white10,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(Color(0xFFFACC15)),
                ),
              ),
              Icon(Icons.access_time_filled,
                  color: Colors.yellow.withOpacity(0.5), size: 30.sp),
            ],
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 6.h),
            decoration: BoxDecoration(
              gradient: AppColors.secondaryGradient,
              borderRadius: BorderRadius.circular(20.r),
            ),
            child: Text(
              'SPIN NOW',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 10.sp,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLiveClassCard() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.1)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'UPCOMING LIVE CLASS',
            style: TextStyle(
                color: Colors.white70,
                fontSize: 14.sp,
                fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8.h),
          Text(
            'Topic: JEE Main: Organic Chemistry',
            style: TextStyle(
                color: Colors.white,
                fontSize: 11.sp,
                fontWeight: FontWeight.w500),
            maxLines: 2,
          ),
          SizedBox(height: 4.h),
          Text(
            'Time: 2:00 PM IST (Today)',
            style: TextStyle(color: Colors.white38, fontSize: 8.sp),
          ),
          SizedBox(height: 12.h),
          Row(
            children: [
              CircleAvatar(
                radius: 12.r,
                backgroundColor: Colors.white10,
                backgroundImage:
                    const NetworkImage('https://i.pravatar.cc/150?u=doc'),
              ),
              SizedBox(width: 8.w),
              Text('Dr. Sharma',
                  style: TextStyle(color: Colors.white70, fontSize: 9.sp)),
            ],
          ),
          SizedBox(height: 12.h),
          Container(
            width: double.infinity,
            padding: EdgeInsets.symmetric(vertical: 6.h),
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20.r),
              border: Border.all(color: Colors.white10),
            ),
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('JOIN LIVE  ',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 10.sp,
                        fontWeight: FontWeight.bold)),
                Text('00:45:12',
                    style: TextStyle(color: Colors.white54, fontSize: 8.sp)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // 5. Feed Sections
  Widget _buildFeedSection(String title, bool isLive) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.w),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 14.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(height: 16.h),
        SizedBox(
          height: 180.h,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: 5,
            separatorBuilder: (context, index) => SizedBox(width: 16.w),
            itemBuilder: (context, index) {
              return _buildFeedItem(isLive);
            },
          ),
        ),
      ],
    );
  }

  Widget _buildFeedItem(bool isLive) {
    return Container(
      width: 150.w,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.05),
        borderRadius: BorderRadius.circular(16.r),
        image: DecorationImage(
          image: NetworkImage(
              'https://picsum.photos/200/300?sig=${DateTime.now().millisecondsSinceEpoch}'),
          fit: BoxFit.cover,
          colorFilter:
              ColorFilter.mode(Colors.black.withOpacity(0.3), BlendMode.darken),
        ),
      ),
      child: Stack(
        children: [
          if (isLive)
            Positioned(
              top: 8.h,
              right: 8.w,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                decoration: BoxDecoration(
                  color: Colors.redAccent,
                  borderRadius: BorderRadius.circular(4.r),
                ),
                child: Row(
                  children: [
                    Container(
                        width: 4.w,
                        height: 4.w,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle)),
                    SizedBox(width: 4.w),
                    Text('LIVE',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 6.sp,
                            fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
            ),
          if (!isLive)
            Center(
              child: Container(
                padding: EdgeInsets.all(4.w),
                decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.2),
                    shape: BoxShape.circle),
                child: Icon(Icons.play_arrow, color: Colors.white, size: 24.sp),
              ),
            ),
          Positioned(
            bottom: 8.h,
            left: 8.w,
            right: 8.w,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '5 Min: Complex Numbers Trick',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.bold),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                if (isLive) ...[
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.person, color: Colors.white70, size: 8.sp),
                      SizedBox(width: 4.w),
                      Text('Teacher',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 6.sp)),
                    ],
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
