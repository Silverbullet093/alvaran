import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../utils/responsive_layout.dart';
import 'home_screen.dart';
import 'buy_tickets_screen.dart';
import 'game_library_screen.dart';
import 'reviews_screen.dart';
import 'profile_screen.dart';

class MainNavigationShell extends StatefulWidget {
  final int initialIndex;

  const MainNavigationShell({
    super.key,
    this.initialIndex = 0,
  });

  @override
  State<MainNavigationShell> createState() => _MainNavigationShellState();
}

class _MainNavigationShellState extends State<MainNavigationShell> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.initialIndex;
  }

  void _onTabSelected(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(
        onNavigateToTab: _onTabSelected,
      ),
      BuyTicketsScreen(
        showBackButton: false,
        onBack: () => _onTabSelected(0),
      ),
      GameLibraryScreen(
        showBackButton: false,
        onBack: () => _onTabSelected(0),
      ),
      ReviewsScreen(
        showBackButton: false,
        onBack: () => _onTabSelected(0),
      ),
      ProfileScreen(
        showBackButton: false,
        onBack: () => _onTabSelected(0),
      ),
    ];

    return ResponsiveLayout(
      child: Scaffold(
        backgroundColor: AppColors.cream,
        body: IndexedStack(
          index: _currentIndex,
          children: screens,
        ),
        bottomNavigationBar: _buildAlvaranBottomNav(),
      ),
    );
  }

  Widget _buildAlvaranBottomNav() {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.white,
        border: const Border(
          top: BorderSide(color: AppColors.borderSubtle, width: 1.0),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
          child: Row(
            children: [
              Expanded(
                child: _buildNavItem(
                  index: 0,
                  icon: Icons.home_rounded,
                  label: 'Home',
                ),
              ),
              Expanded(
                child: _buildNavItem(
                  index: 1,
                  icon: Icons.confirmation_number_rounded,
                  label: 'Tickets',
                ),
              ),
              Expanded(
                child: _buildNavItem(
                  index: 2,
                  icon: Icons.menu_book_rounded,
                  label: 'Library',
                ),
              ),
              Expanded(
                child: _buildNavItem(
                  index: 3,
                  icon: Icons.star_rounded,
                  label: 'Reviews',
                ),
              ),
              Expanded(
                child: _buildNavItem(
                  index: 4,
                  icon: Icons.person_rounded,
                  label: 'Profile',
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required int index,
    required IconData icon,
    required String label,
  }) {
    final isSelected = _currentIndex == index;

    return InkWell(
      onTap: () => _onTabSelected(index),
      borderRadius: BorderRadius.circular(16),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 6),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.forestGreen.withValues(alpha: 0.08)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 22,
              color: isSelected ? AppColors.forestGreen : AppColors.textMuted,
            ),
            const SizedBox(height: 3),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 11,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                color: isSelected ? AppColors.forestGreen : AppColors.textMuted,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
