import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class PromoBannerCard extends StatelessWidget {
  final bool isApplied;
  final VoidCallback onToggle;

  const PromoBannerCard({
    super.key,
    required this.isApplied,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isApplied
              ? [
                  const Color(0xFFFFE082),
                  const Color(0xFFFFD54F),
                ]
              : [
                  const Color(0xFFFFF7DD),
                  const Color(0xFFFEEDBA),
                ],
        ),
        border: Border.all(
          color: isApplied ? AppColors.gold : const Color(0xFFF0DF9B),
          width: isApplied ? 1.5 : 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.gold.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onToggle,
          borderRadius: BorderRadius.circular(16),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                // Ticket coupon icon
                Container(
                  width: 38,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.terracotta,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Center(
                    child: Icon(
                      Icons.local_offer_rounded,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
                const SizedBox(width: 14),

                // Text
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Promo Spesial!',
                        style: AppTypography.titleMedium.copyWith(
                          fontWeight: FontWeight.w800,
                          fontSize: 14,
                          color: const Color(0xFF7A5400),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Diskon 20% untuk member',
                        style: AppTypography.bodySmall.copyWith(
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF8A6614),
                        ),
                      ),
                    ],
                  ),
                ),

                // Applied pill / Switch
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: isApplied ? AppColors.forestGreen : AppColors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 4,
                      ),
                    ],
                  ),
                  child: Text(
                    isApplied ? 'Terapkan ✓' : 'Gunakan',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: isApplied ? AppColors.white : const Color(0xFF7A5400),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
