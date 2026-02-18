import 'package:flutter/material.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

class CustomBottomSheet {
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isDismissible = true,
    bool enableDrag = true,
    double? height,
    Color? backgroundColor,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      isDismissible: isDismissible,
      enableDrag: enableDrag,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _BottomSheetContent(
        title: title,
        height: height,
        backgroundColor: backgroundColor,
        child: child,
      ),
    );
  }
}

class _BottomSheetContent extends StatelessWidget {
  final String? title;
  final Widget child;
  final double? height;
  final Color? backgroundColor;

  const _BottomSheetContent({
    this.title,
    required this.child,
    this.height,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final screenHeight = MediaQuery.of(context).size.height;

    return Container(
      height: height ?? screenHeight * 0.7,
      decoration: BoxDecoration(
        color: backgroundColor ??
            (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowHeavy,
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Drag Handle
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 8),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: isDark
                  ? AppColors.borderDark
                  : AppColors.borderLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Title
          if (title != null) ...[
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 8, 20, 16),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      title!,
                      style: AppTextStyles.h5,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),
            Divider(
              height: 1,
              color: isDark ? AppColors.dividerDark : AppColors.dividerLight,
            ),
          ],
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}

// Preset Bottom Sheets
class BottomSheetPresets {
  static Future<T?> showOptions<T>({
    required BuildContext context,
    required String title,
    required List<BottomSheetOption<T>> options,
  }) {
    return CustomBottomSheet.show<T>(
      context: context,
      title: title,
      height: null,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: options.map((option) {
          return ListTile(
            leading: option.icon != null
                ? Icon(option.icon, color: option.color ?? AppColors.primary)
                : null,
            title: Text(
              option.title,
              style: AppTextStyles.labelMedium.copyWith(
                color: option.color,
              ),
            ),
            subtitle: option.subtitle != null
                ? Text(option.subtitle!, style: AppTextStyles.caption)
                : null,
            onTap: () => Navigator.pop(context, option.value),
          );
        }).toList(),
      ),
    );
  }
}

class BottomSheetOption<T> {
  final String title;
  final String? subtitle;
  final IconData? icon;
  final Color? color;
  final T value;

  BottomSheetOption({
    required this.title,
    this.subtitle,
    this.icon,
    this.color,
    required this.value,
  });
}
