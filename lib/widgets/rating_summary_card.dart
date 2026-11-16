import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class RatingSummaryCard extends StatelessWidget {
  final double averageRating;
  final int totalReviews;
  final Map<int, double> distribution;

  const RatingSummaryCard({
    super.key,
    required this.averageRating,
    required this.totalReviews,
    required this.distribution,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.borderSubtle, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Left side: 4.8 + stars + review count
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                averageRating.toStringAsFixed(1),
                style: AppTypography.displayLarge.copyWith(
                  fontSize: 44,
                  fontWeight: FontWeight.w800,
                  color: AppColors.textPrimary,
                  height: 1.0,
                ),
              ),
              const SizedBox(height: 6),
              Row(
                children: List.generate(5, (index) {
                  return const Icon(
                    Icons.star_rounded,
                    color: AppColors.gold,
                    size: 18,
                  );
                }),
              ),
              const SizedBox(height: 4),
              Text(
                '(${(totalReviews / 1000).toStringAsFixed(1)}k ulasan)',
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(width: 28),

          // Right side: Progress bars 5 down to 1
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildStarRow(5, distribution[5] ?? 0.85),
                const SizedBox(height: 4),
                _buildStarRow(4, distribution[4] ?? 0.25),
                const SizedBox(height: 4),
                _buildStarRow(3, distribution[3] ?? 0.08),
                const SizedBox(height: 4),
                _buildStarRow(2, distribution[2] ?? 0.02),
                const SizedBox(height: 4),
                _buildStarRow(1, distribution[1] ?? 0.03),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStarRow(int starCount, double progress) {
    return Row(
      children: [
        SizedBox(
          width: 14,
          child: Text(
            starCount.toString(),
            style: const TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
        ),
        const Icon(
          Icons.star_rounded,
          color: AppColors.gold,
          size: 13,
        ),
        const SizedBox(width: 8),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              backgroundColor: const Color(0xFFF0EAE1),
              valueColor: const AlwaysStoppedAnimation<Color>(AppColors.forestGreen),
            ),
          ),
        ),
      ],
    );
  }
}
