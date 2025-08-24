import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/shopping_list_provider.dart';
import '../widgets/grocery_item_card.dart';
import '../widgets/add_item_dialog.dart';
import '../widgets/edit_item_dialog.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Initialize data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ShoppingListProvider>().initializeData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<ShoppingListProvider>().initializeData();
            },
          ),
        ],
      ),
      body: Consumer<ShoppingListProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.error_outline,
                    size: 64,
                    color: Colors.red,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${provider.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.clearError();
                      provider.initializeData();
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.groceryItems.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 64,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No items in your shopping list',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the + button to add items',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Summary cards
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Row(
                  children: [
                    Expanded(
                      child: _buildSummaryCard(
                        'Total Items',
                        provider.groceryItems.length.toString(),
                        Icons.shopping_cart,
                        Colors.blue,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSummaryCard(
                        'Completed',
                        provider.completedItems.length.toString(),
                        Icons.check_circle,
                        Colors.green,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: _buildSummaryCard(
                        'Pending',
                        provider.pendingItems.length.toString(),
                        Icons.pending,
                        Colors.orange,
                      ),
                    ),
                  ],
                ),
              ),

              // Items list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: provider.groceryItems.length,
                  itemBuilder: (context, index) {
                    final item = provider.groceryItems[index];
                    return GroceryItemCard(
                      item: item,
                      onToggle: () => provider.toggleItemCompletion(item.id!),
                      onDelete: () =>
                          _showDeleteDialog(context, provider, item),
                      onEdit: () => _showEditDialog(context, provider, item),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddItemDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildSummaryCard(
      String title, String value, IconData icon, Color color) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Icon(icon, color: color, size: 32),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(
              title,
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  void _showAddItemDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => const AddItemDialog(),
    );
  }

  void _showDeleteDialog(
      BuildContext context, ShoppingListProvider provider, dynamic item) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Item'),
        content: Text('Are you sure you want to delete "${item.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              provider.deleteGroceryItem(item.id);
              Navigator.of(context).pop();
            },
            child: const Text('Delete', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }

  void _showEditDialog(
      BuildContext context, ShoppingListProvider provider, dynamic item) {
    showDialog(
      context: context,
      builder: (context) => EditItemDialog(item: item),
    );
  }
}
