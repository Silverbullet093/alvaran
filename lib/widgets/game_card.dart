import 'package:flutter/material.dart';
import '../models/board_game.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class GameCard extends StatelessWidget {
  final BoardGame game;
  final VoidCallback? onTap;

  const GameCard({
    super.key,
    required this.game,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 104,
      margin: const EdgeInsets.only(right: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Card Image with rounded corners and warm border
          InkWell(
            onTap: onTap ?? () => _showGameDetailModal(context),
            borderRadius: BorderRadius.circular(16),
            child: Container(
              height: 104,
              width: 104,
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.borderLight, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(15),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Network image with graceful artistic fallback
                    Image.network(
                      game.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildArtisticGamePoster(),
                    ),
                    // Gradient overlay at bottom
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      height: 40,
                      child: Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                            colors: [
                              Colors.black.withValues(alpha: 0.65),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                    ),
                    // Rating chip
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.7),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.star_rounded,
                              size: 11,
                              color: AppColors.gold,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              game.rating.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 9,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          // Title
          Text(
            game.title,
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.titleSmall.copyWith(
              fontWeight: FontWeight.w700,
              fontSize: 13,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildArtisticGamePoster() {
    Color bg;
    IconData icon;
    switch (game.id) {
      case 'catan':
        bg = const Color(0xFFC76B24);
        icon = Icons.landscape_rounded;
        break;
      case 'carcassonne':
        bg = const Color(0xFF336799);
        icon = Icons.castle_rounded;
        break;
      case 'dixit':
        bg = const Color(0xFF6B3E93);
        icon = Icons.auto_awesome_rounded;
        break;
      default:
        bg = AppColors.forestGreen;
        icon = Icons.casino_rounded;
    }

    return Container(
      color: bg,
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.white, size: 32),
            const SizedBox(height: 4),
            Text(
              game.title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showGameDetailModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: AppColors.cream,
          borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(4),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: SizedBox(
                    width: 70,
                    height: 70,
                    child: Image.network(
                      game.imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (c, e, s) => _buildArtisticGamePoster(),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        game.title,
                        style: AppTypography.headlineMedium.copyWith(fontSize: 20),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        game.category,
                        style: AppTypography.bodySmall.copyWith(
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          const Icon(Icons.star_rounded, size: 16, color: AppColors.gold),
                          const SizedBox(width: 4),
                          Text(
                            '${game.rating} · ${game.availableCopies} kopi tersedia di cafe',
                            style: AppTypography.bodySmall.copyWith(
                              fontWeight: FontWeight.w600,
                              color: AppColors.availableGreen,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 18),
            Row(
              children: [
                _buildInfoBadge(Icons.people_alt_rounded, game.playerCount),
                const SizedBox(width: 8),
                _buildInfoBadge(Icons.timer_rounded, '${game.playTimeMinutes} mnt'),
                const SizedBox(width: 8),
                _buildInfoBadge(Icons.bar_chart_rounded, game.difficulty),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Tentang Game',
              style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 6),
            Text(
              game.description,
              style: AppTypography.bodyMedium,
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 48,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(ctx);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('${game.title} telah ditambahkan ke daftar ingin dimainkan!'),
                      backgroundColor: AppColors.forestGreen,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.forestGreen,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text('Simpan ke Wishlist Main'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBadge(IconData icon, String label) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 6),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.borderSubtle),
        ),
        child: Column(
          children: [
            Icon(icon, size: 16, color: AppColors.forestGreen),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: AppTypography.bodySmall.copyWith(
                fontSize: 11,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
