class DateFormatter {
  DateFormatter._();

  static const List<String> _dayNames = [
    'Senin',
    'Selasa',
    'Rabu',
    'Kamis',
    'Jumat',
    'Sabtu',
    'Minggu',
  ];

  static const List<String> _shortDayNames = [
    'Sen',
    'Sel',
    'Rab',
    'Kam',
    'Jum',
    'Sab',
    'Min',
  ];

  static const List<String> _monthNames = [
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    'Juli',
    'Agustus',
    'September',
    'Oktober',
    'November',
    'Desember',
  ];

  static String formatFullIndonesian(DateTime date) {
    final dayName = _dayNames[date.weekday - 1];
    final monthName = _monthNames[date.month - 1];
    return '$dayName, ${date.day} $monthName ${date.year}';
  }

  static String formatShortDay(DateTime date) {
    return _shortDayNames[date.weekday - 1];
  }

  static String formatMonthYear(DateTime date) {
    final monthName = _monthNames[date.month - 1];
    return '$monthName ${date.year}';
  }

  static String formatDayMonth(DateTime date) {
    final monthName = _monthNames[date.month - 1];
    return '${date.day} $monthName ${date.year}';
  }
}
