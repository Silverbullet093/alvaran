import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../services/booking_service.dart';
import '../services/user_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/alvaran_app_bar.dart';
import '../widgets/section_header.dart';
import '../widgets/edit_profile_modal.dart';
import '../widgets/qr_ticket_modal.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onBack;
  final bool showBackButton;

  const ProfileScreen({
    super.key,
    this.onBack,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserService>().user;
    final booking = context.watch<BookingService>();
    final tickets = booking.tickets;

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AlvaranSubAppBar(
        title: 'Profile',
        showBackButton: showBackButton,
        onBack: onBack,
        trailing: IconButton(
          icon: const Icon(Icons.settings_outlined, color: AppColors.forestGreen),
          onPressed: () {
            _showSettingsDialog(context);
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: 12),

              // Avatar with glowing circular border
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 96,
                      height: 96,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.sageGreen,
                        border: Border.all(color: AppColors.white, width: 4),
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.forestGreen.withValues(alpha: 0.15),
                            blurRadius: 14,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ClipOval(
                        child: CustomPaint(
                          painter: _PlayerAvatarPainter(),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: InkWell(
                        onTap: () => EditProfileModal.show(context),
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            color: AppColors.forestGreen,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.edit_rounded,
                            size: 15,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 14),

              // Name & Email
              Text(
                user.fullName,
                style: AppTypography.headlineMedium.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 20,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 3),
              Text(
                user.email,
                style: AppTypography.bodySmall.copyWith(
                  color: AppColors.textSecondary,
                  fontSize: 13,
                ),
              ),
              const SizedBox(height: 14),

              // Edit Profil pill button
              OutlinedButton.icon(
                onPressed: () => EditProfileModal.show(context),
                icon: const Icon(Icons.edit_outlined, size: 14),
                label: const Text('Edit Profil'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.forestGreen,
                  side: const BorderSide(color: AppColors.borderLight, width: 1.2),
                  backgroundColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  textStyle: AppTypography.titleSmall.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 13,
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Stats Row: 12 Tiket Tersimpan | 3 Ulasan Anda
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.borderSubtle, width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            user.savedTicketsCount.toString(),
                            style: AppTypography.displaySmall.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Tiket Tersimpan',
                            style: AppTypography.bodySmall.copyWith(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 36,
                      width: 1,
                      color: AppColors.borderLight,
                    ),
                    Expanded(
                      child: Column(
                        children: [
                          Text(
                            user.userReviewsCount.toString(),
                            style: AppTypography.displaySmall.copyWith(
                              fontSize: 22,
                              fontWeight: FontWeight.w800,
                              color: AppColors.textPrimary,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            'Ulasan Anda',
                            style: AppTypography.bodySmall.copyWith(
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),

              // Section: Tiket Saya
              SectionHeader(
                title: 'Tiket Saya',
                actionLabel: 'Lihat Semua',
                onActionTap: () {
                  _showAllTicketsSheet(context, tickets);
                },
              ),

              // Ticket Cards
              if (tickets.isEmpty)
                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Center(
                    child: Text(
                      'Belum ada tiket tersimpan.',
                      style: AppTypography.bodyMedium,
                    ),
                  ),
                )
              else
                ...tickets.map((t) {
                  return Container(
                    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(color: AppColors.borderSubtle, width: 1.2),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.03),
                          blurRadius: 8,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.circular(18),
                      child: InkWell(
                        onTap: () => QrTicketModal.show(context, t),
                        borderRadius: BorderRadius.circular(18),
                        child: Padding(
                          padding: const EdgeInsets.all(14),
                          child: Row(
                            children: [
                              // Ticket icon badge
                              Container(
                                width: 44,
                                height: 44,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFFDECE8),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: const Center(
                                  child: Icon(
                                    Icons.confirmation_number_rounded,
                                    color: AppColors.terracotta,
                                    size: 22,
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),

                              // Ticket info
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      t.passType.name,
                                      style: AppTypography.titleMedium.copyWith(
                                        fontWeight: FontWeight.w700,
                                        fontSize: 15,
                                      ),
                                    ),
                                    const SizedBox(height: 3),
                                    Text(
                                      '${t.date.day} Mei ${t.date.year} · ${t.visitorCount} Orang · Meja ${t.tableNumber}',
                                      style: AppTypography.bodySmall.copyWith(
                                        fontSize: 12,
                                        color: AppColors.textSecondary,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Mini QR thumbnail
                              Container(
                                width: 44,
                                height: 44,
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                  color: AppColors.cream,
                                  borderRadius: BorderRadius.circular(8),
                                  border: Border.all(color: AppColors.borderLight),
                                ),
                                child: QrImageView(
                                  data: t.qrPayload,
                                  version: QrVersions.auto,
                                  size: 36,
                                  eyeStyle: const QrEyeStyle(
                                    eyeShape: QrEyeShape.square,
                                    color: AppColors.forestGreen,
                                  ),
                                  dataModuleStyle: const QrDataModuleStyle(
                                    dataModuleShape: QrDataModuleShape.square,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  void _showAllTicketsSheet(BuildContext context, List tickets) {
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
            Text(
              'Semua Tiket Anda',
              style: AppTypography.headlineMedium.copyWith(fontSize: 18),
            ),
            const SizedBox(height: 14),
            ...tickets.map((t) => ListTile(
                  tileColor: AppColors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                    side: const BorderSide(color: AppColors.borderSubtle),
                  ),
                  contentPadding: const EdgeInsets.symmetric(horizontal: 14, vertical: 4),
                  leading: const Icon(Icons.qr_code_rounded, color: AppColors.forestGreen),
                  title: Text(t.passType.name, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${t.date.day} Mei ${t.date.year} · ${t.visitorCount} Orang'),
                  trailing: const Icon(Icons.chevron_right_rounded),
                  onTap: () {
                    Navigator.pop(ctx);
                    QrTicketModal.show(context, t);
                  },
                )),
          ],
        ),
      ),
    );
  }

  void _showSettingsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.cream,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Text('Pengaturan ALVARAN', style: AppTypography.headlineMedium),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.notifications_active_outlined, color: AppColors.forestGreen),
              title: const Text('Notifikasi Aplikasi'),
              trailing: const Icon(Icons.toggle_on_rounded, color: AppColors.forestGreen, size: 36),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.language_rounded, color: AppColors.forestGreen),
              title: const Text('Bahasa'),
              subtitle: const Text('Bahasa Indonesia'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.info_outline_rounded, color: AppColors.forestGreen),
              title: const Text('Tentang ALVARAN Cafe'),
              subtitle: const Text('v1.0.0 (Material 3)'),
              onTap: () {},
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Tutup', style: TextStyle(color: AppColors.forestGreen, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _PlayerAvatarPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final w = size.width;
    final h = size.height;

    // Face / skin
    final skinPaint = Paint()..color = const Color(0xFFF3C7A8);
    canvas.drawCircle(Offset(w * 0.5, h * 0.48), w * 0.30, skinPaint);

    // Hair
    final hairPaint = Paint()..color = const Color(0xFF2C1E14);
    final hairPath = Path();
    hairPath.addOval(Rect.fromLTWH(w * 0.22, h * 0.18, w * 0.56, h * 0.38));
    canvas.drawPath(hairPath, hairPaint);

    // Eyes
    final eyePaint = Paint()..color = const Color(0xFF2C1E14);
    canvas.drawCircle(Offset(w * 0.40, h * 0.48), 2.5, eyePaint);
    canvas.drawCircle(Offset(w * 0.60, h * 0.48), 2.5, eyePaint);

    // Friendly Smile
    final smilePaint = Paint()
      ..color = const Color(0xFF9E4834)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..strokeCap = StrokeCap.round;

    final smilePath = Path()
      ..moveTo(w * 0.44, h * 0.58)
      ..quadraticBezierTo(w * 0.5, h * 0.64, w * 0.56, h * 0.58);
    canvas.drawPath(smilePath, smilePaint);

    // Cheerful Shirt collar
    final shirtPaint = Paint()..color = AppColors.forestGreen;
    final shirtPath = Path()
      ..moveTo(w * 0.15, h)
      ..lineTo(w * 0.35, h * 0.72)
      ..lineTo(w * 0.65, h * 0.72)
      ..lineTo(w * 0.85, h)
      ..close();
    canvas.drawPath(shirtPath, shirtPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
