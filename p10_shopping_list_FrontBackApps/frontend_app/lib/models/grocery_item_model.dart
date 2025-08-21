class GroceryItemModel {
  final int? id;
  final String name;
  final int quantity;
  final int? categoryId;
  final String? categoryName;
  final String? categoryColor;
  final bool isCompleted;
  final String? createdAt;

  GroceryItemModel({
    this.id,
    required this.name,
    required this.quantity,
    this.categoryId,
    this.categoryName,
    this.categoryColor,
    required this.isCompleted,
    this.createdAt,
  });

  factory GroceryItemModel.fromJson(Map<String, dynamic> json) {
    return GroceryItemModel(
      id: json['id'],
      name: json['name'],
      quantity: json['quantity'],
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      categoryColor: json['category_color'],
      isCompleted: json['is_completed'] == 1,
      createdAt: json['created_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'quantity': quantity,
      'category_id': categoryId,
      'category_name': categoryName,
      'category_color': categoryColor,
      'is_completed': isCompleted ? 1 : 0,
      'created_at': createdAt,
    };
  }

  GroceryItemModel copyWith({
    int? id,
    String? name,
    int? quantity,
    int? categoryId,
    String? categoryName,
    String? categoryColor,
    bool? isCompleted,
    String? createdAt,
  }) {
    return GroceryItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      categoryId: categoryId ?? this.categoryId,
      categoryName: categoryName ?? this.categoryName,
      categoryColor: categoryColor ?? this.categoryColor,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  String toString() {
    return 'GroceryItemModel(id: $id, name: $name, quantity: $quantity, categoryId: $categoryId, categoryName: $categoryName, isCompleted: $isCompleted)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is GroceryItemModel &&
        other.id == id &&
        other.name == name &&
        other.quantity == quantity &&
        other.categoryId == categoryId &&
        other.isCompleted == isCompleted;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        quantity.hashCode ^
        categoryId.hashCode ^
        isCompleted.hashCode;
  }
}
