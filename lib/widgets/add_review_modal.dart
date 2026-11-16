import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/review_service.dart';
import '../services/user_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'alvaran_buttons.dart';

class AddReviewModal extends StatefulWidget {
  const AddReviewModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const AddReviewModal(),
    );
  }

  @override
  State<AddReviewModal> createState() => _AddReviewModalState();
}

class _AddReviewModalState extends State<AddReviewModal> {
  final _nameController = TextEditingController();
  final _commentController = TextEditingController();
  double _selectedRating = 5.0;
  bool _isSubmitting = false;

  @override
  void initState() {
    super.initState();
    final user = context.read<UserService>().user;
    _nameController.text = user.fullName;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _commentController.dispose();
    super.dispose();
  }

  void _submitReview() {
    final comment = _commentController.text.trim();
    if (comment.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Silakan masukkan ulasan pengalaman Anda'),
          backgroundColor: AppColors.terracotta,
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    setState(() => _isSubmitting = true);

    Future.delayed(const Duration(milliseconds: 400), () {
      if (!mounted) return;
      final name = _nameController.text.trim().isEmpty
          ? 'Anonim'
          : _nameController.text.trim();

      context.read<ReviewService>().addReview(
            authorName: name,
            rating: _selectedRating,
            comment: comment,
          );

      context.read<UserService>().incrementReviewCount();

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Terima kasih! Ulasan Anda berhasil diterbitkan.'),
          backgroundColor: AppColors.forestGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
        decoration: const BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: SingleChildScrollView(
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
              const SizedBox(height: 18),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Tambah Ulasan',
                    style: AppTypography.headlineMedium.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded, size: 22),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              // Star rating selector
              Text(
                'Beri Rating Pengalaman Anda',
                style: AppTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  final starVal = index + 1.0;
                  return InkWell(
                    onTap: () {
                      setState(() {
                        _selectedRating = starVal;
                      });
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                      child: Icon(
                        Icons.star_rounded,
                        size: 36,
                        color: starVal <= _selectedRating
                            ? AppColors.gold
                            : AppColors.borderLight,
                      ),
                    ),
                  );
                }),
              ),
              Center(
                child: Text(
                  '${_selectedRating.toInt()} dari 5 Bintang',
                  style: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    color: AppColors.gold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Name field
              Text(
                'Nama Lengkap',
                style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Nama Anda...',
                  prefixIcon: Icon(Icons.person_outline_rounded, size: 20),
                ),
              ),
              const SizedBox(height: 14),

              // Comment field
              Text(
                'Ulasan Anda',
                style: AppTypography.titleSmall.copyWith(fontWeight: FontWeight.w600),
              ),
              const SizedBox(height: 6),
              TextField(
                controller: _commentController,
                maxLines: 4,
                decoration: const InputDecoration(
                  hintText: 'Ceritakan keseruan bermain board game di Alvaran...',
                ),
              ),
              const SizedBox(height: 24),

              // Submit button
              AlvaranPrimaryButton(
                label: 'Kirim Ulasan',
                isLoading: _isSubmitting,
                onPressed: _submitReview,
              ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }
}
