import 'package:flutter/material.dart';
import 'product_model.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Mock data list
  List<Product> products = [
    Product(
      id: '1',
      name: 'Laptop',
      description: 'High performance laptop',
      price: 999.99,
    ),
    Product(
      id: '2',
      name: 'Smartphone',
      description: 'Latest generation phone',
      price: 699.00,
    ),
  ];

  // Navigate to Add/Edit Screen and await result
  void _navigateToAddEdit({Product? product}) async {
    final result = await Navigator.pushNamed(
      context,
      '/add_edit',
      arguments: product, // Pass product if editing, null if adding
    );

    // Update list if data is returned from the other screen
    if (result != null && result is Product) {
      setState(() {
        int index = products.indexWhere((p) => p.id == result.id);
        if (index != -1) {
          // Update existing
          products[index] = result;
        } else {
          // Add new
          products.add(result);
        }
      });
    }
  }

  void _deleteProduct(String id) {
    setState(() {
      products.removeWhere((p) => p.id == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('E-Commerce Products')),
      body: ListView.builder(
        itemCount: products.length,
        itemBuilder: (context, index) {
          final product = products[index];
          return Card(
            child: ListTile(
              leading: const Icon(Icons.shopping_bag),
              title: Text(product.name),
              subtitle: Text('${product.price.toStringAsFixed(2)} Birr'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: const Icon(Icons.edit, color: Colors.blue),
                    onPressed: () => _navigateToAddEdit(product: product),
                  ),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () => _deleteProduct(product.id),
                  ),
                ],
              ),
              // Navigate to Details Screen [cite: 9, 10]
              onTap: () {
                Navigator.pushNamed(context, '/details', arguments: product);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToAddEdit(product: null), // Add new product
        child: const Icon(Icons.add),
      ),
    );
  }
}
