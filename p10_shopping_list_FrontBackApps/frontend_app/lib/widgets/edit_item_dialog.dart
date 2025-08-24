import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shopping_list_provider.dart';
import '../models/category_model.dart';
import '../models/grocery_item_model.dart';

class EditItemDialog extends StatefulWidget {
  final GroceryItemModel item;

  const EditItemDialog({
    super.key,
    required this.item,
  });

  @override
  State<EditItemDialog> createState() => _EditItemDialogState();
}

class _EditItemDialogState extends State<EditItemDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _quantityController;
  late CategoryModel? _selectedCategory;
  late bool _isCompleted;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.item.name);
    _quantityController =
        TextEditingController(text: widget.item.quantity.toString());
    _isCompleted = widget.item.isCompleted;

    // Find the selected category
    final provider = Provider.of<ShoppingListProvider>(context, listen: false);
    _selectedCategory = provider.getCategoryById(widget.item.categoryId);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _quantityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ShoppingListProvider>(
      builder: (context, provider, child) {
        return AlertDialog(
          title: const Text('Edit Item'),
          content: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(
                    labelText: 'Item Name',
                    border: OutlineInputBorder(),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter an item name';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _quantityController,
                  decoration: const InputDecoration(
                    labelText: 'Quantity',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Please enter a quantity';
                    }
                    final quantity = int.tryParse(value);
                    if (quantity == null || quantity <= 0) {
                      return 'Please enter a valid quantity';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                DropdownButtonFormField<CategoryModel>(
                  value: _selectedCategory,
                  decoration: const InputDecoration(
                    labelText: 'Category (Optional)',
                    border: OutlineInputBorder(),
                  ),
                  items: [
                    const DropdownMenuItem<CategoryModel>(
                      value: null,
                      child: Text('No Category'),
                    ),
                    ...provider.categories.map((category) {
                      return DropdownMenuItem<CategoryModel>(
                        value: category,
                        child: Row(
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: BoxDecoration(
                                color: _parseColor(category.color),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 8),
                            Text(category.name),
                          ],
                        ),
                      );
                    }).toList(),
                  ],
                  onChanged: (CategoryModel? value) {
                    setState(() {
                      _selectedCategory = value;
                    });
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Checkbox(
                      value: _isCompleted,
                      onChanged: (bool? value) {
                        setState(() {
                          _isCompleted = value ?? false;
                        });
                      },
                    ),
                    const Text('Mark as completed'),
                  ],
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => _updateItem(context, provider),
              child: const Text('Update'),
            ),
          ],
        );
      },
    );
  }

  void _updateItem(BuildContext context, ShoppingListProvider provider) async {
    if (_formKey.currentState!.validate()) {
      try {
        final updatedItem = widget.item.copyWith(
          name: _nameController.text.trim(),
          quantity: int.parse(_quantityController.text),
          categoryId: _selectedCategory?.id,
          isCompleted: _isCompleted,
        );

        await provider.updateGroceryItem(updatedItem);

        if (mounted) {
          Navigator.of(context).pop();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Item updated successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error updating item: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }

  Color _parseColor(String colorString) {
    try {
      return Color(int.parse(colorString.replaceAll('#', '0xFF')));
    } catch (e) {
      return Colors.grey;
    }
  }
}
