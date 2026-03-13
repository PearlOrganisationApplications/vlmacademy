import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/app_images.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../shared/background_screen.dart';

class RoleSelectionScreen extends StatefulWidget {
  const RoleSelectionScreen({super.key});

  @override
  State<RoleSelectionScreen> createState() => _RoleSelectionScreenState();
}

class _RoleSelectionScreenState extends State<RoleSelectionScreen> {
  String? _selectedRole;

  void _onRoleSelected(String role) {
    setState(() {
      _selectedRole = role;
    });
  }

  void _onContinue() {
    if (_selectedRole != null) {
      Navigator.pushReplacementNamed(context, AppRoutes.login);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a role to continue'),
          backgroundColor: AppColors.primary,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      useSafeArea: true,
      backgroundGradient: LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Colors.black.withOpacity(0.4),
          Colors.black.withOpacity(0.6),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 20.h),
            // 1. Top Logo
            Center(
              child: Image.asset(
                AppImages.vlmLogo,
                width: 100.w,
                fit: BoxFit.contain,
              ),
            ),
            SizedBox(height: 32.h),
            // 2. Welcome Message
            Text(
              'Welcome To VLM ACADEMY',
              style: AppTextStyles.h3.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 8.h),
            Text(
              'Please select your role to continue',
              style: AppTextStyles.bodyMedium.copyWith(
                color: Colors.white70,
                letterSpacing: 0.5,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40.h),
            // 3. Role Cards
            Expanded(
              child: ListView(
                physics: const BouncingScrollPhysics(),
                children: [
                  _RoleCard(
                    roleId: 'student',
                    title: 'STUDENT',
                    description: 'Start your personalized advanced learning journey.',
                    imagePath: AppImages.roleStudent,
                    isSelected: _selectedRole == 'student',
                    onTap: () => _onRoleSelected('student'),
                  ),
                  SizedBox(height: 16.h),
                  _RoleCard(
                    roleId: 'parent',
                    title: 'PARENT',
                    description: 'Track performance, view attendance, and support growth.',
                    imagePath: AppImages.roleParent,
                    isSelected: _selectedRole == 'parent',
                    onTap: () => _onRoleSelected('parent'),
                  ),
                  SizedBox(height: 16.h),
                  _RoleCard(
                    roleId: 'teacher',
                    title: 'TEACHER',
                    description: 'Access curriculum, manage classes, and assign homework.',
                    imagePath: AppImages.roleTeacher,
                    isSelected: _selectedRole == 'teacher',
                    onTap: () => _onRoleSelected('teacher'),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
            // 4. Continue Button
            Padding(
              padding: EdgeInsets.only(bottom: 24.h, top: 12.h),
              child: Container(
                height: 56.h,
                decoration: BoxDecoration(
                  gradient: _selectedRole != null ? AppColors.primaryGradient : null,
                  color: _selectedRole == null ? Colors.white24 : null,
                  borderRadius: BorderRadius.circular(16.r),
                  boxShadow: _selectedRole != null
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : null,
                ),
                child: ElevatedButton(
                  onPressed: _onContinue,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                  ),
                  child: Text(
                    'CONTINUE',
                    style: AppTextStyles.buttonLarge.copyWith(
                      color: _selectedRole != null ? Colors.white : Colors.white38,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RoleCard extends StatelessWidget {
  final String roleId;
  final String title;
  final String description;
  final String imagePath;
  final bool isSelected;
  final VoidCallback onTap;

  const _RoleCard({
    required this.roleId,
    required this.title,
    required this.description,
    required this.imagePath,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: isSelected ? Colors.white.withOpacity(0.15) : Colors.white.withOpacity(0.1),
          borderRadius: BorderRadius.circular(24.r),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.white12,
            width: isSelected ? 2.w : 1.w,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.2),
                    blurRadius: 15,
                    spreadRadius: 2,
                  )
                ]
              : [],
        ),
        child: Row(
          children: [
            // Image Container
            Container(
              width: 80.w,
              height: 80.w,
              decoration: BoxDecoration(
                color: Colors.white10,
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16.r),
                child: Image.asset(
                  imagePath,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(width: 16.w),
            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: AppTextStyles.h5.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.2,
                    ),
                  ),
                  SizedBox(height: 4.h),
                  Text(
                    description,
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white60,
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
            // Lotus indicator (optional flair from the user's reference image)
            Icon(
              Icons.spa_outlined,
              color: Colors.white.withOpacity(isSelected ? 0.3 : 0.1),
              size: 20.sp,
            ),
          ],
        ),
      ),
    );
  }
}
