import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import '../../core/theme/app_colors.dart';

class ShimmerLoading extends StatelessWidget {
  final double width;
  final double height;
  final double borderRadius;
  final ShimmerType type;

  const ShimmerLoading({
    super.key,
    this.width = double.infinity,
    this.height = 100,
    this.borderRadius = 12,
    this.type = ShimmerType.rectangle,
  });

  const ShimmerLoading.circular({
    super.key,
    this.width = 50,
    this.height = 50,
  })  : borderRadius = 25,
        type = ShimmerType.circular;

  const ShimmerLoading.text({
    super.key,
    this.width = double.infinity,
    this.height = 16,
  })  : borderRadius = 4,
        type = ShimmerType.text;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Shimmer.fromColors(
      baseColor: isDark ? AppColors.surfaceDarkElevated : AppColors.shimmerBase,
      highlightColor:
          isDark ? AppColors.borderDark : AppColors.shimmerHighlight,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: type == ShimmerType.circular
              ? BorderRadius.circular(width / 2)
              : BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

enum ShimmerType { rectangle, circular, text }

// Shimmer Skeleton Widgets
class ShimmerCard extends StatelessWidget {
  const ShimmerCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: const Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              const ShimmerLoading.circular(width: 50, height: 50),
              const SizedBox(width: 12),
              const Expanded(
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    ShimmerLoading.text(width: 150, height: 16),
                    SizedBox(height: 8),
                    ShimmerLoading.text(width: 100, height: 14),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          const ShimmerLoading(height: 120),
          const SizedBox(height: 12),
          const ShimmerLoading.text(height: 14),
          const SizedBox(height: 8),
          const ShimmerLoading.text(width: 200, height: 14),
        ],
      ),
    );
  }
}

class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: const Row(
        children: [
          const ShimmerLoading.circular(width: 60, height: 60),
          const SizedBox(width: 16),
          const Expanded(
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                ShimmerLoading.text(width: double.infinity, height: 16),
                SizedBox(height: 8),
                ShimmerLoading.text(width: 150, height: 14),
                SizedBox(height: 8),
                ShimmerLoading.text(width: 100, height: 12),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
