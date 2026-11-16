import 'package:flutter/foundation.dart';
import '../models/user_profile.dart';

class UserService extends ChangeNotifier {
  UserProfile _user = UserProfile.defaultUser();

  UserProfile get user => _user;

  void updateProfile({
    required String fullName,
    required String email,
    required String phone,
  }) {
    _user = _user.copyWith(
      fullName: fullName,
      email: email,
      phone: phone,
    );
    notifyListeners();
  }

  void incrementReviewCount() {
    _user = _user.copyWith(userReviewsCount: _user.userReviewsCount + 1);
    notifyListeners();
  }

  void incrementTicketCount() {
    _user = _user.copyWith(savedTicketsCount: _user.savedTicketsCount + 1);
    notifyListeners();
  }
}
