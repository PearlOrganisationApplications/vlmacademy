import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/theme/app_colors.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final String? hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final int? maxLines;
  final int? maxLength;
  final bool enabled;
  final List<TextInputFormatter>? inputFormatters;
  final void Function(String)? onChanged;
  final bool darkMode;

  const CustomTextField({
    super.key,
    required this.label,
    this.hint,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.prefixIcon,
    this.suffixIcon,
    this.maxLines = 1,
    this.maxLength,
    this.enabled = true,
    this.inputFormatters,
    this.onChanged,
    this.darkMode = false,
  });

  @override
  Widget build(BuildContext context) {
    final labelColor =
        darkMode ? AppColors.textSecondaryDark : AppColors.textPrimaryLight;
    final inputColor =
        darkMode ? AppColors.textPrimaryDark : AppColors.textPrimaryLight;
    final hintColor =
        darkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;
    final iconColor =
        darkMode ? AppColors.textSecondaryDark : AppColors.textSecondaryLight;

    final enabledBorder = darkMode
        ? UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderDark, width: 1.0))
        : const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.borderLight, width: 1.0));
    final focusedBorder = darkMode
        ? UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1.5))
        : const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.primary, width: 1.5));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label.isNotEmpty)
          Text(
            label,
            style: TextStyle(
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
              color: labelColor,
            ),
          ),
        if (label.isNotEmpty) SizedBox(height: 8.h),
        TextFormField(
          controller: controller,
          validator: validator,
          keyboardType: keyboardType,
          obscureText: obscureText,
          maxLines: obscureText ? 1 : maxLines,
          maxLength: maxLength,
          enabled: enabled,
          inputFormatters: inputFormatters,
          onChanged: onChanged,
          style: TextStyle(color: inputColor, fontSize: 14.sp),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: hintColor, fontSize: 14.sp),
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, size: 18.sp, color: iconColor)
                : null,
            suffixIcon: suffixIcon,
            counterText: '',
            border: InputBorder.none, // Remove default border
            enabledBorder: enabledBorder,
            focusedBorder: focusedBorder,
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.error, width: 1.0),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: AppColors.error, width: 1.5),
            ),
            contentPadding:
                EdgeInsets.symmetric(vertical: 12.h, horizontal: 4.w),
          ),
        ),
      ],
    );
  }
}
