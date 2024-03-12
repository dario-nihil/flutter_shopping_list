import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:shopping_list/models/grocery_item.dart';
import 'package:shopping_list/widget/new_item.dart';

class GroceryList extends StatefulWidget {
  const GroceryList({super.key});

  @override
  State<GroceryList> createState() => _GroceryListState();
}

class _GroceryListState extends State<GroceryList> {
  final List<GroceryItem> _groceryList = [];

  _addItem() async {
    final newItem = await Navigator.of(context).push<GroceryItem>(
      MaterialPageRoute(
        builder: (ctx) => const NewItem(),
      ),
    );

    if (newItem == null) return;

    setState(() {
      _groceryList.add(newItem);
    });
  }

  void _removeItem(GroceryItem item) {
    setState(() {
      _groceryList.remove(item);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${item.name} removed!'),
        duration: const Duration(milliseconds: 2000),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = Center(
      child: Text(
        'No items added yet.',
        style: Theme.of(context).textTheme.bodyLarge,
      ),
    );

    if (_groceryList.isNotEmpty) {
      content = ListView.builder(
        itemCount: _groceryList.length,
        itemBuilder: (ctx, idx) => Dismissible(
          key: ValueKey(_groceryList[idx].id),
          onDismissed: (_) => _removeItem(_groceryList[idx]),
          child: ListTile(
            title: Text(_groceryList[idx].name),
            leading: Container(
              width: 24,
              height: 24,
              color: _groceryList[idx].category.color,
            ),
            trailing: Text(
              _groceryList[idx].quantity.toString(),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
        actions: [
          IconButton(
            onPressed: _addItem,
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: content,
    );
  }
}
