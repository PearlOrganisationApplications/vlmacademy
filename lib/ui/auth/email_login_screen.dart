import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_images.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/custom_text_field.dart';

class EmailLoginScreen extends StatefulWidget {
  const EmailLoginScreen({super.key});

  @override
  State<EmailLoginScreen> createState() => _EmailLoginScreenState();
}

class _EmailLoginScreenState extends State<EmailLoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;
  bool _rememberMe = false;
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _onSignIn() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    // TODO: Implement actual sign-in logic
    Navigator.pushReplacementNamed(context, AppRoutes.studentDashboard);
  }

  void _onForgotPassword() {
    // TODO: Navigate to forgot password screen
  }

  void _onGoogleSignIn() {
    // TODO: Implement Google sign-in
  }

  void _onAppleSignIn() {
    // TODO: Implement Apple sign-in
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

                      SizedBox(height: 20.h),

                      // ── Logo ─────────────────────────────────────────────
                      Center(child: _VlmLogo()),

                      SizedBox(height: 32.h),

                      // ── Headline ─────────────────────────────────────────
                      Text(
                        "Let's Sign In.!",
                        style: AppTextStyles.h3.copyWith(
                          color: AppColors.textPrimaryDark,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 6.h),
                      Text(
                        'Login to Your Account to Continue your learning',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: AppColors.textSecondaryDark,
                        ),
                      ),

                      SizedBox(height: 32.h),

                      // ── Form ─────────────────────────────────────────────
                      Form(
                        key: _formKey,
                        child: Column(
                          children: [
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

                      SizedBox(height: 16.h),

                      // ── Remember Me + Forgot Password ────────────────────
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Remember Me checkbox
                          GestureDetector(
                            onTap: () =>
                                setState(() => _rememberMe = !_rememberMe),
                            child: Row(
                              children: [
                                SizedBox(
                                  width: 20.w,
                                  height: 20.h,
                                  child: Checkbox(
                                    value: _rememberMe,
                                    onChanged: (v) => setState(
                                        () => _rememberMe = v ?? false),
                                    activeColor: AppColors.primary,
                                    side: BorderSide(
                                      color: AppColors.borderDark,
                                      width: 1.5,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(4.r),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  'Remember Me',
                                  style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondaryDark,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Forgot Password
                          GestureDetector(
                            onTap: _onForgotPassword,
                            child: Text(
                              'Forgot Password?',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondaryDark,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 32.h),

                      // ── Sign In Button ────────────────────────────────────
                      _SignInButton(
                        isLoading: _isLoading,
                        onPressed: _onSignIn,
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

                      const Spacer(),

                      // ── Sign Up Link ──────────────────────────────────────
                      Center(
                        child: Padding(
                          padding: EdgeInsets.only(bottom: 32.h),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'Already have on Account? ',
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

// ─── VLM Logo ─────────────────────────────────────────────────────────────────

class _VlmLogo extends StatelessWidget {
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

// ─── Sign In Button ───────────────────────────────────────────────────────────

class _SignInButton extends StatelessWidget {
  const _SignInButton({
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
                      'Sign in',
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
