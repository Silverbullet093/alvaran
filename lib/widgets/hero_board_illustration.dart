import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class HeroBoardIllustration extends StatelessWidget {
  const HeroBoardIllustration({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        color: AppColors.forestGreen,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [
          BoxShadow(
            color: AppColors.forestGreen.withValues(alpha: 0.3),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Background subtle warm glow & stars
          Positioned(
            right: -10,
            top: -10,
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                gradient: RadialGradient(
                  colors: [
                    AppColors.gold.withValues(alpha: 0.18),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Greeting Tag
              Text(
                'SELAMAT DATANG, PLAYER',
                style: AppTypography.greetingTag.copyWith(
                  color: AppColors.gold,
                ),
              ),
              const SizedBox(height: 8),

              // Title
              Text(
                'Your table is ready\nfor a new adventure.',
                style: AppTypography.displayMedium.copyWith(
                  color: AppColors.cream,
                  fontSize: 24,
                  height: 1.25,
                ),
              ),
              const SizedBox(height: 14),

              // Open Today Tag
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: AppColors.cream.withValues(alpha: 0.95),
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: const BoxDecoration(
                        color: Color(0xFF2E7D32),
                        shape: BoxShape.circle,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        'Open today · 10:00–23:00',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: AppTypography.titleSmall.copyWith(
                          color: AppColors.forestGreen,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),

              // Board Game Table & 3D Pieces Canvas
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Container(
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        const Color(0xFF1F4A3F),
                        const Color(0xFF14362E),
                      ],
                    ),
                  ),
                  child: CustomPaint(
                    painter: _BoardGameScenePainter(),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BoardGameScenePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Draw wooden game board table perspective
    final boardPaint = Paint()
      ..color = const Color(0xFFC49A6C)
      ..style = PaintingStyle.fill;

    final boardShadow = Paint()
      ..color = const Color(0xFF8B5A2B)
      ..style = PaintingStyle.fill;

    // Hex tiles (Catan board tiles)
    _drawHexGrid(canvas, Offset(w * 0.48, h * 0.52), 20);

    // Left Yellow Meeple
    _drawMeeple(canvas, Offset(w * 0.16, h * 0.65), AppColors.gold, 1.1);

    // Red Meeple
    _drawMeeple(canvas, Offset(w * 0.30, h * 0.78), AppColors.terracotta, 1.0);

    // Blue Meeple
    _drawMeeple(canvas, Offset(w * 0.74, h * 0.60), const Color(0xFF2A75D3), 1.15);

    // Green Meeple
    _drawMeeple(canvas, Offset(w * 0.88, h * 0.75), const Color(0xFF388E3C), 0.95);

    // 3D White D6 Dice with black pips (Dice 1)
    _draw3DDice(canvas, Offset(w * 0.32, h * 0.35), 24, 1);

    // 3D White D6 Dice (Dice 2)
    _draw3DDice(canvas, Offset(w * 0.68, h * 0.32), 22, 5);

    // Little wooden resource cards stack
    _drawCardsStack(canvas, Offset(w * 0.82, h * 0.30));
  }

  void _drawHexGrid(Canvas canvas, Offset center, double radius) {
    final hexColors = [
      const Color(0xFF81C784), // Pasture (green)
      const Color(0xFFFFD54F), // Grain (gold)
      const Color(0xFFE57373), // Brick (terracotta)
      const Color(0xFF90A4AE), // Ore (gray)
      const Color(0xFF4CAF50), // Forest (dark green)
      const Color(0xFFFFE082), // Desert (sand)
    ];

    final strokePaint = Paint()
      ..color = const Color(0xFF5D4037)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    int colorIdx = 0;
    // Draw central cluster of hexes
    final offsets = [
      Offset(center.dx, center.dy),
      Offset(center.dx - radius * 1.6, center.dy),
      Offset(center.dx + radius * 1.6, center.dy),
      Offset(center.dx - radius * 0.8, center.dy - radius * 1.4),
      Offset(center.dx + radius * 0.8, center.dy - radius * 1.4),
      Offset(center.dx - radius * 0.8, center.dy + radius * 1.4),
      Offset(center.dx + radius * 0.8, center.dy + radius * 1.4),
    ];

    for (final pos in offsets) {
      final fillPaint = Paint()
        ..color = hexColors[colorIdx % hexColors.length].withValues(alpha: 0.85)
        ..style = PaintingStyle.fill;
      colorIdx++;

      final path = Path();
      for (int i = 0; i < 6; i++) {
        final angle = (60 * i - 30) * math.pi / 180;
        final x = pos.dx + radius * math.cos(angle);
        final y = pos.dy + radius * math.sin(angle);
        if (i == 0) {
          path.moveTo(x, y);
        } else {
          path.lineTo(x, y);
        }
      }
      path.close();
      canvas.drawPath(path, fillPaint);
      canvas.drawPath(path, strokePaint);
    }
  }

  void _drawMeeple(Canvas canvas, Offset pos, Color color, double scale) {
    canvas.save();
    canvas.translate(pos.dx, pos.dy);
    canvas.scale(scale, scale);

    // Drop shadow
    final shadowPaint = Paint()..color = Colors.black.withValues(alpha: 0.3);
    canvas.drawOval(const Rect.fromLTWH(-10, 8, 20, 6), shadowPaint);

    final meeplePaint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.black.withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Meeple Shape Path
    final path = Path();
    // Head
    path.addOval(const Rect.fromLTWH(-5, -18, 10, 10));

    // Body & arms & legs
    path.moveTo(-4, -8);
    path.lineTo(-11, -3); // left arm out
    path.lineTo(-9, 0);   // left arm bottom
    path.lineTo(-5, -2);  // under left arm
    path.lineTo(-7, 10);  // left leg outer
    path.lineTo(-2, 10);  // left leg inner
    path.lineTo(0, 3);    // crotch
    path.lineTo(2, 10);   // right leg inner
    path.lineTo(7, 10);   // right leg outer
    path.lineTo(5, -2);   // under right arm
    path.lineTo(9, 0);    // right arm bottom
    path.lineTo(11, -3);  // right arm out
    path.lineTo(4, -8);   // shoulder
    path.close();

    canvas.drawPath(path, meeplePaint);
    canvas.drawPath(path, borderPaint);

    canvas.restore();
  }

  void _draw3DDice(Canvas canvas, Offset center, double size, int topPips) {
    final cx = center.dx;
    final cy = center.dy;
    final half = size / 2;

    // Shadow
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, cy + half + 4), width: size * 1.2, height: 7),
      Paint()..color = Colors.black.withValues(alpha: 0.35),
    );

    // Isometric 3D Cube faces
    final topFace = Path()
      ..moveTo(cx, cy - half)
      ..lineTo(cx + half * 0.9, cy - half * 0.4)
      ..lineTo(cx, cy + 2)
      ..lineTo(cx - half * 0.9, cy - half * 0.4)
      ..close();

    final leftFace = Path()
      ..moveTo(cx - half * 0.9, cy - half * 0.4)
      ..lineTo(cx, cy + 2)
      ..lineTo(cx, cy + half + 2)
      ..lineTo(cx - half * 0.9, cy + half * 0.5)
      ..close();

    final rightFace = Path()
      ..moveTo(cx, cy + 2)
      ..lineTo(cx + half * 0.9, cy - half * 0.4)
      ..lineTo(cx + half * 0.9, cy + half * 0.5)
      ..lineTo(cx, cy + half + 2)
      ..close();

    canvas.drawPath(topFace, Paint()..color = const Color(0xFFFFFFFF));
    canvas.drawPath(leftFace, Paint()..color = const Color(0xFFD6D6D6));
    canvas.drawPath(rightFace, Paint()..color = const Color(0xFFB0B0B0));

    final outline = Paint()
      ..color = const Color(0xFF888888)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    canvas.drawPath(topFace, outline);
    canvas.drawPath(leftFace, outline);
    canvas.drawPath(rightFace, outline);

    // Draw pips on top face
    final pipPaint = Paint()..color = const Color(0xFF1E1E1E);
    if (topPips == 1) {
      canvas.drawCircle(Offset(cx, cy - half * 0.5 + 1), 2.2, pipPaint);
    } else {
      canvas.drawCircle(Offset(cx, cy - half * 0.5 + 1), 1.8, pipPaint);
      canvas.drawCircle(Offset(cx - 5, cy - half * 0.5 - 2), 1.8, pipPaint);
      canvas.drawCircle(Offset(cx + 5, cy - half * 0.5 + 4), 1.8, pipPaint);
      canvas.drawCircle(Offset(cx + 5, cy - half * 0.5 - 2), 1.8, pipPaint);
      canvas.drawCircle(Offset(cx - 5, cy - half * 0.5 + 4), 1.8, pipPaint);
    }
  }

  void _drawCardsStack(Canvas canvas, Offset pos) {
    final cardBorder = Paint()
      ..color = const Color(0xFF5A4430)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final cardFill = Paint()..color = const Color(0xFFF4ECE1);
    final cardBack = Paint()..color = AppColors.terracotta;

    for (int i = 0; i < 3; i++) {
      final r = RRect.fromRectAndRadius(
        Rect.fromLTWH(pos.dx + i * 2, pos.dy - i * 3, 20, 26),
        const Radius.circular(3),
      );
      canvas.drawRRect(r, i == 2 ? cardBack : cardFill);
      canvas.drawRRect(r, cardBorder);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
