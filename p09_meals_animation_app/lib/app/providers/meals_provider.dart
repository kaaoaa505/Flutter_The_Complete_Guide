import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:p07_meals_app/app/data/meals_data.dart';

final mealsProvider = Provider((ref) {
  return mealsData;
});
