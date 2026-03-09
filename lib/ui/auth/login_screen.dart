import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_images.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_field.dart';

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
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  _Role _selectedRole = _Role.student;
  bool _isLoading = false;
  bool _obscurePassword = true;
  bool _rememberMe = false;

  @override
  void dispose() {
    _phoneController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
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

  Future<void> _onSignIn() async {
    if (_selectedRole == _Role.teacher) {
      if (!_formKey.currentState!.validate()) return;
    }
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 1));
    if (!mounted) return;
    setState(() => _isLoading = false);
    // TODO: Implement actual sign-in logic
    Navigator.pushReplacementNamed(context, AppRoutes.studentDashboard);
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    final isTeacher = _selectedRole == _Role.teacher;

    return Scaffold(
      backgroundColor: isTeacher ? AppColors.backgroundDark : null,
      body: Container(
        decoration: isTeacher
            ? null
            : const BoxDecoration(
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
                        if (isTeacher) ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Let's Sign In.!",
                              style: AppTextStyles.h3.copyWith(
                                color: AppColors.textPrimaryDark,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Login to Your Account to Continue your teaching',
                              style: AppTextStyles.bodySmall.copyWith(
                                color: AppColors.textSecondaryDark,
                              ),
                            ),
                          ),
                        ] else
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

                        if (!isTeacher) ...[
                          // Phone input + Send OTP
                          _PhoneRow(
                            controller: _phoneController,
                            isLoading: _isLoading,
                            onSend: _onSendOtp,
                          ),
                        ] else ...[
                          // Email/Password Form
                          Form(
                            key: _formKey,
                            child: Column(
                              children: [
                                // Email Field
                                Column(
                                  children: [
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
                                        return null;
                                      },
                                    ),
                                    const Divider(
                                        color: AppColors.dividerDark,
                                        thickness: 1.2),
                                  ],
                                ),
                                SizedBox(height: 16.h),
                                // Password Field
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    CustomTextField(
                                      label: '',
                                      hint: 'Password',
                                      controller: _passwordController,
                                      prefixIcon: Icons.lock_outline,
                                      obscureText: _obscurePassword,
                                      maxLength: 20,
                                      darkMode: true,
                                      suffixIcon: GestureDetector(
                                        onTap: () => setState(() =>
                                            _obscurePassword =
                                                !_obscurePassword),
                                        child: Icon(
                                          _obscurePassword
                                              ? Icons.visibility_off_outlined
                                              : Icons.visibility_outlined,
                                          size: 18.sp,
                                          color: AppColors.textSecondaryDark,
                                        ),
                                      ),
                                      onChanged: (v) => setState(() {}),
                                      validator: (v) {
                                        if (v == null || v.isEmpty) {
                                          return 'Please enter your password';
                                        }
                                        return null;
                                      },
                                    ),
                                    const Divider(
                                        color: AppColors.dividerDark,
                                        thickness: 1.2),
                                    Text(
                                      '${_passwordController.text.length} / 20',
                                      style: AppTextStyles.bodySmall.copyWith(
                                        color: AppColors.textSecondaryDark,
                                        fontSize: 10.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
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
                                        side: const BorderSide(
                                            color: AppColors.borderDark,
                                            width: 1.5),
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(4.r)),
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      'Remember Me',
                                      style: AppTextStyles.bodySmall.copyWith(
                                          color: AppColors.textSecondaryDark),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                'Forgot Password?',
                                style: AppTextStyles.bodySmall.copyWith(
                                    color: AppColors.textSecondaryDark),
                              ),
                            ],
                          ),
                          SizedBox(height: 32.h),
                          _SignInButton(
                            isLoading: _isLoading,
                            onPressed: _onSignIn,
                          ),
                        ],

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

                        if (!isTeacher) ...[
                          // Google Sign-In — glassmorphic
                          CustomButton(
                            text: 'Sign in with Google',
                            onPressed: _onGoogleSignIn,
                            type: ButtonType.glassmorphic,
                            size: ButtonSize.large,
                            imageIcon: AppImages.googleIcon,
                            fullWidth: true,
                          ),
                        ] else ...[
                          // Social Buttons for Teacher (Circles)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _SocialButton(
                                onTap: _onGoogleSignIn,
                                child: Image.asset(AppImages.googleIcon,
                                    width: 24.w, height: 24.h),
                              ),
                              SizedBox(width: 20.w),
                              _SocialButton(
                                onTap: () {},
                                child: Icon(Icons.apple,
                                    size: 26.sp, color: Colors.white),
                              ),
                            ],
                          ),
                        ],

                        SizedBox(height: 16.h),

                        const Spacer(),

                        // Sign Up link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              isTeacher
                                  ? "Already have an Account? "
                                  : "Don't have an Account? ",
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
          fit: BoxFit.contain,
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
          color: const Color(0xFF8B5CF6), // Purple color from Image 1
          borderRadius: BorderRadius.circular(32.r),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF8B5CF6).withOpacity(0.4),
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
                      'Sign In',
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
          color: const Color(0xFF1E293B),
          shape: BoxShape.circle,
          border: Border.all(
            color: Colors.white.withOpacity(0.1),
            width: 1,
          ),
        ),
        child: Center(child: child),
      ),
    );
  }
}
