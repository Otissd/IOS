import 'package:flutter/material.dart';

import '../models/genre.dart';
import '../services/api/genre_api.dart';

class ItemProvider with ChangeNotifier {
  final GenreApi apiService;
  List<Genre> _items = [];
  bool _isLoading = false;

  ItemProvider(this.apiService);

  List<Genre> get items => _items;
  bool get isLoading => _isLoading;

  Future<void> loadItems() async {
    _isLoading = true;
    notifyListeners();

    try {
      _items = await apiService.fetchItems();
    } catch (e) {
      // Handle errors here
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
   Future<Genre?> getItemById(int id) async {
    try {
      return await apiService.fetchItemsById(id);
    } catch (e) {
      return null; // Xử lý lỗi nếu cần
    }
  }
}

 
