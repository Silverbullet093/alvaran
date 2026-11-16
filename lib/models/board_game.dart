class BoardGame {
  final String id;
  final String title;
  final String category;
  final String description;
  final String playerCount;
  final int playTimeMinutes;
  final String difficulty;
  final double rating;
  final String imageUrl;
  final bool isPopular;
  final int availableCopies;

  const BoardGame({
    required this.id,
    required this.title,
    required this.category,
    required this.description,
    required this.playerCount,
    required this.playTimeMinutes,
    required this.difficulty,
    required this.rating,
    required this.imageUrl,
    this.isPopular = false,
    this.availableCopies = 3,
  });

  static List<BoardGame> initialGames() {
    return const [
      BoardGame(
        id: 'catan',
        title: 'Catan',
        category: 'Strategy',
        description:
            'Bangun pemukiman, kota, dan jalan di pulau Catan yang belum dijelajahi. Kumpulkan dan tukar sumber daya gandum, kayu, bata, batu, dan domba untuk mencapai kemenangan!',
        playerCount: '3-4 Pemain',
        playTimeMinutes: 75,
        difficulty: 'Medium',
        rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1610890716171-6b1bb98ffd09?auto=format&fit=crop&w=600&q=80',
        isPopular: true,
        availableCopies: 4,
      ),
      BoardGame(
        id: 'carcassonne',
        title: 'Carcassonne',
        category: 'Tile Placement',
        description:
            'Game menyusun ubin benteng klasik dari Prancis abad pertengahan. Tempatkan meeple pengikut Anda sebagai ksatria, biarawan, petani, atau perampok.',
        playerCount: '2-5 Pemain',
        playTimeMinutes: 45,
        difficulty: 'Easy-Medium',
        rating: 4.8,
        imageUrl: 'https://images.unsplash.com/photo-1632516643720-e7f5d7d6ecc9?auto=format&fit=crop&w=600&q=80',
        isPopular: true,
        availableCopies: 3,
      ),
      BoardGame(
        id: 'dixit',
        title: 'Dixit',
        category: 'Party / Storytelling',
        description:
            'Game kartu imajinatif dengan ilustrasi surealis yang memukau. Berikan petunjuk kreatif dan tebak kartu pencerita tanpa membuat semua orang mengetahuinya.',
        playerCount: '3-8 Pemain',
        playTimeMinutes: 30,
        difficulty: 'Easy',
        rating: 4.7,
        imageUrl: 'https://images.unsplash.com/photo-1563941402622-4e7a488bcc57?auto=format&fit=crop&w=600&q=80',
        isPopular: true,
        availableCopies: 5,
      ),
      BoardGame(
        id: 'ticket_to_ride',
        title: 'Ticket to Ride',
        category: 'Family / Strategy',
        description:
            'Petualangan kereta api lintas benua! Kumpulkan kartu gerbong dan hubungkan kota-kota ikonik dengan rute rel kereta Anda.',
        playerCount: '2-5 Pemain',
        playTimeMinutes: 60,
        difficulty: 'Easy',
        rating: 4.8,
        imageUrl: 'https://images.unsplash.com/photo-1543857778-c4a1a3e0b2eb?auto=format&fit=crop&w=600&q=80',
        isPopular: true,
        availableCopies: 2,
      ),
      BoardGame(
        id: 'azul',
        title: 'Azul',
        category: 'Abstract Strategy',
        description:
            'Hiasi dinding istana Raja Manuel I dengan ubin keramik indah bermotif Moor. Rencanakan tata letak ubin untuk mendapatkan poin maksimum.',
        playerCount: '2-4 Pemain',
        playTimeMinutes: 40,
        difficulty: 'Medium',
        rating: 4.9,
        imageUrl: 'https://images.unsplash.com/photo-1606167668584-78701c57f13d?auto=format&fit=crop&w=600&q=80',
        isPopular: false,
        availableCopies: 3,
      ),
      BoardGame(
        id: 'exploding_kittens',
        title: 'Exploding Kittens',
        category: 'Card Game / Party',
        description:
            'Versi rolet Rusia dengan kucing yang meledak! Penuh tawa, pengkhianatan seru, dan aksi cepat dengan kartu laser pointer dan sandwich catnip.',
        playerCount: '2-5 Pemain',
        playTimeMinutes: 15,
        difficulty: 'Very Easy',
        rating: 4.6,
        imageUrl: 'https://images.unsplash.com/photo-1585504198199-20277593b94f?auto=format&fit=crop&w=600&q=80',
        isPopular: false,
        availableCopies: 4,
      ),
    ];
  }
}
