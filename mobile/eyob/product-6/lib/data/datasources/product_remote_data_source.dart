import '../../domain/entities/product.dart';

abstract class ProductRemoteDataSource {
  Future<List<Product>> getProductsFromApi();
  Future<void> uploadProduct(Product product);
}

abstract class ProductLocalDataSource {
  Future<List<Product>> getLastProducts();
  Future<void> cacheProducts(List<Product> productsToCache);
}
