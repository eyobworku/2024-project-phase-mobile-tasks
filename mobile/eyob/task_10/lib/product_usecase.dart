import '../product.dart';

abstract class ProductRepository {
  Future<void> getProduct(String id);
  Future<void> insertProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<Product> deleteProduct(String id);
}
