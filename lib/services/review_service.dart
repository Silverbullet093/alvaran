import 'package:flutter/foundation.dart';
import '../models/review_model.dart';

enum ReviewSortOption {
  latest('Terbaru'),
  highest('Rating Tertinggi'),
  lowest('Rating Terendah');

  final String label;
  const ReviewSortOption(this.label);
}

class ReviewService extends ChangeNotifier {
  final List<ReviewModel> _reviews = ReviewModel.initialReviews();
  ReviewSortOption _sortOption = ReviewSortOption.latest;
  int? _ratingFilter; // null = all

  List<ReviewModel> get reviews {
    var list = List<ReviewModel>.from(_reviews);
    if (_ratingFilter != null) {
      list = list.where((r) => r.rating.round() == _ratingFilter).toList();
    }

    switch (_sortOption) {
      case ReviewSortOption.latest:
        list.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        break;
      case ReviewSortOption.highest:
        list.sort((a, b) => b.rating.compareTo(a.rating));
        break;
      case ReviewSortOption.lowest:
        list.sort((a, b) => a.rating.compareTo(b.rating));
        break;
    }
    return list;
  }

  ReviewSortOption get currentSort => _sortOption;
  int? get currentRatingFilter => _ratingFilter;

  int get totalReviewsCount => 2530; // Matches "(2.5k ulasan)" in mockup

  double get averageRating => 4.8;

  // Star distribution percentages (matches visual mockup bars)
  Map<int, double> get starDistribution => {
        5: 0.85,
        4: 0.25,
        3: 0.08,
        2: 0.02,
        1: 0.03,
      };

  void setSortOption(ReviewSortOption option) {
    _sortOption = option;
    notifyListeners();
  }

  void setRatingFilter(int? rating) {
    _ratingFilter = rating;
    notifyListeners();
  }

  void toggleLike(String reviewId) {
    final index = _reviews.indexWhere((r) => r.id == reviewId);
    if (index != -1) {
      final current = _reviews[index];
      final isLiked = !current.isLikedByUser;
      final newLikes = isLiked ? current.likesCount + 1 : current.likesCount - 1;
      _reviews[index] = current.copyWith(
        isLikedByUser: isLiked,
        likesCount: newLikes,
      );
      notifyListeners();
    }
  }

  void addReview({
    required String authorName,
    required double rating,
    required String comment,
  }) {
    final newReview = ReviewModel(
      id: 'rev-${DateTime.now().millisecondsSinceEpoch}',
      authorName: authorName,
      rating: rating,
      timeAgo: 'Baru saja',
      comment: comment,
      likesCount: 1,
      isLikedByUser: true,
      createdAt: DateTime.now(),
    );

    _reviews.insert(0, newReview);
    notifyListeners();
  }
}
