import '../models/category_model.dart';

class CategoriesData {
  static const String baseUrl = 'http://localhost:3000/api';

  // Default categories for fallback
  static final List<Category> defaultCategories = [
    Category(id: 1, name: 'Vegetables', color: '#4CAF50'),
    Category(id: 2, name: 'Fruits', color: '#FF9800'),
    Category(id: 3, name: 'Meat', color: '#F44336'),
    Category(id: 4, name: 'Dairy', color: '#2196F3'),
    Category(id: 5, name: 'Bakery', color: '#795548'),
    Category(id: 6, name: 'Beverages', color: '#9C27B0'),
    Category(id: 7, name: 'Snacks', color: '#FFC107'),
    Category(id: 8, name: 'Household', color: '#607D8B'),
  ];

  // Helper method to get category by ID
  static Category? getCategoryById(List<Category> categories, int? id) {
    if (id == null) return null;
    try {
      return categories.firstWhere((category) => category.id == id);
    } catch (e) {
      return null;
    }
  }

  // Helper method to get category by name
  static Category? getCategoryByName(List<Category> categories, String name) {
    try {
      return categories.firstWhere(
          (category) => category.name.toLowerCase() == name.toLowerCase());
    } catch (e) {
      return null;
    }
  }

  // Helper method to get category color
  static String getCategoryColor(List<Category> categories, int? categoryId) {
    final category = getCategoryById(categories, categoryId);
    return category?.color ?? '#9E9E9E'; // Default gray color
  }

  // Helper method to get category name
  static String getCategoryName(List<Category> categories, int? categoryId) {
    final category = getCategoryById(categories, categoryId);
    return category?.name ?? 'Uncategorized';
  }
}
