import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class NotificationsSheet extends StatelessWidget {
  const NotificationsSheet({super.key});

  @override
  Widget build(BuildContext context) {
    final notifications = [
      {
        'title': 'Turnamen Catan Live Event',
        'desc': 'Pendaftaran turnamen Sabtu, 24 Mei 2025 dibuka! Slot terbatas 16 pemain.',
        'time': '10 menit lalu',
        'isNew': true,
        'icon': Icons.emoji_events_rounded,
        'iconBg': AppColors.gold,
      },
      {
        'title': 'Pengingat Reservasi Meja',
        'desc': 'Reservasi Meja 1 Anda dijadwalkan hari Sabtu, 24 Mei 2025 pukul 14:00.',
        'time': '2 jam lalu',
        'isNew': true,
        'icon': Icons.event_available_rounded,
        'iconBg': AppColors.forestGreen,
      },
      {
        'title': 'Board Game Baru Tersedia!',
        'desc': 'Azul & Wingspan kini siap dimainkan di rak koleksi utama.',
        'time': '1 hari lalu',
        'isNew': false,
        'icon': Icons.casino_rounded,
        'iconBg': AppColors.terracotta,
      },
    ];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
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
          const SizedBox(height: 18),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Notifikasi',
                style: AppTypography.headlineMedium.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 20,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Semua notifikasi telah ditandai dibaca.'),
                      backgroundColor: AppColors.forestGreen,
                      behavior: SnackBarBehavior.floating,
                    ),
                  );
                },
                child: Text(
                  'Tandai Dibaca',
                  style: AppTypography.titleSmall.copyWith(
                    color: AppColors.forestGreen,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notifications.length,
            separatorBuilder: (c, i) => const Divider(height: 16),
            itemBuilder: (context, index) {
              final n = notifications[index];
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: (n['iconBg'] as Color).withValues(alpha: 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      n['icon'] as IconData,
                      color: n['iconBg'] as Color,
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              n['title'] as String,
                              style: AppTypography.titleSmall.copyWith(
                                fontWeight: FontWeight.w700,
                                fontSize: 13,
                              ),
                            ),
                            if (n['isNew'] as bool)
                              Container(
                                width: 7,
                                height: 7,
                                decoration: const BoxDecoration(
                                  color: AppColors.terracotta,
                                  shape: BoxShape.circle,
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 3),
                        Text(
                          n['desc'] as String,
                          style: AppTypography.bodySmall.copyWith(
                            fontSize: 12,
                            color: AppColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          n['time'] as String,
                          style: AppTypography.bodySmall.copyWith(
                            fontSize: 10,
                            color: AppColors.textMuted,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }
}
