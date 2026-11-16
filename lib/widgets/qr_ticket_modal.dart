import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../models/booking_ticket.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/date_formatter.dart';
import 'alvaran_buttons.dart';
import 'ticket_notch_card.dart';

class QrTicketModal extends StatelessWidget {
  final BookingTicket ticket;

  const QrTicketModal({
    super.key,
    required this.ticket,
  });

  static Future<void> show(BuildContext context, BookingTicket ticket) {
    return showDialog(
      context: context,
      barrierColor: AppColors.overlayDark,
      builder: (ctx) => QrTicketModal(ticket: ticket),
    );
  }

  @override
  Widget build(BuildContext context) {
    final formattedDate = DateFormatter.formatFullIndonesian(ticket.date);

    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Top Close X button
              Align(
                alignment: Alignment.topRight,
                child: InkWell(
                  onTap: () => Navigator.of(context).pop(),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.25),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.close_rounded,
                      color: AppColors.white,
                      size: 20,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),

              // The Notch Ticket Card
              TicketNotchCard(
                notchRadius: 14,
                notchYFraction: 0.18,
                backgroundColor: AppColors.cream,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 26),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Decorative Tickets graphic
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Transform.rotate(
                            angle: -0.15,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF2C6B4F),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.confirmation_number_rounded,
                                color: AppColors.cream,
                                size: 24,
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          Transform.rotate(
                            angle: 0.12,
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                              decoration: BoxDecoration(
                                color: AppColors.terracotta,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.local_activity_rounded,
                                color: AppColors.cream,
                                size: 24,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // QR Code Container with subtle card frame
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: AppColors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(color: AppColors.borderLight, width: 1.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 12,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: QrImageView(
                          data: ticket.qrPayload,
                          version: QrVersions.auto,
                          size: 170.0,
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
                      const SizedBox(height: 20),

                      // "Your Ticket"
                      Text(
                        'Your Ticket',
                        style: AppTypography.displaySmall.copyWith(
                          fontSize: 22,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 6),

                      // Pass and Visitors
                      Text(
                        ticket.formattedPassAndVisitors,
                        style: AppTypography.titleSmall.copyWith(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textSecondary,
                        ),
                      ),
                      const SizedBox(height: 4),

                      // Date and Time + Table Number
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.calendar_today_rounded,
                            size: 13,
                            color: AppColors.textMuted,
                          ),
                          const SizedBox(width: 5),
                          Text(
                            '$formattedDate · ${ticket.timeSlot}',
                            style: AppTypography.bodySmall.copyWith(
                              fontSize: 12,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Meja ${ticket.tableNumber} · ID: ${ticket.ticketCode}',
                        style: AppTypography.bodySmall.copyWith(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: AppColors.gold,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Action Button 1: Download Tiket
                      AlvaranPrimaryButton(
                        label: 'Download Tiket',
                        icon: Icons.download_rounded,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Tiket berhasil disimpan ke memori perangkat!'),
                              backgroundColor: AppColors.forestGreen,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 12),

                      // Action Button 2: Bagikan Tiket
                      AlvaranSecondaryButton(
                        label: 'Bagikan Tiket',
                        icon: Icons.share_rounded,
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Tautan tiket ${ticket.ticketCode} berhasil disalin!'),
                              backgroundColor: AppColors.forestGreen,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
