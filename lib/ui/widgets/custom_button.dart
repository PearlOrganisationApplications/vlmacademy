import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

enum ButtonType { primary, secondary, outline, text, gradient }

enum ButtonSize { small, medium, large }

/// A unified button widget used across the entire app.
///
/// Supports solid, outlined, text, and gradient styles.
/// Use [ButtonType.gradient] with an optional [gradient] to render
/// a gradient button (e.g. the social sign-in buttons on the login screen).
/// Pass [showTrailingArrow] to show a circular arrow badge on the right.
class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final ButtonSize size;
  final bool isLoading;
  final IconData? icon;
  final bool fullWidth;

  // Gradient and icon options
  final LinearGradient? gradient;
  final bool showTrailingArrow;
  final String? imageIcon;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.size = ButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.fullWidth = false,
    this.gradient,
    this.showTrailingArrow = false,
    this.imageIcon,
  });

  // ─── Gradient button ────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    if (type == ButtonType.gradient) {
      return _GradientButton(
        text: text,
        onPressed: isLoading ? null : onPressed,
        isLoading: isLoading,
        icon: icon,
        imageIcon: imageIcon,
        gradient: gradient ?? AppColors.primaryGradient,
        showTrailingArrow: showTrailingArrow,
        height: _buttonHeight,
        textStyle: _getTextStyle(),
        fullWidth: fullWidth,
      );
    }

    // ─── Standard Flutter buttons ──────────────────────────────────────────

    final buttonStyle = _getButtonStyle();
    final padding = _getPadding();
    final textStyle = _getTextStyle();

    Widget child = isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                type == ButtonType.outline || type == ButtonType.text
                    ? AppColors.primary
                    : Colors.white,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (imageIcon != null) ...[
                Image.asset(imageIcon!, width: 22.sp, height: 22.sp),
                SizedBox(width: 8.w),
              ] else if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: 8),
              ],
              Text(text, style: textStyle),
            ],
          );

    if (fullWidth) child = Center(child: child);

    switch (type) {
      case ButtonType.primary:
      case ButtonType.secondary:
        return SizedBox(
          width: fullWidth ? double.infinity : null,
          height: _buttonHeight,
          child: ElevatedButton(
            onPressed: isLoading ? null : onPressed,
            style: buttonStyle,
            child: Padding(padding: padding, child: child),
          ),
        );
      case ButtonType.outline:
        return SizedBox(
          width: fullWidth ? double.infinity : null,
          height: _buttonHeight,
          child: OutlinedButton(
            onPressed: isLoading ? null : onPressed,
            style: buttonStyle,
            child: Padding(padding: padding, child: child),
          ),
        );
      case ButtonType.text:
        return TextButton(
          onPressed: isLoading ? null : onPressed,
          style: buttonStyle,
          child: Padding(padding: padding, child: child),
        );
      case ButtonType.gradient:
        return const SizedBox.shrink(); // handled above
    }
  }

  double get _buttonHeight {
    switch (size) {
      case ButtonSize.small:
        return 40.h;
      case ButtonSize.medium:
        return 52.h;
      case ButtonSize.large:
        return 60.h;
    }
  }

  ButtonStyle _getButtonStyle() {
    final radius = BorderRadius.circular(14.r);
    switch (type) {
      case ButtonType.primary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: radius),
          elevation: 0,
        );
      case ButtonType.secondary:
        return ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(borderRadius: radius),
          elevation: 0,
        );
      case ButtonType.outline:
        return OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: radius),
        );
      case ButtonType.text:
        return TextButton.styleFrom(foregroundColor: AppColors.primary);
      case ButtonType.gradient:
        return ElevatedButton.styleFrom(); // unused
    }
  }

  EdgeInsets _getPadding() {
    switch (size) {
      case ButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case ButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 12);
      case ButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 16);
    }
  }

  TextStyle _getTextStyle() {
    switch (size) {
      case ButtonSize.small:
        return AppTextStyles.buttonSmall;
      case ButtonSize.medium:
      case ButtonSize.large:
        return AppTextStyles.button;
    }
  }
}

// ─── Gradient Button (internal) ───────────────────────────────────────────────

class _GradientButton extends StatelessWidget {
  const _GradientButton({
    required this.text,
    required this.gradient,
    required this.textStyle,
    required this.height,
    this.onPressed,
    this.isLoading = false,
    this.icon,
    this.imageIcon,
    this.showTrailingArrow = false,
    this.fullWidth = false,
  });

  final String text;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final String? imageIcon;
  final LinearGradient gradient;
  final bool showTrailingArrow;
  final bool fullWidth;
  final double height;
  final TextStyle textStyle;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: fullWidth ? double.infinity : null,
        height: height,
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(16.r),
        ),
        child: isLoading
            ? const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: Colors.white,
                  ),
                ),
              )
            : Row(
                mainAxisSize: fullWidth ? MainAxisSize.max : MainAxisSize.min,
                children: [
                  SizedBox(width: 12.w),
                  if (imageIcon != null) ...[
                    Image.asset(imageIcon!, width: 22.sp, height: 22.sp),
                    if (!fullWidth) SizedBox(width: 8.w),
                  ] else if (icon != null) ...[
                    Icon(icon, size: 22.sp, color: Colors.white),
                    if (!fullWidth) SizedBox(width: 8.w),
                  ],
                  if (fullWidth)
                    Expanded(
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: textStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  else
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 12.w),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        style: textStyle.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  if (showTrailingArrow) ...[
                    if (!fullWidth) SizedBox(width: 8.w),
                    Container(
                      width: 34.w,
                      height: 34.w,
                      margin: EdgeInsets.only(right: 12.w),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        size: 16.sp,
                        color: AppColors.primary,
                      ),
                    ),
                  ],
                ],
              ),
      ),
    );
  }
}
