import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/category_model.dart';
import '../models/grocery_item_model.dart';
import '../data/categories_data.dart';

class ApiService {
  static const String baseUrl = CategoriesData.baseUrl;

  // Categories API
  static Future<List<CategoryModel>> getCategories() async {
    try {
      print('Attempting to fetch categories from: $baseUrl/categories');
      final response = await http.get(Uri.parse('$baseUrl/categories'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => CategoryModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load categories: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching categories: $e');
      print('Full error details: ${e.toString()}');
      // Return default categories as fallback
      return CategoriesData.defaultCategories;
    }
  }

  static Future<CategoryModel> createCategory(String name, String color) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/categories'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'name': name, 'color': color}),
      );

      if (response.statusCode == 200) {
        return CategoryModel.fromJson(json.decode(response.body));
      } else if (response.statusCode == 409) {
        final errorData = json.decode(response.body);
        throw Exception(
            errorData['error'] ?? 'Category with this name already exists');
      } else {
        throw Exception('Failed to create category: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating category: $e');
    }
  }

  // Grocery Items API
  static Future<List<GroceryItemModel>> getGroceryItems() async {
    try {
      print('Attempting to fetch grocery items from: $baseUrl/grocery-items');
      final response = await http.get(Uri.parse('$baseUrl/grocery-items'));

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((json) => GroceryItemModel.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load grocery items: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching grocery items: $e');
      print('Full error details: ${e.toString()}');
      return [];
    }
  }

  static Future<GroceryItemModel> createGroceryItem(
      String name, int quantity, int? categoryId) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/grocery-items'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'quantity': quantity,
          'category_id': categoryId,
        }),
      );

      if (response.statusCode == 200) {
        return GroceryItemModel.fromJson(json.decode(response.body));
      } else {
        throw Exception(
            'Failed to create grocery item: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating grocery item: $e');
    }
  }

  static Future<void> updateGroceryItem(int id, String name, int quantity,
      int? categoryId, bool isCompleted) async {
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/grocery-items/$id'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'name': name,
          'quantity': quantity,
          'category_id': categoryId,
          'is_completed': isCompleted,
        }),
      );

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to update grocery item: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error updating grocery item: $e');
    }
  }

  static Future<void> deleteGroceryItem(int id) async {
    try {
      final response =
          await http.delete(Uri.parse('$baseUrl/grocery-items/$id'));

      if (response.statusCode != 200) {
        throw Exception(
            'Failed to delete grocery item: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error deleting grocery item: $e');
    }
  }

  static Future<bool> toggleGroceryItem(int id) async {
    try {
      final response =
          await http.patch(Uri.parse('$baseUrl/grocery-items/$id/toggle'));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        return data['is_completed'] ?? false;
      } else {
        throw Exception(
            'Failed to toggle grocery item: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error toggling grocery item: $e');
    }
  }
}
