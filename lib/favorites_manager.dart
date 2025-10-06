import 'package:flutter/material.dart';

class FavoritesManager extends ChangeNotifier {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final List<Map<String, dynamic>> _favoriteItems = [];

  List<Map<String, dynamic>> get favoriteItems => List.unmodifiable(_favoriteItems);

  // Changed from int to dynamic to handle both String and int IDs
  bool isFavorite(dynamic productId) {
    // Convert to string for comparison to handle both types
    final idString = productId.toString();
    return _favoriteItems.any((item) => item['id'].toString() == idString);
  }

  void toggleFavorite(Map<String, dynamic> product) {
    // Convert to string for comparison
    final productIdString = product['id'].toString();
    final index = _favoriteItems.indexWhere((item) => item['id'].toString() == productIdString);
    
    if (index != -1) {
      // Remove from favorites
      _favoriteItems.removeAt(index);
    } else {
      // Add to favorites
      _favoriteItems.add(product);
    }
    
    notifyListeners();
  }

  void removeFavorite(Map<String, dynamic> product) {
    final productIdString = product['id'].toString();
    _favoriteItems.removeWhere((item) => item['id'].toString() == productIdString);
    notifyListeners();
  }

  int get count => _favoriteItems.length;
}