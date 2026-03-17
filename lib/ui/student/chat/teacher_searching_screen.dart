import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../shared/background_screen.dart';
import 'chat_detail_screen.dart';
import 'dart:async';

class TeacherSearchingScreen extends StatefulWidget {
  const TeacherSearchingScreen({super.key});

  @override
  State<TeacherSearchingScreen> createState() => _TeacherSearchingScreenState();
}

class _TeacherSearchingScreenState extends State<TeacherSearchingScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  Timer? _searchTimer;
  bool _isSearching = true;

  final List<Map<String, dynamic>> _foundTeachers = [
    {
      'name': 'Priya S.',
      'specialization': 'Advanced Mathematics - Calculus',
      'rating': 4.9,
      'avatar': 'https://i.pravatar.cc/150?u=priya',
      'isPremium': true,
    },
    {
      'name': 'Rahul K.',
      'specialization': 'Coordinate Geometry Expert',
      'rating': 4.8,
      'avatar': 'https://i.pravatar.cc/150?u=rahul',
      'isPremium': false,
    },
    {
      'name': 'Sneha M.',
      'specialization': 'Trigonometry Specialist',
      'rating': 4.7,
      'avatar': 'https://i.pravatar.cc/150?u=sneha',
      'isPremium': true,
    },
  ];

  final List<String> _teacherAvatars = [
    'https://i.pravatar.cc/150?u=1',
    'https://i.pravatar.cc/150?u=2',
    'https://i.pravatar.cc/150?u=3',
    'https://i.pravatar.cc/150?u=4',
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    )..repeat();

    // Simulate searching for 3 seconds, then show results
    _searchTimer = Timer(const Duration(seconds: 3), () {
      if (mounted) {
        setState(() {
          _isSearching = false;
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _searchTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      body: SafeArea(
        child: Column(
          children: [
            _buildAppBar(),
            SizedBox(height: 20.h),
            _buildTitleSection(),
            SizedBox(height: 30.h),
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 500),
                child: _isSearching
                    ? _buildAnimatedDiscovery()
                    : _buildTeacherList(),
              ),
            ),
            if (_isSearching) ...[
              _buildInfoCard(),
              SizedBox(height: 30.h),
              _buildCancelButton(),
              SizedBox(height: 30.h),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
          const Spacer(),
          Text(
            _isSearching ? 'Teacher Searching' : 'Available Teachers',
            style: AppTextStyles.h6.copyWith(color: Colors.white),
          ),
          const Spacer(),
          SizedBox(width: 48.w),
        ],
      ),
    );
  }

  Widget _buildTitleSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 30.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _isSearching
                ? 'Finding the best teacher for your doubt...'
                : 'We found ${_foundTeachers.length} expert teachers ready to help!',
            style: AppTextStyles.h4.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTeacherList() {
    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
      itemCount: _foundTeachers.length,
      itemBuilder: (context, index) {
        final teacher = _foundTeachers[index];
        return _buildTeacherCard(teacher);
      },
    );
  }

  Widget _buildTeacherCard(Map<String, dynamic> teacher) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color: Colors.white.withValues(alpha: 0.15)),
      ),
      child: InkWell(
        onTap: () {
          PersistentNavBarNavigator.pushNewScreen(
            context,
            screen: const ChatDetailScreen(),
            withNavBar: false,
            pageTransitionAnimation: PageTransitionAnimation.cupertino,
          );
        },
        borderRadius: BorderRadius.circular(20.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundImage: NetworkImage(teacher['avatar']),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                      width: 12.w,
                      height: 12.w,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(width: 15.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          teacher['name'],
                          style: AppTextStyles.h6.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        if (teacher['isPremium'])
                          Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8.w, vertical: 4.h),
                            decoration: BoxDecoration(
                              color:
                                  Colors.orangeAccent.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8.r),
                              border: Border.all(
                                  color: Colors.orangeAccent
                                      .withValues(alpha: 0.5)),
                            ),
                            child: Text(
                              'PREMIUM',
                              style: TextStyle(
                                color: Colors.orangeAccent,
                                fontSize: 9.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '${teacher['rating']} Stars',
                          style:
                              TextStyle(color: Colors.white70, fontSize: 12.sp),
                        ),
                        SizedBox(width: 4.w),
                        Icon(Icons.star,
                            color: Colors.orangeAccent, size: 14.sp),
                      ],
                    ),
                    Text(
                      teacher['specialization'],
                      style: TextStyle(color: Colors.white60, fontSize: 12.sp),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right, color: Colors.white38, size: 24.sp),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAnimatedDiscovery() {
    return SizedBox(
      height: 300.h,
      width: double.infinity,
      child: Stack(
        alignment: Alignment.center,
        children: [
          // Background Rings
          ...List.generate(3, (index) {
            return AnimatedBuilder(
              animation: _controller,
              builder: (context, child) {
                double scale = (index + 1) * 0.3 * _controller.value + 0.3;
                return Container(
                  width: 250.w * scale,
                  height: 250.w * scale,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: Colors.white
                          .withOpacity(0.15 * (1 - _controller.value)),
                      width: 2,
                    ),
                  ),
                );
              },
            );
          }),

          // Floating Teachers
          _buildFloatingTeacher(0, -100.h, -100.w, _teacherAvatars[0]),
          _buildFloatingTeacher(1, -100.h, 100.w, _teacherAvatars[1]),
          _buildFloatingTeacher(2, 100.h, -100.w, _teacherAvatars[2]),
          _buildFloatingTeacher(3, 100.h, 100.w, _teacherAvatars[3]),

          // Center Logo
          Container(
            padding: EdgeInsets.all(20.w),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.withValues(alpha: 0.3),
                  blurRadius: 20,
                  spreadRadius: 5,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'VLM',
                  style: TextStyle(
                    color: Colors.blue[900],
                    fontWeight: FontWeight.bold,
                    fontSize: 24.sp,
                  ),
                ),
                Text(
                  'Doubt\nResolved',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.blue[800],
                    fontSize: 10.sp,
                  ),
                ),
              ],
            ),
          ),

          Positioned(
            top: 60.h,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 1.0),
                borderRadius: BorderRadius.circular(20.r),
              ),
              child: Text(
                'Request sent to 4 teachers',
                style: TextStyle(color: Colors.white70, fontSize: 12.sp),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFloatingTeacher(int index, double top, double left, String url) {
    return Positioned(
      top: 150.h + top,
      left: ScreenUtil().screenWidth / 2 + left - 30.w,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          // Subtle hover animation
          double offset =
              5 * (index % 2 == 0 ? 1 : -1) * (1 - _controller.value);
          return Transform.translate(
            offset: Offset(0, offset),
            child: Container(
              padding: EdgeInsets.all(2.w),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.5), width: 1.5),
              ),
              child: CircleAvatar(
                radius: 25.r,
                backgroundImage: NetworkImage(url),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoCard() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30.w),
      padding: EdgeInsets.all(20.w),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 1.0),
        borderRadius: BorderRadius.circular(25.r),
        border: Border.all(color: Colors.white.withValues(alpha: 1.0)),
      ),
      child: Column(
        children: [
          _buildInfoRow(
              Icons.science_outlined, 'Subject', 'Mathematics (Calculus)'),
          SizedBox(height: 15.h),
          _buildInfoRow(Icons.school_outlined, 'Class', 'Class 10th'),
          SizedBox(height: 15.h),
          _buildInfoRow(
              Icons.videocam_outlined, 'Session Type', 'Live Video Call'),
        ],
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10.w),
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 1.0),
            borderRadius: BorderRadius.circular(12.r),
          ),
          child: Icon(icon, color: Colors.blueAccent, size: 24.sp),
        ),
        SizedBox(width: 15.w),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label,
                style: TextStyle(color: Colors.white60, fontSize: 12.sp)),
            Text(value,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ],
    );
  }

  Widget _buildCancelButton() {
    return TextButton(
      onPressed: () => Navigator.pop(context),
      child: Text(
        'Cancel Request',
        style: TextStyle(
          color: Colors.white70,
          fontSize: 16.sp,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}
