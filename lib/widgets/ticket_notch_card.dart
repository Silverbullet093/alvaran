import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class TicketNotchCard extends StatelessWidget {
  final Widget child;
  final double notchRadius;
  final double notchYFraction;
  final Color backgroundColor;
  final Color borderColor;

  const TicketNotchCard({
    super.key,
    required this.child,
    this.notchRadius = 14,
    this.notchYFraction = 0.35,
    this.backgroundColor = AppColors.white,
    this.borderColor = AppColors.borderSubtle,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _TicketBorderPainter(
        notchRadius: notchRadius,
        notchYFraction: notchYFraction,
        borderColor: borderColor,
      ),
      child: ClipPath(
        clipper: _TicketNotchClipper(
          notchRadius: notchRadius,
          notchYFraction: notchYFraction,
        ),
        child: Container(
          color: backgroundColor,
          child: child,
        ),
      ),
    );
  }
}

class _TicketNotchClipper extends CustomClipper<Path> {
  final double notchRadius;
  final double notchYFraction;

  _TicketNotchClipper({
    required this.notchRadius,
    required this.notchYFraction,
  });

  @override
  Path getClip(Size size) {
    final path = Path();
    final notchY = size.height * notchYFraction;
    const cornerRadius = 24.0;

    // Start top-left
    path.moveTo(cornerRadius, 0);
    // Top border
    path.lineTo(size.width - cornerRadius, 0);
    // Top-right corner
    path.arcToPoint(
      Offset(size.width, cornerRadius),
      radius: const Radius.circular(cornerRadius),
    );

    // Right border down to notch
    path.lineTo(size.width, notchY - notchRadius);
    // Right notch cutout
    path.arcToPoint(
      Offset(size.width, notchY + notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    // Right border to bottom
    path.lineTo(size.width, size.height - cornerRadius);
    // Bottom-right corner
    path.arcToPoint(
      Offset(size.width - cornerRadius, size.height),
      radius: const Radius.circular(cornerRadius),
    );

    // Bottom border
    path.lineTo(cornerRadius, size.height);
    // Bottom-left corner
    path.arcToPoint(
      Offset(0, size.height - cornerRadius),
      radius: const Radius.circular(cornerRadius),
    );

    // Left border up to notch
    path.lineTo(0, notchY + notchRadius);
    // Left notch cutout
    path.arcToPoint(
      Offset(0, notchY - notchRadius),
      radius: Radius.circular(notchRadius),
      clockwise: false,
    );
    // Left border to top
    path.lineTo(0, cornerRadius);
    // Top-left corner
    path.arcToPoint(
      const Offset(cornerRadius, 0),
      radius: const Radius.circular(cornerRadius),
    );

    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}

class _TicketBorderPainter extends CustomPainter {
  final double notchRadius;
  final double notchYFraction;
  final Color borderColor;

  _TicketBorderPainter({
    required this.notchRadius,
    required this.notchYFraction,
    required this.borderColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = borderColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final clipper = _TicketNotchClipper(
      notchRadius: notchRadius,
      notchYFraction: notchYFraction,
    );
    final path = clipper.getClip(size);
    canvas.drawPath(path, paint);

    // Draw dashed line at notch position
    final dashPaint = Paint()
      ..color = borderColor
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    final notchY = size.height * notchYFraction;
    const dashWidth = 5.0;
    const dashSpace = 4.0;
    double startX = notchRadius + 4;
    final endX = size.width - notchRadius - 4;

    while (startX < endX) {
      canvas.drawLine(
        Offset(startX, notchY),
        Offset(startX + dashWidth > endX ? endX : startX + dashWidth, notchY),
        dashPaint,
      );
      startX += dashWidth + dashSpace;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
