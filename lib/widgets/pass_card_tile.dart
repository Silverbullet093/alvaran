import 'package:flutter/material.dart';
import '../models/pass_type.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/currency_formatter.dart';

class PassCardTile extends StatelessWidget {
  final PassType pass;
  final bool isSelected;
  final VoidCallback onSelect;

  const PassCardTile({
    super.key,
    required this.pass,
    required this.isSelected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final isRegular = pass.id == 'regular';

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Material(
        color: isSelected ? const Color(0xFFF4F8F4) : AppColors.white,
        borderRadius: BorderRadius.circular(16),
        elevation: 0,
        child: InkWell(
          onTap: onSelect,
          borderRadius: BorderRadius.circular(16),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isSelected ? AppColors.forestGreen : AppColors.borderSubtle,
                width: isSelected ? 1.8 : 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.forestGreen.withValues(alpha: 0.08)
                      : Colors.black.withValues(alpha: 0.02),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Row(
              children: [
                // Pass Icon Badge
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isRegular ? AppColors.softLavender : const Color(0xFFF3EEDF),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      isRegular ? Icons.confirmation_number_rounded : Icons.workspace_premium_rounded,
                      color: isRegular ? const Color(0xFF5D517A) : AppColors.gold,
                      size: 22,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Pass info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pass.name,
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 15,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        pass.description,
                        style: AppTypography.bodySmall.copyWith(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        CurrencyFormatter.format(pass.price),
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                ),

                // Custom Radio button
                Container(
                  width: 22,
                  height: 22,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: isSelected ? AppColors.forestGreen : AppColors.borderLight,
                      width: 2.0,
                    ),
                  ),
                  child: isSelected
                      ? Center(
                          child: Container(
                            width: 12,
                            height: 12,
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.forestGreen,
                            ),
                          ),
                        )
                      : null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
