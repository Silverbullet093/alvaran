import 'package:flutter/material.dart';
import '../models/pass_type.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/currency_formatter.dart';

class PassCardTile extends StatelessWidget {
  final PassType pass;
  final bool isSelected;
  final bool isWeekend;
  final VoidCallback onSelect;

  const PassCardTile({
    super.key,
    required this.pass,
    required this.isSelected,
    this.isWeekend = false,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    final isHourly = pass.isHourly;
    final activePrice = pass.getPrice(isWeekend);

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
                // Pass Icon Badge (Sun for All Day, Clock for Hourly)
                Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: isHourly
                        ? const Color(0xFFD6F0EA) // Soft mint for clock
                        : const Color(0xFFFDF0D5), // Soft gold for sun
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Center(
                    child: Icon(
                      isHourly ? Icons.access_time_filled_rounded : Icons.wb_sunny_rounded,
                      color: isHourly ? const Color(0xFF1E6C57) : const Color(0xFFB87814),
                      size: 24,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Pass info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              pass.name,
                              style: AppTypography.titleMedium.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 15,
                                color: AppColors.textPrimary,
                              ),
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                            decoration: BoxDecoration(
                              color: isWeekend
                                  ? AppColors.occupiedRedLight
                                  : AppColors.availableGreenLight,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              isWeekend ? 'Weekend' : 'Weekday',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w700,
                                color: isWeekend
                                    ? AppColors.terracotta
                                    : AppColors.availableGreen,
                              ),
                            ),
                          ),
                        ],
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
                      Row(
                        children: [
                          Text(
                            CurrencyFormatter.format(activePrice),
                            style: AppTypography.titleMedium.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 15,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          Text(
                            isHourly ? ' / jam / orang' : ' / All Day / orang',
                            style: AppTypography.bodySmall.copyWith(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
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
