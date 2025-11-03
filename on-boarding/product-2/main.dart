import 'dart:io';

class Product {
  final int id;
  String name;
  String description;
  double price;

  Product(this.id, this.name, this.description, this.price);

  @override
  String toString() {
    return 'ID: $id\nName: $name\nDescription: $description\nPrice: \$$price\n';
  }
}

class ProductManager {
  final List<Product> _products = [];
  int _nextId = 1;

  void addProduct(String name, String description, double price) {
    _products.add(Product(_nextId++, name, description, price));
    print('Product added successfully!\n');
  }

  void viewAllProducts() {
    if (_products.isEmpty) {
      print('No products available.\n');
      return;
    }

    print('All Products:');
    for (var product in _products) {
      print(product);
    }
    print('');
  }

  void viewProduct(int id) {
    Product? product;
    for (var p in _products) {
      if (p.id == id) {
        product = p;
        break;
      }
    }
    if (product == null) {
      print('Product with ID $id not found.\n');
      return;
    }
    print('Product Details:');
    print(product);
  }

  void editProduct(int id, String? name, String? description, double? price) {
    Product? product;
    for (var p in _products) {
      if (p.id == id) {
        product = p;
        break;
      }
    }
    if (product == null) {
      print('Product with ID $id not found.\n');
      return;
    }

    product.name = name ?? product.name;
    product.description = description ?? product.description;
    product.price = price ?? product.price;

    print('Product updated successfully!\n');
  }

  void deleteProduct(int id) {
    bool exists = _products.any((p) => p.id == id);
    if (!exists) {
      print('Product with ID $id not found.\n');
      return;
    }
    _products.removeWhere((p) => p.id == id);
    print('Product deleted successfully!\n');
  }

  int get productCount => _products.length;
}

void main() {
  final manager = ProductManager();
  bool running = true;

  print('Welcome to the eCommerce CLI Application!\n');

  while (running) {
    print('--- Menu ---');
    print('1. Add Product');
    print('2. View All Products');
    print('3. View Product by ID');
    print('4. Edit Product');
    print('5. Delete Product');
    print('6. Exit');
    stdout.write('Choose an option (1-6): ');

    String? input = stdin.readLineSync();
    print('');

    switch (input) {
      case '1':
        _addProduct(manager);
        break;
      case '2':
        manager.viewAllProducts();
        break;
      case '3':
        _viewProduct(manager);
        break;
      case '4':
        _editProduct(manager);
        break;
      case '5':
        _deleteProduct(manager);
        break;
      case '6':
        print('Goodbye!');
        running = false;
        break;
      default:
        print('Invalid option. Please try again.\n');
    }
  }
}

void _addProduct(ProductManager manager) {
  stdout.write('Enter product name: ');
  String? name = stdin.readLineSync();
  if (name == null || name.trim().isEmpty) {
    print('Name is required.\n');
    return;
  }

  stdout.write('Enter product description: ');
  String? description = stdin.readLineSync();
  if (description == null) description = '';

  stdout.write('Enter product price: ');
  String? priceStr = stdin.readLineSync();
  double price;
  try {
    price = double.parse(priceStr ?? '0');
    if (price < 0) throw FormatException();
  } catch (e) {
    print('Invalid price. Must be a positive number.\n');
    return;
  }

  manager.addProduct(name, description, price);
}

void _viewProduct(ProductManager manager) {
  if (manager.productCount == 0) {
    print('No products to view.\n');
    return;
  }

  stdout.write('Enter product ID: ');
  String? idStr = stdin.readLineSync();
  int id;
  try {
    id = int.parse(idStr ?? '');
  } catch (e) {
    print('Invalid ID.\n');
    return;
  }

  manager.viewProduct(id);
}

void _editProduct(ProductManager manager) {
  if (manager.productCount == 0) {
    print('No products to edit.\n');
    return;
  }

  stdout.write('Enter product ID to edit: ');
  String? idStr = stdin.readLineSync();
  int id;
  try {
    id = int.parse(idStr ?? '');
  } catch (e) {
    print('Invalid ID.\n');
    return;
  }

  stdout.write('Enter new name (leave blank to keep current): ');
  String? name = stdin.readLineSync()?.trim();
  if (name == '') name = null;

  stdout.write('Enter new description (leave blank to keep current): ');
  String? description = stdin.readLineSync()?.trim();
  if (description == '') description = null;

  stdout.write('Enter new price (leave blank to keep current): ');
  String? priceStr = stdin.readLineSync()?.trim();
  double? price;
  if (priceStr != null && priceStr.isNotEmpty) {
    try {
      price = double.parse(priceStr);
      if (price < 0) throw FormatException();
    } catch (e) {
      print('Invalid price. Update aborted.\n');
      return;
    }
  }

  manager.editProduct(id, name, description, price);
}

void _deleteProduct(ProductManager manager) {
  if (manager.productCount == 0) {
    print('No products to delete.\n');
    return;
  }

  stdout.write('Enter product ID to delete: ');
  String? idStr = stdin.readLineSync();
  int id;
  try {
    id = int.parse(idStr ?? '');
  } catch (e) {
    print('Invalid ID.\n');
    return;
  }

  manager.deleteProduct(id);
}
