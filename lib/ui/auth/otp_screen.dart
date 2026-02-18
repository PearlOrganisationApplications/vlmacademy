import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../widgets/custom_button.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key, this.contactInfo = '+91 9876543210'});

  final String contactInfo;

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final TextEditingController _otpController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  final int _otpLength = 4;
  bool _isVerifying = false;

  @override
  void initState() {
    super.initState();
    // Auto-focus on entry
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  @override
  void dispose() {
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _onVerify() async {
    if (_otpController.text.length != _otpLength) return;

    setState(() => _isVerifying = true);

    // Mocking API call for OTP verification
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isVerifying = false);

    // Navigate to dashboard and clear the stack to prevent going back to login
    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.studentDashboard,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      body: SafeArea(
        child: Stack(
          children: [
            // Hidden TextField to capture system keyboard input
            Opacity(
              opacity: 0,
              child: SizedBox(
                height: 1,
                width: 1,
                child: TextField(
                  controller: _otpController,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  maxLength: _otpLength,
                  onChanged: (value) {
                    setState(() {});
                    if (value.length == _otpLength) {
                      _onVerify();
                    }
                  },
                ),
              ),
            ),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 20.h),
                  // Header
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 26.sp,
                        ),
                      ),
                      SizedBox(width: 24.w),
                      Text(
                        'Verification Code',
                        style: AppTextStyles.h4.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),

                  const Spacer(flex: 1),

                  // Subtitle
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 32.w),
                      child: Text(
                        'Please check your email  to see the verification code',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondaryDark,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 48.h),

                  // OTP Slots (Tapping here opens keyboard)
                  GestureDetector(
                    onTap: () => _focusNode.requestFocus(),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(_otpLength, (index) {
                        String otp = _otpController.text;
                        bool isFocused = otp.length == index;
                        bool isFilled = otp.length > index;
                        String char = isFilled ? otp[index] : "";

                        return Container(
                          width: 64.w,
                          height: 64.h,
                          margin: EdgeInsets.symmetric(horizontal: 8.w),
                          decoration: BoxDecoration(
                            color: AppColors.surfaceDark,
                            borderRadius: BorderRadius.circular(12.r),
                            border: isFocused
                                ? Border.all(
                                    color: Colors.white.withValues(alpha: 0.5),
                                    width: 1.5,
                                  )
                                : null,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            isFilled
                                ? (index < otp.length - 1 ? '*' : char)
                                : "",
                            style: AppTextStyles.h4.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        );
                      }),
                    ),
                  ),

                  SizedBox(height: 48.h),

                  // Continue Button
                  CustomButton(
                    text: 'Continue',
                    onPressed: _otpController.text.length == _otpLength &&
                            !_isVerifying
                        ? _onVerify
                        : null,
                    isLoading: _isVerifying,
                    type: ButtonType.gradient,
                    size: ButtonSize.large,
                    fullWidth: true,
                    showTrailingArrow: true,
                  ),

                  const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
