class UserProfile {
  final String id;
  final String fullName;
  final String email;
  final String phone;
  final String avatarUrl;
  final int savedTicketsCount;
  final int userReviewsCount;

  const UserProfile({
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.avatarUrl,
    required this.savedTicketsCount,
    required this.userReviewsCount,
  });

  UserProfile copyWith({
    String? id,
    String? fullName,
    String? email,
    String? phone,
    String? avatarUrl,
    int? savedTicketsCount,
    int? userReviewsCount,
  }) {
    return UserProfile(
      id: id ?? this.id,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      savedTicketsCount: savedTicketsCount ?? this.savedTicketsCount,
      userReviewsCount: userReviewsCount ?? this.userReviewsCount,
    );
  }

  static UserProfile defaultUser() {
    return const UserProfile(
      id: 'usr-001',
      fullName: 'Andi Pratama',
      email: 'andi.pratama@email.com',
      phone: '+62 812-3456-7890',
      avatarUrl: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=300&q=80',
      savedTicketsCount: 12,
      userReviewsCount: 3,
    );
  }
}
