class PassType {
  final String id;
  final String name;
  final String description;
  final int weekdayPrice;
  final int weekendPrice;
  final String iconBadge;
  final bool isHourly;

  const PassType({
    required this.id,
    required this.name,
    required this.description,
    required this.weekdayPrice,
    required this.weekendPrice,
    required this.iconBadge,
    this.isHourly = false,
  });

  /// Mengambil harga sesuai jenis hari (Senin-Jumat vs Sabtu-Minggu)
  int getPrice(bool isWeekend) => isWeekend ? weekendPrice : weekdayPrice;

  int get price => weekendPrice; // Fallback kompatibilitas

  // 1. All Day Pass (Main Seharian Penuh)
  // Senin - Jumat : 40rb / All Day / orang
  // Sabtu - Minggu: 50rb / All Day / orang
  static const PassType allDay = PassType(
    id: 'all_day',
    name: 'All Day Pass',
    description: 'Main bebas seharian sepuasnya tanpa batas waktu',
    weekdayPrice: 40000,
    weekendPrice: 50000,
    iconBadge: 'sun',
    isHourly: false,
  );

  // 2. Hourly Pass (Per Jam)
  // Senin - Jumat : 10rb / jam / orang
  // Sabtu - Minggu: 15rb / jam / orang
  static const PassType hourly = PassType(
    id: 'hourly',
    name: 'Hourly Pass (Per Jam)',
    description: 'Bermain fleksibel dihitung per jam per orang',
    weekdayPrice: 10000,
    weekendPrice: 15000,
    iconBadge: 'clock',
    isHourly: true,
  );

  // Alias untuk Regular Pass dari mockup (All Day)
  static const PassType regular = allDay;

  static const List<PassType> availablePasses = [
    allDay,
    hourly,
  ];
}
