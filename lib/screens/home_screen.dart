import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/game_service.dart';
import '../theme/app_colors.dart';
import '../widgets/alvaran_app_bar.dart';
import '../widgets/hero_board_illustration.dart';
import '../widgets/quick_action_card.dart';
import '../widgets/section_header.dart';
import '../widgets/entertainment_card.dart';
import '../widgets/game_card.dart';

class HomeScreen extends StatelessWidget {
  final Function(int tabIndex)? onNavigateToTab;

  const HomeScreen({
    super.key,
    this.onNavigateToTab,
  });

  @override
  Widget build(BuildContext context) {
    final gameService = context.watch<GameService>();
    final popularGames = gameService.popularGames;
    final featuredEvent = gameService.featuredEvent;

    return Scaffold(
      backgroundColor: AppColors.cream,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header: ALVARAN Logo + Notification Bell
              const AlvaranHomeHeader(),

              // Hero Board Illustration
              const HeroBoardIllustration(),

              // Quick Actions: Buy Tickets | Game Library | Reviews
              QuickActionBar(
                onSelectTab: onNavigateToTab,
                onBuyTickets: () => onNavigateToTab?.call(1),
                onGameLibrary: () => onNavigateToTab?.call(2),
                onReviews: () => onNavigateToTab?.call(3),
              ),
              const SizedBox(height: 12),

              // Entertainment Info Section
              SectionHeader(
                title: 'Entertainment Info',
                actionLabel: 'See All',
                onActionTap: () {
                  // Show all events bottom sheet
                  _showAllEventsSheet(context, gameService.events);
                },
              ),
              EntertainmentCard(event: featuredEvent),
              const SizedBox(height: 16),

              // Popular Board Games Section
              SectionHeader(
                title: 'Popular Board Games',
                actionLabel: 'See All',
                onActionTap: () => onNavigateToTab?.call(2), // Library tab
              ),
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: popularGames.length,
                  itemBuilder: (context, index) {
                    final game = popularGames[index];
                    return GameCard(game: game);
                  },
                ),
              ),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showAllEventsSheet(BuildContext context, List events) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
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
            const SizedBox(height: 16),
            const Text(
              'Jadwal Acara & Live Event',
              style: TextStyle(
                fontFamily: 'Lora',
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 16),
            ...events.map((e) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: EntertainmentCard(event: e),
                )),
          ],
        ),
      ),
    );
  }
}
