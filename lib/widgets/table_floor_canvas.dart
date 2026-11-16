import 'package:flutter/material.dart';
import '../models/table_model.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';

class TableFloorCanvas extends StatelessWidget {
  final List<TableModel> tables;
  final TableModel? selectedTable;
  final ValueChanged<TableModel> onSelectTable;

  const TableFloorCanvas({
    super.key,
    required this.tables,
    required this.selectedTable,
    required this.onSelectTable,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFECDBC7), // Warm wooden parquet floor
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xFFC7B198), width: 2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(22),
        child: Stack(
          children: [
            // Background wood parquet lines & potted corner plants
            CustomPaint(
              size: const Size(double.infinity, 380),
              painter: _FloorDetailsPainter(),
            ),

            // 8 Tables Grid
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildTableRow(tables[0], tables[1]),
                  const SizedBox(height: 18),
                  _buildTableRow(tables[2], tables[3]),
                  const SizedBox(height: 18),
                  _buildTableRow(tables[4], tables[5]),
                  const SizedBox(height: 18),
                  _buildTableRow(tables[6], tables[7]),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTableRow(TableModel leftTable, TableModel rightTable) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildTableWidget(leftTable),
        _buildTableWidget(rightTable),
      ],
    );
  }

  Widget _buildTableWidget(TableModel table) {
    final isSelected = selectedTable?.id == table.id;
    final isAvailable = table.isAvailable;

    Color tableColor;
    Color chairColor;
    Color textColor;

    if (!isAvailable) {
      // Occupied (Red / Terracotta)
      tableColor = const Color(0xFFC9543A);
      chairColor = const Color(0xFFA13E28);
      textColor = AppColors.white;
    } else if (isSelected) {
      // Selected (Forest Green active)
      tableColor = const Color(0xFF2C6B4F);
      chairColor = const Color(0xFF1B4E38);
      textColor = AppColors.white;
    } else {
      // Available (Warm Wood)
      tableColor = const Color(0xFFB57D49);
      chairColor = const Color(0xFF8E5E32);
      textColor = AppColors.white;
    }

    return GestureDetector(
      onTap: () => onSelectTable(table),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Top 2 chairs
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildChair(chairColor),
              const SizedBox(width: 14),
              _buildChair(chairColor),
            ],
          ),
          const SizedBox(height: 3),

          // Main Tabletop
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 78,
            height: 48,
            decoration: BoxDecoration(
              color: tableColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: isSelected ? AppColors.gold : Colors.black.withValues(alpha: 0.15),
                width: isSelected ? 2.5 : 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: isSelected
                      ? AppColors.gold.withValues(alpha: 0.4)
                      : Colors.black.withValues(alpha: 0.12),
                  blurRadius: isSelected ? 10 : 4,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Center(
              child: Container(
                width: 24,
                height: 24,
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.2),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    table.number.toString(),
                    style: TextStyle(
                      color: textColor,
                      fontWeight: FontWeight.w800,
                      fontSize: 13,
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 3),

          // Bottom 2 chairs
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildChair(chairColor),
              const SizedBox(width: 14),
              _buildChair(chairColor),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildChair(Color color) {
    return Container(
      width: 18,
      height: 6,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 2,
            offset: const Offset(0, 1),
          ),
        ],
      ),
    );
  }
}

class _FloorDetailsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final plankPaint = Paint()
      ..color = const Color(0xFFDEC7AE).withValues(alpha: 0.6)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Draw vertical plank lines
    final plankWidth = size.width / 8;
    for (double x = plankWidth; x < size.width; x += plankWidth) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), plankPaint);
    }

    // Corner decorative potted plants
    _drawPlant(canvas, const Offset(18, 18));
    _drawPlant(canvas, Offset(size.width - 18, 18));
    _drawPlant(canvas, Offset(18, size.height - 18));
    _drawPlant(canvas, Offset(size.width - 18, size.height - 18));
  }

  void _drawPlant(Canvas canvas, Offset center) {
    // Pot
    final potPaint = Paint()..color = const Color(0xFFC76B42);
    canvas.drawCircle(center, 9, potPaint);

    // Leaves
    final leafPaint = Paint()..color = const Color(0xFF2C6B4F);
    for (int i = 0; i < 5; i++) {
      final angle = (i * 72) * 3.14159 / 180;
      final lx = center.dx + 8 * (angle.abs() > 0 ? 1 : 0);
      final ly = center.dy + 8 * (angle.abs() > 0 ? 1 : 0);
      canvas.drawCircle(Offset(center.dx + 5 * (i % 2 == 0 ? 1 : -1), center.dy + 5 * (i > 2 ? 1 : -1)), 4, leafPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
