import '../models/category_model.dart';

class CategoriesData {
  // Use your computer's IP address instead of localhost for mobile/emulator
  // You can find your IP by running 'ipconfig' on Windows or 'ifconfig' on Mac/Linux
  static const String baseUrl =
      'http://10.0.2.2:3000/api'; // For Android emulator
  // static const String baseUrl = 'http://localhost:3000/api'; // For web
  // static const String baseUrl = 'http://YOUR_COMPUTER_IP:3000/api'; // For physical device

  // Default categories for fallback
  static final List<CategoryModel> defaultCategories = [
    CategoryModel(id: 1, name: 'Vegetables', color: '#4CAF50'),
    CategoryModel(id: 2, name: 'Fruits', color: '#FF9800'),
    CategoryModel(id: 3, name: 'Meat', color: '#F44336'),
    CategoryModel(id: 4, name: 'Dairy', color: '#2196F3'),
    CategoryModel(id: 5, name: 'Bakery', color: '#795548'),
    CategoryModel(id: 6, name: 'Beverages', color: '#9C27B0'),
    CategoryModel(id: 7, name: 'Snacks', color: '#FFC107'),
    CategoryModel(id: 8, name: 'Household', color: '#607D8B'),
  ];

  // Helper method to get category by ID
  static CategoryModel? getCategoryById(
      List<CategoryModel> categories, int? id) {
    if (id == null) return null;
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  // Helper method to get category by name
  static CategoryModel? getCategoryByName(
      List<CategoryModel> categories, String name) {
    try {
      return categories.firstWhere(
          (category) => category.name.toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  // Helper method to get category color
  static String getCategoryColor(
      List<CategoryModel> categories, int? categoryId) {
    final category = getCategoryById(categories, categoryId);
    return category?.color ?? '#9E9E9E'; // Default gray color
  }

  // Helper method to get category name
  static String getCategoryName(
      List<CategoryModel> categories, int? categoryId) {
    final category = getCategoryById(categories, categoryId);
    return category?.name ?? 'Uncategorized';
  }
}
