import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../core/theme/app_colors.dart';
import '../../core/theme/app_text_styles.dart';

enum AnimatedButtonType { primary, secondary, outline, text, gradient }

enum AnimatedButtonSize { small, medium, large }

class AnimatedButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final AnimatedButtonType type;
  final AnimatedButtonSize size;
  final bool isLoading;
  final IconData? icon;
  final IconData? suffixIcon;
  final bool fullWidth;
  final Gradient? gradient;
  final Color? customColor;

  const AnimatedButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = AnimatedButtonType.primary,
    this.size = AnimatedButtonSize.medium,
    this.isLoading = false,
    this.icon,
    this.suffixIcon,
    this.fullWidth = false,
    this.gradient,
    this.customColor,
  });

  @override
  State<AnimatedButton> createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(TapDownDetails details) {
    if (widget.onPressed != null && !widget.isLoading) {
      setState(() => _isPressed = true);
      _controller.forward();
      HapticFeedback.lightImpact();
    }
  }

  void _handleTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  void _handleTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final padding = _getPadding();
    final textStyle = _getTextStyle();

    Widget child = widget.isLoading
        ? SizedBox(
            height: 20,
            width: 20,
            child: CircularProgressIndicator(
              strokeWidth: 2.5,
              valueColor: AlwaysStoppedAnimation<Color>(
                widget.type == AnimatedButtonType.outline ||
                        widget.type == AnimatedButtonType.text
                    ? AppColors.primary
                    : Colors.white,
              ),
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon, size: 20),
                const SizedBox(width: 8),
              ],
              Flexible(
                child: Text(
                  widget.text,
                  style: textStyle,
                  textAlign: TextAlign.center,
                ),
              ),
              if (widget.suffixIcon != null) ...[
                const SizedBox(width: 8),
                Icon(widget.suffixIcon, size: 20),
              ],
            ],
          );

    if (widget.fullWidth) {
      child = SizedBox(width: double.infinity, child: Center(child: child));
    }

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      onTap: widget.onPressed,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: padding,
          decoration: _getDecoration(),
          child: child,
        ),
      ),
    );
  }

  BoxDecoration _getDecoration() {
    switch (widget.type) {
      case AnimatedButtonType.primary:
        return BoxDecoration(
          color: widget.customColor ?? AppColors.primary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: (widget.customColor ?? AppColors.primary)
                        .withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
        );

      case AnimatedButtonType.secondary:
        return BoxDecoration(
          color: AppColors.secondary,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: AppColors.secondary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
        );

      case AnimatedButtonType.outline:
        return BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: widget.customColor ?? AppColors.primary,
            width: 2,
          ),
        );

      case AnimatedButtonType.text:
        return const BoxDecoration();

      case AnimatedButtonType.gradient:
        return BoxDecoration(
          gradient: widget.gradient ?? AppColors.primaryGradient,
          borderRadius: BorderRadius.circular(12),
          boxShadow: _isPressed
              ? []
              : [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 6),
                  ),
                ],
        );
    }
  }

  EdgeInsets _getPadding() {
    switch (widget.size) {
      case AnimatedButtonSize.small:
        return const EdgeInsets.symmetric(horizontal: 16, vertical: 8);
      case AnimatedButtonSize.medium:
        return const EdgeInsets.symmetric(horizontal: 24, vertical: 14);
      case AnimatedButtonSize.large:
        return const EdgeInsets.symmetric(horizontal: 32, vertical: 18);
    }
  }

  TextStyle _getTextStyle() {
    final baseStyle = widget.size == AnimatedButtonSize.small
        ? AppTextStyles.buttonSmall
        : widget.size == AnimatedButtonSize.large
            ? AppTextStyles.buttonLarge
            : AppTextStyles.button;

    final color = widget.type == AnimatedButtonType.outline ||
            widget.type == AnimatedButtonType.text
        ? (widget.customColor ?? AppColors.primary)
        : Colors.white;

    return baseStyle.copyWith(color: color);
  }
}
