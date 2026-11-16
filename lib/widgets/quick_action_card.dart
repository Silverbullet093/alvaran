import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class QuickActionItem {
  final String title;
  final IconData icon;
  final Color iconColor;
  final Color badgeBgColor;
  final VoidCallback onTap;

  const QuickActionItem({
    required this.title,
    required this.icon,
    required this.iconColor,
    required this.badgeBgColor,
    required this.onTap,
  });
}

class QuickActionBar extends StatelessWidget {
  final Function(int tabIndex)? onSelectTab;
  final VoidCallback? onBuyTickets;
  final VoidCallback? onGameLibrary;
  final VoidCallback? onReviews;

  const QuickActionBar({
    super.key,
    this.onSelectTab,
    this.onBuyTickets,
    this.onGameLibrary,
    this.onReviews,
  });

  @override
  Widget build(BuildContext context) {
    final actions = [
      QuickActionItem(
        title: 'Buy\nTickets',
        icon: Icons.confirmation_number_rounded,
        iconColor: AppColors.terracotta,
        badgeBgColor: const Color(0xFFFBECE8),
        onTap: () {
          if (onBuyTickets != null) {
            onBuyTickets!();
          } else if (onSelectTab != null) {
            onSelectTab!(1); // Tickets tab
          }
        },
      ),
      QuickActionItem(
        title: 'Game\nLibrary',
        icon: Icons.menu_book_rounded,
        iconColor: const Color(0xFF2C6B4F),
        badgeBgColor: AppColors.sageGreen,
        onTap: () {
          if (onGameLibrary != null) {
            onGameLibrary!();
          } else if (onSelectTab != null) {
            onSelectTab!(2); // Library tab
          }
        },
      ),
      QuickActionItem(
        title: 'Reviews',
        icon: Icons.star_rounded,
        iconColor: const Color(0xFFB8860B),
        badgeBgColor: const Color(0xFFFDF0D5),
        onTap: () {
          if (onReviews != null) {
            onReviews!();
          } else if (onSelectTab != null) {
            onSelectTab!(3); // Reviews tab
          }
        },
      ),
    ];

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        children: actions.map((act) {
          return Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              child: _QuickActionCard(item: act),
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final QuickActionItem item;

  const _QuickActionCard({required this.item});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: AppColors.white,
      borderRadius: BorderRadius.circular(20),
      elevation: 0,
      child: InkWell(
        onTap: item.onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: AppColors.borderSubtle, width: 1.2),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon Badge circle
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: item.badgeBgColor,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(
                  item.icon,
                  color: item.iconColor,
                  size: 26,
                ),
              ),
              const SizedBox(height: 10),
              // Label
              Text(
                item.title,
                textAlign: TextAlign.center,
                style: AppTypography.titleSmall.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 13,
                  height: 1.2,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
