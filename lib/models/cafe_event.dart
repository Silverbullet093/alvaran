class CafeEvent {
  final String id;
  final String title;
  final String subtitle;
  final String dateText;
  final String time;
  final String description;
  final String badgeText;

  const CafeEvent({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.dateText,
    required this.time,
    required this.description,
    required this.badgeText,
  });

  static List<CafeEvent> initialEvents() {
    return const [
      CafeEvent(
        id: 'evt-1',
        title: 'Board Game Night Live Event',
        subtitle: 'Turnamen & Komunitas',
        dateText: 'Sab, 24 Mei 2025',
        time: '18:30 - 22:30 WIB',
        description:
            'Ajang kumpul seru para pecinta board game se-Jabodetabek! Hadiah turnamen Catan & Ticket to Ride jutaan rupiah, free snack, dan sesi panduan game master.',
        badgeText: 'Live Event',
      ),
      CafeEvent(
        id: 'evt-2',
        title: 'D&D One-Shot Adventure',
        subtitle: 'Role Playing Game',
        dateText: 'Min, 25 Mei 2025',
        time: '14:00 - 18:00 WIB',
        description:
            'Sesi Dungeons & Dragons ramah pemula dipandu Dungeon Master berpengalaman. Sudah termasuk lembar karakter dan dadu.',
        badgeText: 'RPG Special',
      ),
    ];
  }
}
