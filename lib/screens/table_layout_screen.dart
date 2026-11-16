import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/table_model.dart';
import '../services/booking_service.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../widgets/alvaran_app_bar.dart';
import '../widgets/table_floor_canvas.dart';
import '../widgets/status_badge.dart';
import '../widgets/alvaran_buttons.dart';

class TableLayoutScreen extends StatefulWidget {
  final VoidCallback? onBack;
  final bool showBackButton;

  const TableLayoutScreen({
    super.key,
    this.onBack,
    this.showBackButton = true,
  });

  @override
  State<TableLayoutScreen> createState() => _TableLayoutScreenState();
}

class _TableLayoutScreenState extends State<TableLayoutScreen> {
  TableModel? _inspectedTable;

  @override
  void initState() {
    super.initState();
    final booking = context.read<BookingService>();
    _inspectedTable = booking.selectedTable ?? booking.tables.first;
  }

  void _confirmTableReservation() {
    if (_inspectedTable == null || !_inspectedTable!.isAvailable) return;

    final booking = context.read<BookingService>();
    booking.selectTable(_inspectedTable!);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${_inspectedTable!.name} berhasil dipilih untuk reservasi!'),
        backgroundColor: AppColors.forestGreen,
        behavior: SnackBarBehavior.floating,
      ),
    );

    if (widget.onBack != null) {
      widget.onBack!();
    } else if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final booking = context.watch<BookingService>();
    final activeTable = _inspectedTable ?? booking.selectedTable ?? booking.tables.first;

    return Scaffold(
      backgroundColor: AppColors.cream,
      appBar: AlvaranSubAppBar(
        title: 'Table Layout',
        showBackButton: widget.showBackButton,
        onBack: widget.onBack,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Legend bar: Tersedia (green) | Terisi (red)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem('Tersedia', AppColors.availableGreen),
                  const SizedBox(width: 28),
                  _buildLegendItem('Terisi', AppColors.occupiedRed),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Cafe Floor Plan View
            Expanded(
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 16),
                  child: TableFloorCanvas(
                    tables: booking.tables,
                    selectedTable: activeTable,
                    onSelectTable: (table) {
                      setState(() {
                        _inspectedTable = table;
                      });
                    },
                  ),
                ),
              ),
            ),

            // Bottom Floating Table Card matching mockup
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: AppColors.borderSubtle, width: 1.2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.06),
                    blurRadius: 16,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Table Title & Status Badge
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        activeTable.name,
                        style: AppTypography.headlineMedium.copyWith(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      activeTable.isAvailable
                          ? StatusBadge.available()
                          : StatusBadge.occupied(),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Capacity
                  Row(
                    children: [
                      const Icon(
                        Icons.person_rounded,
                        size: 16,
                        color: AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'Kapasitas: ${activeTable.capacity} orang',
                        style: AppTypography.bodySmall.copyWith(
                          fontSize: 13,
                          color: AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Button: Reservasi Meja
                  AlvaranPrimaryButton(
                    label: activeTable.isAvailable
                        ? 'Reservasi Meja'
                        : 'Meja Terisi (Pilih Meja Lain)',
                    onPressed: activeTable.isAvailable
                        ? _confirmTableReservation
                        : null,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLegendItem(String label, Color dotColor) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: dotColor,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: AppTypography.bodySmall.copyWith(
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ],
    );
  }
}
