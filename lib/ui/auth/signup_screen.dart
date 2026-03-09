import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_images.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/custom_text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

enum _Role { student, parent, teacher }

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  _Role _selectedRole = _Role.student;
  bool _obscurePassword = true;
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _mobileController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onSignUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);

    // After signup, navigate to profile setup or dashboard
    if (_selectedRole == _Role.teacher) {
      Navigator.pushReplacementNamed(context, AppRoutes.teacherOnboarding);
    } else {
      Navigator.pushReplacementNamed(context, AppRoutes.studentDashboard);
    }
  }

  void _onLogin() {
    Navigator.pop(context);
  }

  void _onGoogleSignIn() {
    // TODO: Implement Google sign-in
  }

  void _onAppleSignIn() {
    // TODO: Implement Apple sign-in
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 32.h),

                      // ── Logo ─────────────────────────────────────────────
                      Center(child: const _LogoBadge()),

                      SizedBox(height: 32.h),

                      // ── Headline ─────────────────────────────────────────
                      Text(
                        "Create Account",
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.textPrimaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Join VLM Academy to start your learning journey',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondaryDark,
                        ),
                      ),

                      SizedBox(height: 24.h),

                      // ── Role Selection ───────────────────────────────────
                      _RoleTabs(
                        selected: _selectedRole,
                        onChanged: (r) => setState(() => _selectedRole = r),
                      ),

                      SizedBox(height: 24.h),

                      // ── Form ─────────────────────────────────────────────
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            // Full Name field
                            CustomTextField(
                              label: '',
                              hint: 'Full Name',
                              controller: _nameController,
                              prefixIcon: Icons.person_outline,
                              darkMode: true,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'Please enter your full name';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),

                            // Mobile Number field
                            CustomTextField(
                              label: '',
                              hint: 'Mobile Number',
                              controller: _mobileController,
                              prefixIcon: Icons.phone_outlined,
                              keyboardType: TextInputType.phone,
                              darkMode: true,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'Please enter your mobile number';
                                }
                                if (v.trim().length < 10) {
                                  return 'Enter a valid mobile number';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),

                            // Email field
                            CustomTextField(
                              label: '',
                              hint: 'Email',
                              controller: _emailController,
                              prefixIcon: Icons.email_outlined,
                              keyboardType: TextInputType.emailAddress,
                              darkMode: true,
                              validator: (v) {
                                if (v == null || v.trim().isEmpty) {
                                  return 'Please enter your email';
                                }
                                if (!RegExp(r'^[^@]+@[^@]+\.[^@]+')
                                    .hasMatch(v.trim())) {
                                  return 'Enter a valid email';
                                }
                                return null;
                              },
                            ),

                            SizedBox(height: 16.h),

                            // Password field
                            CustomTextField(
                              label: '',
                              hint: 'Password',
                              controller: _passwordController,
                              prefixIcon: Icons.lock_outline,
                              obscureText: _obscurePassword,
                              maxLength: 20,
                              darkMode: true,
                              suffixIcon: GestureDetector(
                                onTap: () => setState(
                                    () => _obscurePassword = !_obscurePassword),
                                child: Icon(
                                  _obscurePassword
                                      ? Icons.visibility_off_outlined
                                      : Icons.visibility_outlined,
                                  size: 18.sp,
                                  color: AppColors.textSecondaryDark,
                                ),
                              ),
                              validator: (v) {
                                if (v == null || v.isEmpty) {
                                  return 'Please enter your password';
                                }
                                if (v.length < 6) {
                                  return 'Password must be at least 6 characters';
                                }
                                return null;
                              },
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // ── Sign Up Button ────────────────────────────────────
                      _SignUpButton(
                        isLoading: _isLoading,
                        onPressed: _onSignUp,
                      ),

                      SizedBox(height: 28.h),

                      // ── Or Continue With ──────────────────────────────────
                      Row(
                        children: [
                          const Expanded(
                            child: Divider(
                                color: AppColors.borderDark, thickness: 1),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(horizontal: 12.w),
                            child: Text(
                              'Or Continue With',
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

                      SizedBox(height: 24.h),

                      // ── Social Buttons ────────────────────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _SocialButton(
                            onTap: _onGoogleSignIn,
                            child: Image.asset(
                              AppImages.googleIcon,
                              width: 24.w,
                              height: 24.h,
                              errorBuilder: (_, __, ___) => Icon(
                                Icons.g_mobiledata_rounded,
                                size: 28.sp,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(width: 20.w),
                          _SocialButton(
                            onTap: _onAppleSignIn,
                            child: Icon(
                              Icons.apple,
                              size: 26.sp,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 24.h),

                      // ── Login Link ──────────────────────────────────────
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 32.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have an Account? ',
                                style: AppTextStyles.bodySmall.copyWith(
                                  color: AppColors.textSecondaryDark,
                                ),
                              ),
                              GestureDetector(
                                onTap: _onLogin,
                                child: Text(
                                  'SIGN IN',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
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

// ─── Sign Up Button ───────────────────────────────────────────────────────────

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({
    required this.isLoading,
    required this.onPressed,
  });

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: MaterialButton(
          onPressed: isLoading ? null : onPressed,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32.r),
          ),
          child: isLoading
              ? SizedBox(
                  width: 22.w,
                  height: 22.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Sign Up',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                        fontSize: 16.sp,
                      ),
                    ),
                    SizedBox(width: 12.w),
                    Container(
                      width: 32.w,
                      height: 32.h,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 18.sp,
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

// ─── Social Button ────────────────────────────────────────────────────────────

class _SocialButton extends StatelessWidget {
  const _SocialButton({required this.onTap, required this.child});

  final VoidCallback onTap;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 56.w,
        height: 56.h,
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          shape: BoxShape.circle,
          border: Border.all(
            color: AppColors.borderDark,
            width: 1,
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
