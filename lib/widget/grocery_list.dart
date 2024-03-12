import 'package:flutter/material.dart';

import 'package:shopping_list/data/dummy_items.dart';

class GroceryList extends StatelessWidget {
  const GroceryList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Groceries'),
      ),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, idx) => ListTile(
          title: Text(groceryItems[idx].name),
          leading: Container(
            width: 24,
            height: 24,
            color: groceryItems[idx].category.color,
          ),
          trailing: Text(
            groceryItems[idx].quantity.toString(),
          ),
        ),
      ),
    );
  }
}
