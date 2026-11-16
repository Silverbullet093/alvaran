import 'package:flutter/material.dart';
import '../models/review_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class ReviewItemTile extends StatelessWidget {
  final ReviewModel review;
  final VoidCallback onLike;

  const ReviewItemTile({
    super.key,
    required this.review,
    required this.onLike,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.borderSubtle, width: 1.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Author Header
          Row(
            children: [
              // Avatar
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: const Color(0xFFF0EAE1),
                  shape: BoxShape.circle,
                  border: Border.all(color: AppColors.borderLight, width: 1.0),
                ),
                child: Center(
                  child: Text(
                    review.authorName.isNotEmpty
                        ? review.authorName[0].toUpperCase()
                        : 'P',
                    style: AppTypography.titleMedium.copyWith(
                      color: AppColors.forestGreen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Name & Stars & Time
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      review.authorName,
                      style: AppTypography.titleMedium.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Row(
                      children: [
                        // Stars
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              Icons.star_rounded,
                              size: 13,
                              color: index < review.rating.round()
                                  ? AppColors.gold
                                  : AppColors.borderLight,
                            );
                          }),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          review.timeAgo,
                          style: AppTypography.bodySmall.copyWith(
                            fontSize: 11,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),

          // Comment
          Text(
            review.comment,
            style: AppTypography.bodyMedium.copyWith(
              fontSize: 13,
              height: 1.4,
              color: AppColors.textDark,
            ),
          ),
          const SizedBox(height: 8),

          // Like Thumbs Up row
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              InkWell(
                onTap: onLike,
                borderRadius: BorderRadius.circular(12),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: Row(
                    children: [
                      Icon(
                        review.isLikedByUser
                            ? Icons.thumb_up_rounded
                            : Icons.thumb_up_outlined,
                        size: 14,
                        color: review.isLikedByUser
                            ? AppColors.forestGreen
                            : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        review.likesCount.toString(),
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: review.isLikedByUser
                              ? AppColors.forestGreen
                              : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
