import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_images.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../shared/background_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _identifierController = TextEditingController(); // Email or Mobile
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _isOtpLogin = false;

  @override
  void dispose() {
    _identifierController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _onContinue() {
    if (_formKey.currentState!.validate()) {
      setState(() => _isLoading = true);
      // Simulate login logic
      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          setState(() => _isLoading = false);
          Navigator.pushReplacementNamed(context, AppRoutes.studentDashboard);
        }
      });
    }
  }

  void _onLoginWithOtp() {
    setState(() {
      _isOtpLogin = !_isOtpLogin;
    });
  }

  void _onSignUp() {
    Navigator.pushNamed(context, AppRoutes.signup);
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      useSafeArea: false,
      body: Stack(
        children: [
          SafeArea(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                children: [
                  SizedBox(height: 40.h),
                  // 2. Head Logo
                  Center(
                    child: Image.asset(
                      AppImages.vlmLogo,
                      width: 150.w,
                      fit: BoxFit.contain,
                    ),
                  ),
                  SizedBox(height: 40.h),
                  // 3. Headline
                  Text(
                    'Start Your Learning Journey',
                    style: AppTextStyles.h4.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 22.sp,
                    ),
                  ),
                  SizedBox(height: 32.h),
                  // 4. Glassmorphic Form
                  _buildGlassForm(),
                  SizedBox(height: 32.h),
                  // 5. OAuth Options
                  _buildOAuthSection(),
                  SizedBox(height: 40.h),
                  // 6. Sign Up Footer
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'New here? ',
                        style: AppTextStyles.bodySmall
                            .copyWith(color: Colors.white70),
                      ),
                      GestureDetector(
                        onTap: _onSignUp,
                        child: Text(
                          'Create Account',
                          style: AppTextStyles.bodySmall.copyWith(
                            color: AppColors.primaryLight,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 40.h),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildGlassForm() {
    return Container(
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.08),
        borderRadius: BorderRadius.circular(32.r),
        border: Border.all(color: Colors.white.withOpacity(0.1), width: 1.5),
      ),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            // Identifier Field (Mobile/Email)
            _buildGlassField(
              controller: _identifierController,
              hint: _isOtpLogin ? 'Enter Mobile Number' : 'Email or Mobile Number',
              label: _isOtpLogin ? 'Mobile Number' : 'Email/Mobile',
              icon: _isOtpLogin ? Icons.phone_android_outlined : Icons.person_outline,
              validator: (v) {
                if (v == null || v.isEmpty) return 'Please enter ${_isOtpLogin ? 'mobile number' : 'email or mobile'}';
                return null;
              },
            ),
            if (!_isOtpLogin) ...[
              SizedBox(height: 16.h),
              // Password Field
              _buildGlassField(
                controller: _passwordController,
                hint: '••••••••',
                label: 'Password',
                icon: Icons.lock_outline,
                obscureText: _obscurePassword,
                suffix: IconButton(
                  icon: Icon(
                    _obscurePassword ? Icons.visibility_off : Icons.visibility,
                    color: Colors.white54,
                    size: 20.sp,
                  ),
                  onPressed: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Please enter password';
                  return null;
                },
              ),
            ],
            SizedBox(height: 32.h),
            // Continue Button
            _buildPrimaryButton(
              text: _isOtpLogin ? 'Send OTP' : 'Continue',
              onPressed: _isOtpLogin
                  ? () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushNamed(context, AppRoutes.otp, arguments: {
                          'phoneNumber': _identifierController.text,
                        });
                      }
                    }
                  : _onContinue,
              isLoading: _isLoading,
            ),
            SizedBox(height: 16.h),
            // Login with OTP Button
            _buildSecondaryButton(
              text: _isOtpLogin ? 'Login with Password' : 'Login with OTP',
              onPressed: _onLoginWithOtp,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGlassField({
    required TextEditingController controller,
    required String hint,
    required String label,
    required IconData icon,
    bool obscureText = false,
    Widget? suffix,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 12.w, bottom: 8.h),
          child: Text(
            label,
            style: AppTextStyles.bodySmall
                .copyWith(color: Colors.white60, fontSize: 10.sp),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.12),
            borderRadius: BorderRadius.circular(16.r),
            //border: Border.all(color: Colors.white12),
          ),
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: AppTextStyles.bodyMedium.copyWith(color: Colors.white),
            decoration: InputDecoration(
              prefixIcon: Icon(icon, color: Colors.white70, size: 22.sp),
              hintText: hint,
              hintStyle:
                  AppTextStyles.bodyMedium.copyWith(color: Colors.white24),
              border: InputBorder.none,
              contentPadding: EdgeInsets.symmetric(vertical: 18.h),
              suffixIcon: suffix,
            ),
            validator: validator,
          ),
        ),
      ],
    );
  }

  Widget _buildPrimaryButton(
      {required String text,
      required VoidCallback onPressed,
      bool isLoading = false}) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: AppColors.primaryGradient,
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
        ),
        child: isLoading
            ? SizedBox(
                width: 24.h,
                height: 24.h,
                child: const CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2),
              )
            : Text(
                text,
                style: AppTextStyles.buttonLarge
                    .copyWith(color: Colors.white, fontWeight: FontWeight.bold),
              ),
      ),
    );
  }

  Widget _buildSecondaryButton(
      {required String text, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(28.r),
        border: Border.all(color: Colors.white12),
      ),
      child: TextButton(
        onPressed: onPressed,
        child: Text(
          text,
          style: AppTextStyles.button
              .copyWith(color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }

  Widget _buildOAuthSection() {
    return Column(
      children: [
        Row(
          children: [
            const Expanded(child: Divider(color: Colors.white10)),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text('OR',
                  style:
                      AppTextStyles.bodySmall.copyWith(color: Colors.white38)),
            ),
            const Expanded(child: Divider(color: Colors.white10)),
          ],
        ),
        SizedBox(height: 32.h),
        _buildSocialButton(
          text: 'Continue with Google',
          icon: Image.asset(AppImages.googleIcon, width: 24.w),
          onTap: () {},
        ),
        SizedBox(height: 16.h),
        _buildSocialButton(
          text: 'Continue with Apple',
          icon: Icon(Icons.apple, color: Colors.white, size: 24.sp),
          onTap: () {},
        ),
      ],
    );
  }

  Widget _buildSocialButton(
      {required String text,
      required Widget icon,
      required VoidCallback onTap}) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.08),
          borderRadius: BorderRadius.circular(28.r),
          border: Border.all(color: Colors.white12),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            icon,
            SizedBox(width: 12.w),
            Text(
              text,
              style: AppTextStyles.labelMedium
                  .copyWith(color: Colors.white, letterSpacing: 0.5),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFloatingBubble(
      {required double top,
      double? left,
      double? right,
      required IconData icon,
      required Color color}) {
    return Positioned(
      top: top,
      left: left,
      right: right,
      child: Container(
        width: 50.w,
        height: 50.w,
        decoration: BoxDecoration(
          color: color.withOpacity(0.2),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              spreadRadius: 2,
            ),
          ],
        ),
        child: Icon(icon, color: Colors.white24, size: 24.sp),
      ),
    );
  }
}
