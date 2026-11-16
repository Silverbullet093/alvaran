import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/pass_type.dart';
import '../models/table_model.dart';
import '../services/booking_service.dart';
import '../services/user_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/currency_formatter.dart';
import '../widgets/alvaran_app_bar.dart';
import '../widgets/date_selector_strip.dart';
import '../widgets/pass_card_tile.dart';
import '../widgets/visitor_stepper.dart';
import '../widgets/promo_banner_card.dart';
import '../widgets/alvaran_buttons.dart';
import '../widgets/qr_ticket_modal.dart';
import 'table_layout_screen.dart';

class BuyTicketsScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final bool showBackButton;

  const BuyTicketsScreen({
    super.key,
    this.onBack,
    this.showBackButton = true,
  });

  @override
  State<BuyTicketsScreen> createState() => _BuyTicketsScreenState();
}

class _BuyTicketsScreenState extends State<BuyTicketsScreen> {
  bool _isProcessingPayment = false;

  void _handlePayment() {
    final bookingService = context.read<BookingService>();
    final userService = context.read<UserService>();

    setState(() => _isProcessingPayment = true);

    Future.delayed(const Duration(milliseconds: 600), () {
      if (!mounted) return;
      setState(() => _isProcessingPayment = false);

      final newTicket = bookingService.createBooking(
        customerName: userService.user.fullName,
        customerEmail: userService.user.email,
      );

      userService.incrementTicketCount();

      // Show the scannable QR ticket modal!
      QrTicketModal.show(context, newTicket);
    });
  }

  void _openTableSelector() {
    final bookingService = context.read<BookingService>();

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (ctx) => Container(
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
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Pilih Nomor Meja',
                  style: AppTypography.headlineMedium.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                TextButton.icon(
                  onPressed: () {
                    Navigator.pop(ctx);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => const TableLayoutScreen(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.grid_view_rounded, size: 16, color: AppColors.forestGreen),
                  label: Text(
                    'Buka Denah',
                    style: AppTypography.titleSmall.copyWith(
                      color: AppColors.forestGreen,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: bookingService.tables.length,
              itemBuilder: (context, index) {
                final table = bookingService.tables[index];
                final isSelected = bookingService.selectedTable?.id == table.id;

                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    tileColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                      side: BorderSide(
                        color: isSelected ? AppColors.forestGreen : AppColors.borderSubtle,
                        width: isSelected ? 1.5 : 1.0,
                      ),
                    ),
                    leading: Container(
                      width: 36,
                      height: 36,
                      decoration: BoxDecoration(
                        color: table.isAvailable ? AppColors.sageGreen : AppColors.occupiedRedLight,
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Text(
                          table.number.toString(),
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: table.isAvailable ? AppColors.forestGreen : AppColors.terracotta,
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      table.name,
                      style: AppTypography.titleMedium.copyWith(fontWeight: FontWeight.w700),
                    ),
                    subtitle: Text(
                      'Kapasitas: ${table.capacity} orang · ${table.area}',
                      style: AppTypography.bodySmall,
                    ),
                    trailing: table.isAvailable
                        ? (isSelected
                            ? const Icon(Icons.check_circle_rounded, color: AppColors.forestGreen)
                            : const Text('Tersedia', style: TextStyle(color: AppColors.availableGreen, fontWeight: FontWeight.bold, fontSize: 12)))
                        : const Text('Terisi', style: TextStyle(color: AppColors.occupiedRed, fontWeight: FontWeight.bold, fontSize: 12)),
                    enabled: table.isAvailable,
                    onTap: () {
                      bookingService.selectTable(table);
                      Navigator.pop(ctx);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingService>();

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AlvaranSubAppBar(
        title: 'Buy Tickets',
        showBackButton: widget.showBackButton,
        onBack: widget.onBack,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section 1: Pilih Tanggal
                    Text(
                      'Pilih Tanggal',
                      style: AppTypography.headlineSmall.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    DateSelectorStrip(
                      selectedDate: booking.selectedDate,
                      onDateSelected: (newDate) => booking.selectDate(newDate),
                    ),
                    const SizedBox(height: 24),

                    // Section 2: Jenis Pass
                    Text(
                      'Jenis Pass',
                      style: AppTypography.headlineSmall.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ...PassType.availablePasses.map((pass) {
                      final isSelected = booking.selectedPass.id == pass.id;
                      return PassCardTile(
                        pass: pass,
                        isSelected: isSelected,
                        onSelect: () => booking.selectPassType(pass),
                      );
                    }),
                    const SizedBox(height: 16),

                    // Section 3: Jumlah Pengunjung
                    Text(
                      'Jumlah Pengunjung',
                      style: AppTypography.headlineSmall.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 12),
                    VisitorStepper(
                      count: booking.visitorCount,
                      onDecrement: () => booking.decrementVisitor(),
                      onIncrement: () => booking.incrementVisitor(),
                    ),
                    const SizedBox(height: 18),

                    // Section 4: Promo Spesial Card
                    PromoBannerCard(
                      isApplied: booking.isPromoApplied,
                      onToggle: () => booking.togglePromo(),
                    ),
                    const SizedBox(height: 18),

                    // Section 5: Pilih Meja
                    Text(
                      'Pilih Meja',
                      style: AppTypography.headlineSmall.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Material(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(16),
                      child: InkWell(
                        onTap: _openTableSelector,
                        borderRadius: BorderRadius.circular(16),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.borderSubtle, width: 1.2),
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.group_rounded,
                                color: AppColors.textPrimary,
                                size: 20,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(
                                  booking.selectedTable != null
                                      ? '${booking.selectedTable!.name} (Kapasitas: ${booking.selectedTable!.capacity} orang)'
                                      : 'Meja 1-8',
                                  style: AppTypography.titleSmall.copyWith(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 14,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.keyboard_arrow_down_rounded,
                                color: AppColors.textSecondary,
                                size: 22,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),

            // Bottom Sticky Payment Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              decoration: BoxDecoration(
                color: AppColors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: SafeArea(
                top: false,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Pembayaran',
                              style: AppTypography.bodySmall.copyWith(
                                color: AppColors.textSecondary,
                                fontSize: 12,
                              ),
                            ),
                            if (booking.isPromoApplied)
                              Text(
                                'Diskon 20% (-${CurrencyFormatter.format(booking.discountAmount)})',
                                style: AppTypography.bodySmall.copyWith(
                                  color: AppColors.terracotta,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                          ],
                        ),
                        Text(
                          CurrencyFormatter.format(booking.grandTotal),
                          style: AppTypography.priceLarge.copyWith(
                            fontSize: 18,
                            fontWeight: FontWeight.w800,
                            color: AppColors.textPrimary,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    AlvaranTerracottaButton(
                      label: 'Lanjutkan Pembayaran',
                      isLoading: _isProcessingPayment,
                      onPressed: _handlePayment,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
