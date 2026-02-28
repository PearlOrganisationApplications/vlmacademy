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
  void _onSignInWithAccount() {
    Navigator.pushNamed(context, AppRoutes.emailLogin);
  }

  void _onSignUp() {
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bgimage.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: IntrinsicHeight(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(height: 64.h),

                        // Logo
                        const _LogoBadge(),

                        SizedBox(height: 40.h),

                        // Headline
                        Text.rich(
                          TextSpan(
                            text: 'Learning Never Sleeps\nat ',
                            style: AppTextStyles.h3.copyWith(
                              color: AppColors.textPrimaryDark,
                              fontWeight: FontWeight.bold,
                            ),
                            children: const [
                              TextSpan(
                                text: 'VLM Academy',
                                style: TextStyle(color: AppColors.primary),
                              ),
                            ],
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

                        SizedBox(height: 56.h),

                        // Divider
                        Row(
                          children: [
                            const Expanded(
                              child: Divider(
                                  color: AppColors.borderDark, thickness: 1),
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
                              child: Divider(
                                  color: AppColors.borderDark, thickness: 1),
                            ),
                          ],
                        ),

                        SizedBox(height: 28.h),

                        // Google Sign-In — glassmorphic
                        CustomButton(
                          text: 'Sign in with Google',
                          onPressed: _onGoogleSignIn,
                          type: ButtonType.glassmorphic,
                          size: ButtonSize.large,
                          imageIcon: AppImages.googleIcon,
                          fullWidth: true,
                        ),

                        SizedBox(height: 16.h),

                        const Spacer(),

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
            },
          ),
        ),
      ),
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
        color: const Color(0xFF1E293B).withOpacity(0.5),
        borderRadius: BorderRadius.circular(24.r),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1),
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
                  color: isActive
                      ? AppColors.primary.withOpacity(0.15)
                      : Colors.transparent,
                  border: isActive
                      ? Border.all(
                          color: AppColors.primary.withOpacity(0.8), width: 1.5)
                      : Border.all(color: Colors.transparent, width: 1.5),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: isActive
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.8),
                            blurRadius: 4,
                            spreadRadius: 1,
                          ),
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.5),
                            blurRadius: 16,
                          ),
                        ]
                      : null,
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
              color: const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(32.r),
              border:
                  Border.all(color: Colors.white.withOpacity(0.1), width: 1),
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
                          // color: AppColors.textSecondaryDark,
                          ),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      counterText: '',
                      isDense: true,
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
                // Send OTP — reuse CustomButton gradient type
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  child: CustomButton(
                    text: 'Send OTP',
                    onPressed: isLoading ? null : onSend,
                    type: ButtonType.gradient,
                    gradient: const LinearGradient(
                        colors: [AppColors.primaryDark, AppColors.primaryDark]),
                    size: ButtonSize.medium,
                    isLoading: isLoading,
                    hasGlow: true,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ─── Logo Badge ───────────────────────────────────────────────────────────────

class _LogoBadge extends StatelessWidget {
  const _LogoBadge();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80.w,
      height: 80.h,
      child: Center(
        child: Image.asset(
          AppImages.vlmLogo,
          width: 80.w,
          height: 80.h,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
