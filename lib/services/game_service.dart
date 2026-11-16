import 'package:flutter/foundation.dart';
import '../models/board_game.dart';
import '../models/cafe_event.dart';

class GameService extends ChangeNotifier {
  final List<BoardGame> _games = BoardGame.initialGames();
  final List<CafeEvent> _events = CafeEvent.initialEvents();

  String _searchQuery = '';
  String _selectedCategory = 'Semua';

  List<String> get categories => [
        'Semua',
        'Strategy',
        'Tile Placement',
        'Party / Storytelling',
        'Family / Strategy',
        'Abstract Strategy',
        'Card Game / Party',
      ];

  List<BoardGame> get popularGames =>
      _games.where((game) => game.isPopular).toList();

  List<BoardGame> get allGames {
    return _games.where((game) {
      final matchesQuery = _searchQuery.isEmpty ||
          game.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          game.description.toLowerCase().contains(_searchQuery.toLowerCase());

      final matchesCategory = _selectedCategory == 'Semua' ||
          game.category.toLowerCase().contains(_selectedCategory.toLowerCase());

      return matchesQuery && matchesCategory;
    }).toList();
  }

  List<CafeEvent> get events => List.unmodifiable(_events);
  CafeEvent get featuredEvent => _events.first;

  String get searchQuery => _searchQuery;
  String get selectedCategory => _selectedCategory;

  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void selectCategory(String category) {
    _selectedCategory = category;
    notifyListeners();
  }
}
