import '../entities/product.dart'; // Your existing product model/entity

abstract class ProductRepository {
  Future<List<Product>> getAllProducts();
  Future<Product> getProductDetail(String id);
  Future<void> createProduct(Product product);
  Future<void> updateProduct(Product product);
  Future<void> deleteProduct(String id);
}
