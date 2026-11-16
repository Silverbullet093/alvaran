import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class PriceListModal extends StatelessWidget {
  const PriceListModal({super.key});

  static Future<void> show(BuildContext context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (ctx) => const PriceListModal(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
      decoration: const BoxDecoration(
        color: AppColors.cream,
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Handle bar
            Container(
              width: 44,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.borderLight,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            const SizedBox(height: 18),

            // Header with mascot & title
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: const BoxDecoration(
                    color: Color(0xFF1E3A34),
                    shape: BoxShape.circle,
                  ),
                  child: const Center(
                    child: Text('🤖', style: TextStyle(fontSize: 18)),
                  ),
                ),
                const SizedBox(width: 10),
                Text(
                  'PRICE LIST ALVARAN',
                  style: AppTypography.displaySmall.copyWith(
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                    color: AppColors.forestGreen,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Text(
              'Tarif Resmi Bermain Board Game Cafe',
              style: AppTypography.bodySmall.copyWith(
                color: AppColors.textSecondary,
                fontSize: 12,
              ),
            ),
            const SizedBox(height: 20),

            // Card 1: SENIN - JUMAT
            _buildPriceSection(
              title: 'SENIN – JUMAT',
              headerBgColor: const Color(0xFF2C6B56),
              cardBorderColor: const Color(0xFF82B8A5),
              items: [
                _PriceItemData(
                  icon: Icons.access_time_filled_rounded,
                  iconBg: const Color(0xFFB5EAD7),
                  iconColor: const Color(0xFF1E6C57),
                  priceBold: '10rb',
                  rateUnit: ' / jam / orang',
                ),
                _PriceItemData(
                  icon: Icons.wb_sunny_rounded,
                  iconBg: const Color(0xFFFFE5A3),
                  iconColor: const Color(0xFFB87814),
                  priceBold: '40rb',
                  rateUnit: ' / All Day / orang',
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Card 2: SABTU - MINGGU
            _buildPriceSection(
              title: 'SABTU – MINGGU',
              headerBgColor: const Color(0xFFD4623C),
              cardBorderColor: const Color(0xFFF1A88D),
              items: [
                _PriceItemData(
                  icon: Icons.access_time_filled_rounded,
                  iconBg: const Color(0xFFFFD1C4),
                  iconColor: const Color(0xFFBA3E18),
                  priceBold: '15rb',
                  rateUnit: ' / jam / orang',
                ),
                _PriceItemData(
                  icon: Icons.wb_sunny_rounded,
                  iconBg: const Color(0xFFFFE5A3),
                  iconColor: const Color(0xFFB87814),
                  priceBold: '50rb',
                  rateUnit: ' / All Day / orang',
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Close button
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.forestGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Tutup', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
  }

  Widget _buildPriceSection({
    required String title,
    required Color headerBgColor,
    required Color cardBorderColor,
    required List<_PriceItemData> items,
  }) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: cardBorderColor, width: 2.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          // Section Pill Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 8),
            decoration: BoxDecoration(
              color: headerBgColor,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(17)),
            ),
            child: Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'Lora',
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 14,
                letterSpacing: 1.0,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: items.map((item) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFBF8F2),
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: AppColors.borderSubtle),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 38,
                        height: 38,
                        decoration: BoxDecoration(
                          color: item.iconBg,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Icon(item.icon, color: item.iconColor, size: 22),
                      ),
                      const SizedBox(width: 14),
                      Text(
                        item.priceBold,
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.w900,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      Text(
                        item.rateUnit,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _PriceItemData {
  final IconData icon;
  final Color iconBg;
  final Color iconColor;
  final String priceBold;
  final String rateUnit;

  const _PriceItemData({
    required this.icon,
    required this.iconBg,
    required this.iconColor,
    required this.priceBold,
    required this.rateUnit,
  });
}
