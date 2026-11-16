import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/alvaran_app_bar.dart';
import '../widgets/game_card.dart';

class GameLibraryScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final bool showBackButton;

  const GameLibraryScreen({
    super.key,
    this.onBack,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final gameService = context.watch<GameService>();
    final allGames = gameService.allGames;

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AlvaranSubAppBar(
        title: 'Game Library',
        showBackButton: showBackButton,
        onBack: onBack,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search field matching Design System: "Cari di Alvaran..."
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: AppColors.borderLight, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: TextField(
                  onChanged: (val) => gameService.setSearchQuery(val),
                  decoration: InputDecoration(
                    hintText: 'Cari di Alvaran...',
                    hintStyle: AppTypography.bodyMedium.copyWith(color: AppColors.textMuted),
                    prefixIcon: const Icon(Icons.search_rounded, color: AppColors.textSecondary),
                    suffixIcon: gameService.searchQuery.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () => gameService.setSearchQuery(''),
                          )
                        : null,
                    border: InputBorder.none,
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                  ),
                ),
              ),
            ),

            // Category Chips Row
            SizedBox(
              height: 42,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: gameService.categories.length,
                itemBuilder: (context, index) {
                  final cat = gameService.categories[index];
                  final isSelected = gameService.selectedCategory == cat;

                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: FilterChip(
                      label: Text(cat),
                      selected: isSelected,
                      onSelected: (_) => gameService.selectCategory(cat),
                      backgroundColor: AppColors.white,
                      selectedColor: AppColors.forestGreen,
                      labelStyle: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isSelected ? AppColors.white : AppColors.textPrimary,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                        side: BorderSide(
                          color: isSelected ? AppColors.forestGreen : AppColors.borderSubtle,
                        ),
                      ),
                      showCheckmark: false,
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 12),

            // Game grid
            Expanded(
              child: allGames.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.search_off_rounded, size: 48, color: AppColors.textMuted),
                          const SizedBox(height: 12),
                          Text(
                            'Tidak ada board game yang cocok.',
                            style: AppTypography.bodyMedium,
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      physics: const BouncingScrollPhysics(),
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                        mainAxisSpacing: 16,
                        crossAxisSpacing: 12,
                        childAspectRatio: 0.72,
                      ),
                      itemCount: allGames.length,
                      itemBuilder: (context, index) {
                        final game = allGames[index];
                        return GameCard(game: game);
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
