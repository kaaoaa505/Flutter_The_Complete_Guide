import 'package:flutter/material.dart';

class CategoryModel {
  CategoryModel({
    required this.id,
    required this.title,
    this.color = Colors.orangeAccent,
  });
  
  late final String id;
  late final String title;
  late final Color color;
}
