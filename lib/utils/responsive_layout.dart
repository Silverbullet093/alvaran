import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class ResponsiveLayout extends StatelessWidget {
  final Widget child;
  final double maxContentWidth;

  const ResponsiveLayout({
    super.key,
    required this.child,
    this.maxContentWidth = 480,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > maxContentWidth) {
          return Container(
            color: const Color(0xFF0F2620), // Ambient dark forest green outer background
            child: Center(
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: maxContentWidth),
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.cream,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.35),
                        blurRadius: 30,
                        spreadRadius: 2,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: child,
                ),
              ),
            ),
          );
        }
        return child;
      },
    );
  }
}
