import 'package:flutter/material.dart';
import '../models/grocery_item_model.dart';

class GroceryItemCard extends StatelessWidget {
  final GroceryItem item;
  final VoidCallback onToggle;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  const GroceryItemCard({
    super.key,
    required this.item,
    required this.onToggle,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getCategoryColor(),
          child: Text(
            item.quantity.toString(),
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        title: Text(
          item.name,
          style: TextStyle(
            decoration: item.isCompleted ? TextDecoration.lineThrough : null,
            color: item.isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: item.categoryName != null
            ? Text(
                item.categoryName!,
                style: TextStyle(
                  color: _getCategoryColor(),
                  fontWeight: FontWeight.w500,
                ),
              )
            : null,
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                item.isCompleted
                    ? Icons.check_circle
                    : Icons.radio_button_unchecked,
                color: item.isCompleted ? Colors.green : Colors.grey,
              ),
              onPressed: onToggle,
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }

  Color _getCategoryColor() {
    if (item.categoryColor != null) {
      try {
        return Color(int.parse(item.categoryColor!.replaceAll('#', '0xFF')));
      } catch (e) {
        return Colors.grey;
      }
    }
    return Colors.grey;
  }
}
