import '../../domain/entities/product.dart';

abstract class ProductLocalDataSource {
  Future<List<Product>> getLastProducts();
  Future<void> cacheProducts(List<Product> productsToCache);
  Future<Product> getCachedProductDetail(String id);
}
