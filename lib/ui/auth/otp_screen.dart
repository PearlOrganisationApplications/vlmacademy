import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/constants/app_images.dart';
import '../../core/routes/app_routes.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';
import '../shared/background_screen.dart';

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

  // Timer logic
  late Timer _timer;
  int _secondsRemaining = 120; // 2 minutes
  bool _canResend = false;

  @override
  void initState() {
    super.initState();
    _startTimer();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusNode.requestFocus();
    });
  }

  void _startTimer() {
    _canResend = false;
    _secondsRemaining = 120;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        setState(() {
          _canResend = true;
          timer.cancel();
        });
      } else {
        setState(() {
          _secondsRemaining--;
        });
      }
    });
  }

  String get _timerText {
    final minutes = (_secondsRemaining ~/ 60).toString().padLeft(2, '0');
    final seconds = (_secondsRemaining % 60).toString().padLeft(2, '0');
    return '$minutes:$seconds';
  }

  @override
  void dispose() {
    _timer.cancel();
    _otpController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _onVerify() async {
    if (_otpController.text.length != _otpLength) return;

    setState(() => _isVerifying = true);
    await Future.delayed(const Duration(seconds: 1));

    if (!mounted) return;
    setState(() => _isVerifying = false);

    Navigator.pushNamedAndRemoveUntil(
      context,
      AppRoutes.studentProfileSetup,
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BackgroundScreen(
      useSafeArea: false,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            children: [
              SizedBox(height: 20.h),
              // 1. Logo
              Center(
                child: Image.asset(
                  AppImages.vlmLogo,
                  width: 100.w,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 30.h),
              // 2. Illustration
              Center(
                child: Image.asset(
                  AppImages.otpVerification,
                  height: 180.h,
                  fit: BoxFit.contain,
                ),
              ),
              SizedBox(height: 30.h),
              // 3. Verification Msg
              Text(
                'Verification Code',
                style: AppTextStyles.h4.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Verification required for ${widget.contactInfo}',
                style: AppTextStyles.bodySmall.copyWith(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40.h),
              // 4. OTP Field (Glassmorphic)
              _buildOtpInput(),
              SizedBox(height: 40.h),
              // 5. Verify Button
              _buildVerifyButton(),
              SizedBox(height: 24.h),
              // 6. Msg with Time
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.access_time, color: Colors.white54, size: 16.sp),
                  SizedBox(width: 8.w),
                  Text(
                    _timerText,
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              // 7. Resend Msg
              GestureDetector(
                onTap: _canResend ? _startTimer : null,
                child: Text(
                  "Didn't receive code? Resend",
                  style: AppTextStyles.bodySmall.copyWith(
                    color: _canResend ? AppColors.primaryLight : Colors.white38,
                    fontWeight:
                        _canResend ? FontWeight.bold : FontWeight.normal,
                    decoration: _canResend ? TextDecoration.underline : null,
                  ),
                ),
              ),

              // Spacing for Sticky Footer feel
              SizedBox(height: 60.h),

              // 8. Bottom Security Note
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.verified_user_outlined,
                      color: Colors.white24, size: 16.sp),
                  SizedBox(width: 8.w),
                  Text(
                    'Security is our priority',
                    style: AppTextStyles.bodySmall.copyWith(
                      color: Colors.white24,
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20.h),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOtpInput() {
    return GestureDetector(
      onTap: () => _focusNode.requestFocus(),
      child: Stack(
        children: [
          // Invisible TextField
          Opacity(
            opacity: 0,
            child: SizedBox(
              width: 1,
              height: 1,
              child: TextField(
                controller: _otpController,
                focusNode: _focusNode,
                keyboardType: TextInputType.number,
                maxLength: _otpLength,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onChanged: (v) {
                  setState(() {});
                  if (v.length == _otpLength) _onVerify();
                },
              ),
            ),
          ),
          // Visual Slots
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(_otpLength, (index) {
              final isFocused = _otpController.text.length == index;
              final hasChar = _otpController.text.length > index;
              return Container(
                width: 60.w,
                height: 60.w,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(16.r),
                  border: Border.all(
                    color: isFocused ? AppColors.primary : Colors.white10,
                    width: isFocused ? 2.w : 1.w,
                  ),
                  boxShadow: isFocused
                      ? [
                          BoxShadow(
                            color: AppColors.primary.withOpacity(0.2),
                            blurRadius: 10,
                            spreadRadius: 2,
                          )
                        ]
                      : [],
                ),
                alignment: Alignment.center,
                child: Text(
                  hasChar ? _otpController.text[index] : '',
                  style: AppTextStyles.h4.copyWith(
                      color: Colors.white, fontWeight: FontWeight.bold),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }

  Widget _buildVerifyButton() {
    final bool isReady = _otpController.text.length == _otpLength;
    return Container(
      width: double.infinity,
      height: 56.h,
      decoration: BoxDecoration(
        gradient: isReady ? AppColors.primaryGradient : null,
        color: isReady ? null : Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(28.r),
        boxShadow: isReady
            ? [
                BoxShadow(
                  color: AppColors.primary.withOpacity(0.3),
                  blurRadius: 15,
                  spreadRadius: 2,
                  offset: const Offset(0, 4),
                )
              ]
            : [],
      ),
      child: ElevatedButton(
        onPressed: (isReady && !_isVerifying) ? _onVerify : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(28.r)),
        ),
        child: _isVerifying
            ? SizedBox(
                width: 24.h,
                height: 24.h,
                child: const CircularProgressIndicator(
                    color: Colors.white, strokeWidth: 2))
            : Text(
                'Verify',
                style: AppTextStyles.buttonLarge.copyWith(
                  color: isReady ? Colors.white : Colors.white38,
                  fontWeight: FontWeight.bold,
                ),
              ),
      ),
    );
  }
}
