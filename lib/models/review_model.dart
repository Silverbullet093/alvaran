class ReviewModel {
  final String id;
  final String authorName;
  final String? avatarUrl;
  final double rating;
  final String timeAgo;
  final String comment;
  final int likesCount;
  final bool isLikedByUser;
  final DateTime createdAt;

  const ReviewModel({
    required this.id,
    required this.authorName,
    this.avatarUrl,
    required this.rating,
    required this.timeAgo,
    required this.comment,
    required this.likesCount,
    this.isLikedByUser = false,
    required this.createdAt,
  });

  ReviewModel copyWith({
    String? id,
    String? authorName,
    String? avatarUrl,
    double? rating,
    String? timeAgo,
    String? comment,
    int? likesCount,
    bool? isLikedByUser,
    DateTime? createdAt,
  }) {
    return ReviewModel(
      id: id ?? this.id,
      authorName: authorName ?? this.authorName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      rating: rating ?? this.rating,
      timeAgo: timeAgo ?? this.timeAgo,
      comment: comment ?? this.comment,
      likesCount: likesCount ?? this.likesCount,
      isLikedByUser: isLikedByUser ?? this.isLikedByUser,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  // Initial mockup reviews
  static List<ReviewModel> initialReviews() {
    return [
      ReviewModel(
        id: 'rev-1',
        authorName: 'Sarah Wijaya',
        rating: 5.0,
        timeAgo: '2 hari yang lalu',
        comment: 'Tempatnya nyaman, gamenya lengkap banget! 🎲',
        likesCount: 124,
        createdAt: DateTime.now().subtract(const Duration(days: 2)),
      ),
      ReviewModel(
        id: 'rev-2',
        authorName: 'Rizky Pratama',
        rating: 5.0,
        timeAgo: '1 minggu yang lalu',
        comment: 'Pelayanan ramah dan suasana seru. Recommended!',
        likesCount: 89,
        createdAt: DateTime.now().subtract(const Duration(days: 7)),
      ),
      ReviewModel(
        id: 'rev-3',
        authorName: 'Dewi Anggraini',
        rating: 5.0,
        timeAgo: '2 minggu yang lalu',
        comment: 'Suka banget main di sini!',
        likesCount: 72,
        createdAt: DateTime.now().subtract(const Duration(days: 14)),
      ),
      ReviewModel(
        id: 'rev-4',
        authorName: 'Budi Santoso',
        rating: 4.0,
        timeAgo: '3 minggu yang lalu',
        comment: 'Koleksi board game seru dan makanan enak. Meja nyaman untuk grup besar.',
        likesCount: 45,
        createdAt: DateTime.now().subtract(const Duration(days: 21)),
      ),
    ];
  }
}
