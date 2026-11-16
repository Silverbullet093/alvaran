import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

enum BadgeType { available, occupied, comingSoon }

class StatusBadge extends StatelessWidget {
  final String label;
  final BadgeType type;

  const StatusBadge({
    super.key,
    required this.label,
    required this.type,
  });

  factory StatusBadge.available({String label = 'Tersedia'}) {
    return StatusBadge(label: label, type: BadgeType.available);
  }

  factory StatusBadge.occupied({String label = 'Terisi'}) {
    return StatusBadge(label: label, type: BadgeType.occupied);
  }

  factory StatusBadge.comingSoon({String label = 'Coming Soon'}) {
    return StatusBadge(label: label, type: BadgeType.comingSoon);
  }

  @override
  Widget build(BuildContext context) {
    Color bg;
    Color dotColor;
    Color textColor;

    switch (type) {
      case BadgeType.available:
        bg = AppColors.availableGreenLight;
        dotColor = AppColors.availableGreen;
        textColor = AppColors.availableGreen;
        break;
      case BadgeType.occupied:
        bg = AppColors.occupiedRedLight;
        dotColor = AppColors.occupiedRed;
        textColor = AppColors.occupiedRed;
        break;
      case BadgeType.comingSoon:
        bg = AppColors.comingSoonYellow;
        dotColor = AppColors.comingSoonText;
        textColor = AppColors.comingSoonText;
        break;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 7,
            height: 7,
            decoration: BoxDecoration(
              color: dotColor,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 6),
          Text(
            label,
            style: AppTypography.badgeText.copyWith(color: textColor),
          ),
        ],
      ),
    );
  }
}
