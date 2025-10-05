import 'package:flutter/material.dart';

class FavoritesManager extends ChangeNotifier {
  static final FavoritesManager _instance = FavoritesManager._internal();
  factory FavoritesManager() => _instance;
  FavoritesManager._internal();

  final List<Map<String, dynamic>> _favoriteItems = [];

  List<Map<String, dynamic>> get favoriteItems => List.unmodifiable(_favoriteItems);

  bool isFavorite(int productId) {
    return _favoriteItems.any((item) => item['id'] == productId);
  }

  void toggleFavorite(Map<String, dynamic> product) {
    final index = _favoriteItems.indexWhere((item) => item['id'] == product['id']);
    
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
    _favoriteItems.removeWhere((item) => item['id'] == product['id']);
    notifyListeners();
  }

  int get count => _favoriteItems.length;
}