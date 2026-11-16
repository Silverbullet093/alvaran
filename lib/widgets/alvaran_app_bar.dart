import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import 'notifications_sheet.dart';

class AlvaranHomeHeader extends StatelessWidget {
  final VoidCallback? onNotificationTap;

  const AlvaranHomeHeader({
    super.key,
    this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Logo & Name
          Row(
            children: [
              Container(
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: AppColors.forestGreen,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: AppColors.forestGreen.withValues(alpha: 0.25),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Center(
                  child: CustomPaint(
                    size: const Size(22, 22),
                    painter: _AlvaranLogoPainter(),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Text(
                'ALVARAN',
                style: AppTypography.displaySmall.copyWith(
                  fontSize: 20,
                  fontWeight: FontWeight.w800,
                  letterSpacing: 2.0,
                  color: AppColors.forestGreen,
                ),
              ),
            ],
          ),

          // Notification Bell
          InkWell(
            onTap: () {
              if (onNotificationTap != null) {
                onNotificationTap!();
              } else {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (ctx) => const NotificationsSheet(),
                );
              }
            },
            borderRadius: BorderRadius.circular(20),
            child: Container(
              width: 42,
              height: 42,
              decoration: BoxDecoration(
                color: AppColors.white,
                shape: BoxShape.circle,
                border: Border.all(color: AppColors.borderSubtle),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.04),
                    blurRadius: 6,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  const Icon(
                    Icons.notifications_none_rounded,
                    color: AppColors.forestGreen,
                    size: 22,
                  ),
                  Positioned(
                    top: 10,
                    right: 11,
                    child: Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: AppColors.terracotta,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class AlvaranSubAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBack;
  final Widget? trailing;
  final bool showBackButton;

  const AlvaranSubAppBar({
    super.key,
    required this.title,
    this.onBack,
    this.trailing,
    this.showBackButton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                if (showBackButton) ...[
                  InkWell(
                    onTap: onBack ?? () => Navigator.of(context).maybePop(),
                    borderRadius: BorderRadius.circular(12),
                    child: Container(
                      width: 38,
                      height: 38,
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: AppColors.borderSubtle),
                      ),
                      child: const Icon(
                        Icons.chevron_left_rounded,
                        color: AppColors.forestGreen,
                        size: 24,
                      ),
                    ),
                  ),
                  const SizedBox(width: 14),
                ],
                Text(
                  title,
                  style: AppTypography.headlineMedium.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            if (trailing != null) trailing!,
          ],
        ),
      ),
    );
  }
}

class _AlvaranLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = AppColors.cream
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    final fillPaint = Paint()
      ..color = AppColors.gold
      ..style = PaintingStyle.fill;

    // Isometric Cube / Dice representation
    final cx = size.width / 2;
    final cy = size.height / 2;
    final r = size.width * 0.42;

    final path = Path();
    path.moveTo(cx, cy - r);
    path.lineTo(cx + r * 0.866, cy - r * 0.5);
    path.lineTo(cx + r * 0.866, cy + r * 0.5);
    path.lineTo(cx, cy + r);
    path.lineTo(cx - r * 0.866, cy + r * 0.5);
    path.lineTo(cx - r * 0.866, cy - r * 0.5);
    path.close();

    canvas.drawPath(path, paint);

    // Inner lines to form 3D cube
    canvas.drawLine(Offset(cx, cy - r), Offset(cx, cy), paint);
    canvas.drawLine(Offset(cx, cy), Offset(cx + r * 0.866, cy + r * 0.5), paint);
    canvas.drawLine(Offset(cx, cy), Offset(cx - r * 0.866, cy + r * 0.5), paint);

    // Gold pip dot on top face
    canvas.drawCircle(Offset(cx, cy - r * 0.4), 2.0, fillPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
