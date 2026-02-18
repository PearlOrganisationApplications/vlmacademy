import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_images.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/custom_button.dart';

// ─── Role enum ───────────────────────────────────────────────────────────────

enum _Role { student, parent, teacher }

// ─── Screen ──────────────────────────────────────────────────────────────────

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _phoneController = TextEditingController();
  _Role _selectedRole = _Role.student;
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _onSendOtp() async {
    final phone = _phoneController.text.trim();
    if (phone.length < 10) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.pushNamed(context, AppRoutes.otp,
        arguments: {'phoneNumber': phone});
  }

  void _onGoogleSignIn() {}
  void _onSignInWithAccount() {}
  void _onSignUp() {}

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 64.h),

              // Logo
              _LogoBadge(),

              SizedBox(height: 40.h),

              // Headline
              Text(
                'Learning Never Sleeps\nat VLM Academy',
                style: AppTextStyles.h3.copyWith(
                  color: AppColors.textPrimaryDark,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),

              SizedBox(height: 40.h),

              // Role tabs
              _RoleTabs(
                selected: _selectedRole,
                onChanged: (r) => setState(() => _selectedRole = r),
              ),

              SizedBox(height: 32.h),

              // Phone input + Send OTP
              _PhoneRow(
                controller: _phoneController,
                isLoading: _isLoading,
                onSend: _onSendOtp,
              ),

              SizedBox(height: 28.h),

              // Divider
              Row(
                children: [
                  const Expanded(
                    child: Divider(color: AppColors.borderDark, thickness: 1),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 12.w),
                    child: Text(
                      'Or continue with',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondaryDark,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: Divider(color: AppColors.borderDark, thickness: 1),
                  ),
                ],
              ),

              SizedBox(height: 28.h),

              // Google Sign-In — dark surface, use asset icon
              CustomButton(
                text: 'Sign in with Google',
                onPressed: _onGoogleSignIn,
                type: ButtonType.gradient,
                size: ButtonSize.large,
                imageIcon: AppImages.googleIcon,
                showTrailingArrow: true,
                gradient: LinearGradient(
                  colors: [AppColors.surfaceDark, AppColors.surfaceDark],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                fullWidth: true,
              ),

              SizedBox(height: 16.h),

              // GitHub Sign-In
              CustomButton(
                text: 'Sign in with GitHub',
                onPressed: () {}, // Add logic later
                type: ButtonType.gradient,
                size: ButtonSize.large,
                icon: Icons.code, // Fallback icon for now
                showTrailingArrow: true,
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF24292E),
                    Color(0xFF24292E)
                  ], // GitHub dark color
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
                fullWidth: true,
              ),

              SizedBox(height: 16.h),

              // Sign in with Account — blue gradient
              CustomButton(
                text: 'Sign in with Your Account',
                onPressed: _onSignInWithAccount,
                type: ButtonType.gradient,
                size: ButtonSize.large,
                icon: Icons.person_outline_rounded,
                showTrailingArrow: true,
                fullWidth: true,
              ),

              SizedBox(height: 36.h),

              // Sign Up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an Account? ",
                    style: AppTextStyles.bodySmall.copyWith(
                      color: AppColors.textSecondaryDark,
                    ),
                  ),
                  GestureDetector(
                    onTap: _onSignUp,
                    child: Text(
                      'SIGN UP',
                      style: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.5,
                      ),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 32.h),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Logo Badge ───────────────────────────────────────────────────────────────

class _LogoBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 8.h),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10.r),
          ),
          child: Text(
            'VLM',
            style: AppTextStyles.h5.copyWith(
              color: AppColors.backgroundDark,
              fontWeight: FontWeight.bold,
              letterSpacing: 1,
            ),
          ),
        ),
        SizedBox(width: 8.w),
        ShaderMask(
          shaderCallback: (bounds) =>
              AppColors.primaryGradient.createShader(bounds),
          child: Text(
            'Academy',
            style: AppTextStyles.h5.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Role Tabs ────────────────────────────────────────────────────────────────

class _RoleTabs extends StatelessWidget {
  const _RoleTabs({required this.selected, required this.onChanged});

  final _Role selected;
  final ValueChanged<_Role> onChanged;

  static const _roles = [
    (_Role.student, 'Student'),
    (_Role.parent, 'Parent'),
    (_Role.teacher, 'Teacher'),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(4.r),
      decoration: BoxDecoration(
        color: AppColors.surfaceDark,
        borderRadius: BorderRadius.circular(14.r),
      ),
      child: Row(
        children: _roles.map((entry) {
          final (role, label) = entry;
          final isActive = selected == role;
          return Expanded(
            child: GestureDetector(
              onTap: () => onChanged(role),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 250),
                curve: Curves.easeInOut,
                padding: EdgeInsets.symmetric(vertical: 12.h),
                decoration: BoxDecoration(
                  gradient: isActive ? AppColors.primaryGradient : null,
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: AppTextStyles.labelMedium.copyWith(
                    color:
                        isActive ? Colors.white : AppColors.textSecondaryDark,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}

// ─── Phone Row ────────────────────────────────────────────────────────────────

class _PhoneRow extends StatelessWidget {
  const _PhoneRow({
    required this.controller,
    required this.isLoading,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool isLoading;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Phone input field
        Expanded(
          child: Container(
            height: 64.h,
            decoration: BoxDecoration(
              color: AppColors.surfaceDark,
              borderRadius: BorderRadius.circular(32.r),
            ),
            child: Row(
              children: [
                SizedBox(width: 14.w),
                Icon(
                  Icons.phone_outlined,
                  size: 18.sp,
                  color: AppColors.textSecondaryDark,
                ),
                SizedBox(width: 8.w),
                Expanded(
                  child: TextField(
                    controller: controller,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textPrimaryDark,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Mobile Number (+91)',
                      hintStyle: AppTextStyles.bodySmall.copyWith(
                        color: AppColors.textSecondaryDark,
                      ),
                      border: InputBorder.none,
                      counterText: '',
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(width: 10.w),

        // Send OTP — reuse CustomButton gradient type
        CustomButton(
          text: 'Send otp',
          onPressed: isLoading ? null : onSend,
          type: ButtonType.gradient,
          size: ButtonSize.large,
          isLoading: isLoading,
        ),
      ],
    );
  }
}
