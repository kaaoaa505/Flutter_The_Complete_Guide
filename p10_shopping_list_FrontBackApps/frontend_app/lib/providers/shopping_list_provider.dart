import 'package:flutter/foundation.dart';
import '../models/category_model.dart';
import '../models/grocery_item_model.dart';
import '../services/api_service.dart';

class ShoppingListProvider with ChangeNotifier {
  List<CategoryModel> _categories = [];
  List<GroceryItemModel> _groceryItems = [];
  bool _isLoading = false;
  String? _error;

  // Getters
  List<CategoryModel> get categories => _categories;
  List<GroceryItemModel> get groceryItems => _groceryItems;
  bool get isLoading => _isLoading;
  String? get error => _error;

  // Get completed and pending items
  List<GroceryItemModel> get completedItems =>
      _groceryItems.where((item) => item.isCompleted).toList();
  List<GroceryItemModel> get pendingItems =>
      _groceryItems.where((item) => !item.isCompleted).toList();

  // Initialize data
  Future<void> initializeData() async {
    await Future.wait([
      loadCategories(),
      loadGroceryItems(),
    ]);
  }

  // Load categories
  Future<void> loadCategories() async {
    _setLoading(true);
    try {
      _categories = await ApiService.getCategories();
      _error = null;
    } catch (e) {
      _error = e.toString();
      print('Error loading categories: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Load grocery items
  Future<void> loadGroceryItems() async {
    _setLoading(true);
    try {
      _groceryItems = await ApiService.getGroceryItems();
      _error = null;
    } catch (e) {
      _error = e.toString();
      print('Error loading grocery items: $e');
    } finally {
      _setLoading(false);
    }
  }

  // Add new grocery item
  Future<void> addGroceryItem(
      String name, int quantity, int? categoryId) async {
    try {
      final newItem =
          await ApiService.createGroceryItem(name, quantity, categoryId);
      _groceryItems.insert(0, newItem);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      throw e;
    }
  }

  // Update grocery item
  Future<void> updateGroceryItem(GroceryItemModel item) async {
    try {
      await ApiService.updateGroceryItem(
        item.id!,
        item.name,
        item.quantity,
        item.categoryId,
        item.isCompleted,
      );

      final index =
          _groceryItems.indexWhere((element) => element.id == item.id);
      if (index != -1) {
        _groceryItems[index] = item;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      throw e;
    }
  }

  // Delete grocery item
  Future<void> deleteGroceryItem(int id) async {
    try {
      await ApiService.deleteGroceryItem(id);
      _groceryItems.removeWhere((item) => item.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      throw e;
    }
  }

  // Toggle item completion
  Future<void> toggleItemCompletion(int id) async {
    try {
      final isCompleted = await ApiService.toggleGroceryItem(id);
      final index = _groceryItems.indexWhere((item) => item.id == id);
      if (index != -1) {
        _groceryItems[index] =
            _groceryItems[index].copyWith(isCompleted: isCompleted);
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      throw e;
    }
  }

  // Add new category
  Future<void> addCategory(String name, String color) async {
    try {
      final newCategory = await ApiService.createCategory(name, color);
      _categories.add(newCategory);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      throw e;
    }
  }

  // Helper methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void clearError() {
    _error = null;
    notifyListeners();
  }

  // Get category by ID
  CategoryModel? getCategoryById(int? id) {
    if (id == null) return null;
    try {
      return _categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  // Get items by category
  List<GroceryItemModel> getItemsByCategory(int? categoryId) {
    return _groceryItems
        .where((item) => item.categoryId == categoryId)
        .toList();
  }
}
