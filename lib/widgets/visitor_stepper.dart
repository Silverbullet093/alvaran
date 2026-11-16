import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class VisitorStepper extends StatelessWidget {
  final int count;
  final VoidCallback onDecrement;
  final VoidCallback onIncrement;

  const VisitorStepper({
    super.key,
    required this.count,
    required this.onDecrement,
    required this.onIncrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.borderSubtle, width: 1.2),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Decrement button [-]
          InkWell(
            onTap: count > 1 ? onDecrement : null,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF3EFE6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.remove_rounded,
                size: 20,
                color: count > 1 ? AppColors.textPrimary : AppColors.textMuted,
              ),
            ),
          ),

          // Count Text
          Text(
            count.toString(),
            style: AppTypography.displaySmall.copyWith(
              fontSize: 20,
              fontWeight: FontWeight.w800,
              color: AppColors.textPrimary,
            ),
          ),

          // Increment button [+]
          InkWell(
            onTap: count < 10 ? onIncrement : null,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: const Color(0xFFF3EFE6),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                Icons.add_rounded,
                size: 20,
                color: count < 10 ? AppColors.textPrimary : AppColors.textMuted,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
