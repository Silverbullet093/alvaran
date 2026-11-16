import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import '../theme/app_typography.dart';
import '../utils/date_formatter.dart';

class DateSelectorStrip extends StatefulWidget {
  final DateTime selectedDate;
  final ValueChanged<DateTime> onDateSelected;

  const DateSelectorStrip({
    super.key,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  State<DateSelectorStrip> createState() => _DateSelectorStripState();
}

class _DateSelectorStripState extends State<DateSelectorStrip> {
  late DateTime _currentMonth;

  @override
  void initState() {
    super.initState();
    _currentMonth = DateTime(widget.selectedDate.year, widget.selectedDate.month, 1);
  }

  void _previousMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month - 1, 1);
    });
  }

  void _nextMonth() {
    setState(() {
      _currentMonth = DateTime(_currentMonth.year, _currentMonth.month + 1, 1);
    });
  }

  @override
  Widget build(BuildContext context) {
    // Generate the 7 days centered or ending on day 24 matching the mockup:
    // Min 18, Sen 19, Sel 20, Rab 21, Kam 22, Jum 23, Sab 24 (Mei 2025)
    final daysInWeek = List.generate(7, (index) {
      final dayNumber = 18 + index;
      return DateTime(_currentMonth.year, _currentMonth.month, dayNumber);
    });

    final dayLabels = ['Min', 'Sen', 'Sel', 'Rab', 'Kam', 'Jum', 'Sab'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Month Selector Bar: <  Mei 2025  >
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: _previousMonth,
              borderRadius: BorderRadius.circular(20),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.chevron_left_rounded,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Text(
              DateFormatter.formatMonthYear(_currentMonth),
              style: AppTypography.titleMedium.copyWith(
                fontWeight: FontWeight.w700,
                fontSize: 15,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(width: 8),
            InkWell(
              onTap: _nextMonth,
              borderRadius: BorderRadius.circular(20),
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(
                  Icons.chevron_right_rounded,
                  size: 20,
                  color: AppColors.textPrimary,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),

        // Day labels row (Min, Sen, Sel, Rab, Kam, Jum, Sab)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: dayLabels.map((label) {
            return SizedBox(
              width: 38,
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: AppTypography.bodySmall.copyWith(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textSecondary,
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: 8),

        // Day numbers row (18, 19, 20, 21, 22, 23, 24)
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: daysInWeek.map((date) {
            final isSelected = date.year == widget.selectedDate.year &&
                date.month == widget.selectedDate.month &&
                date.day == widget.selectedDate.day;

            return InkWell(
              onTap: () => widget.onDateSelected(date),
              borderRadius: BorderRadius.circular(20),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 38,
                height: 38,
                decoration: BoxDecoration(
                  color: isSelected ? AppColors.forestGreen : Colors.transparent,
                  shape: BoxShape.circle,
                  boxShadow: isSelected
                      ? [
                          BoxShadow(
                            color: AppColors.forestGreen.withValues(alpha: 0.35),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ]
                      : null,
                ),
                child: Center(
                  child: Text(
                    date.day.toString(),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                      color: isSelected ? AppColors.white : AppColors.textPrimary,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
