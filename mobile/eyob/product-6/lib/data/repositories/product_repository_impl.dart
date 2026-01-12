import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../../domain/entities/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final dynamic networkInfo; // Placeholder for network connectivity logic

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Product>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      final remoteProducts = await remoteDataSource.getProductsFromApi();
      localDataSource.cacheProducts(remoteProducts);
      return remoteProducts;
    } else {
      return await localDataSource.getLastProducts();
    }
  }

  @override
  Future<void> createProduct(Product product) async {
    await remoteDataSource.uploadProduct(product);
  }

  @override
  Future<Product> getProductDetail(String id) {
    return Future.value(
      Product(name: '', price: 0.0, description: '', id: '', imageUrl: ''),
    );
  }

  @override
  Future<void> updateProduct(Product product) async {}
  @override
  Future<void> deleteProduct(String id) async {}
}
