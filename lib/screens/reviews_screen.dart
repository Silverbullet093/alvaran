import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/review_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/alvaran_app_bar.dart';
import '../widgets/rating_summary_card.dart';
import '../widgets/review_item_tile.dart';
import '../widgets/add_review_modal.dart';
import '../widgets/alvaran_buttons.dart';

class ReviewsScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final bool showBackButton;

  const ReviewsScreen({
    super.key,
    this.onBack,
    this.showBackButton = true,
  });

  void _showSortSheet(BuildContext context) {
    final reviewService = context.read<ReviewService>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Urutkan Ulasan',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 12),
            ...ReviewSortOption.values.map((opt) {
              final isSelected = reviewService.currentSort == opt;
              return ListTile(
                title: Text(
                  opt.label,
                  style: TextStyle(
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                    color: isSelected ? AppColors.forestGreen : AppColors.textPrimary,
                  ),
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle_rounded, color: AppColors.forestGreen)
                    : null,
                onTap: () {
                  reviewService.setSortOption(opt);
                  Navigator.pop(ctx);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  void _showRatingFilterSheet(BuildContext context) {
    final reviewService = context.read<ReviewService>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (ctx) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        decoration: const BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Filter Berdasarkan Bintang',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 12),
            ListTile(
              title: const Text('Semua Rating'),
              trailing: reviewService.currentRatingFilter == null
                  ? const Icon(Icons.check_circle_rounded, color: AppColors.forestGreen)
                  : null,
              onTap: () {
                reviewService.setRatingFilter(null);
                Navigator.pop(ctx);
              },
            ),
            ...[5, 4, 3, 2, 1].map((stars) {
              final isSelected = reviewService.currentRatingFilter == stars;
              return ListTile(
                title: Row(
                  children: [
                    Text('$stars Bintang  '),
                    Row(
                      children: List.generate(
                        stars,
                        (_) => const Icon(Icons.star_rounded, size: 16, color: AppColors.gold),
                      ),
                    ),
                  ],
                ),
                trailing: isSelected
                    ? const Icon(Icons.check_circle_rounded, color: AppColors.forestGreen)
                    : null,
                onTap: () {
                  reviewService.setRatingFilter(stars);
                  Navigator.pop(ctx);
                },
              );
            }),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final reviewService = context.watch<ReviewService>();
    final reviews = reviewService.reviews;

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AlvaranSubAppBar(
        title: 'Reviews',
        showBackButton: showBackButton,
        onBack: onBack,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Summary Rating Card
                    RatingSummaryCard(
                      averageRating: reviewService.averageRating,
                      totalReviews: reviewService.totalReviewsCount,
                      distribution: reviewService.starDistribution,
                    ),

                    // Filter Chips: Terbaru v | Rating v
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      child: Row(
                        children: [
                          _buildFilterChip(
                            label: reviewService.currentSort.label,
                            onTap: () => _showSortSheet(context),
                          ),
                          const SizedBox(width: 10),
                          _buildFilterChip(
                            label: reviewService.currentRatingFilter != null
                                ? '${reviewService.currentRatingFilter}★'
                                : 'Rating',
                            onTap: () => _showRatingFilterSheet(context),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 6),

                    // Reviews List
                    if (reviews.isEmpty)
                      Padding(
                        padding: const EdgeInsets.all(40),
                        child: Center(
                          child: Column(
                            children: [
                              const Icon(Icons.rate_review_outlined, size: 48, color: AppColors.textMuted),
                              const SizedBox(height: 12),
                              Text(
                                'Belum ada ulasan untuk filter ini.',
                                style: AppTypography.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ...reviews.map((rev) {
                        return ReviewItemTile(
                          review: rev,
                          onLike: () => reviewService.toggleLike(rev.id),
                        );
                      }),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom CTA Button: Tambah Ulasan
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: AlvaranPrimaryButton(
                  label: 'Tambah Ulasan ✎',
                  onPressed: () => AddReviewModal.show(context),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: AppColors.borderSubtle, width: 1.2),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              label,
              style: AppTypography.bodySmall.copyWith(
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 6),
            const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 16,
              color: AppColors.textSecondary,
            ),
          ],
        ),
      ),
    );
  }
}
