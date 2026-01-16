import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_data_source.dart';
import '../datasources/product_local_data_source.dart';
import '../../domain/entities/product.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;
  final ProductLocalDataSource localDataSource;
  final dynamic networkInfo;

  ProductRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<List<Product>> getAllProducts() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteProducts = await remoteDataSource.getProductsFromApi();

        await localDataSource.cacheProducts(remoteProducts);
        return remoteProducts;
      } catch (e) {
        return await localDataSource.getLastProducts();
      }
    } else {
      return await localDataSource.getLastProducts();
    }
  }

  @override
  Future<Product> getProductDetail(String id) async {
    if (await networkInfo.isConnected) {
      return await remoteDataSource.getProductDetail(id);
    } else {
      return await localDataSource.getCachedProductDetail(id);
    }
  }

  @override
  Future<void> createProduct(Product product) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.uploadProduct(product);
    } else {
      throw Exception('No Internet Connection to create product');
    }
  }

  @override
  Future<void> updateProduct(Product product) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.updateProduct(product);
    } else {
      throw Exception('No Internet Connection to update product');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    if (await networkInfo.isConnected) {
      await remoteDataSource.deleteProduct(id);
    } else {
      throw Exception('No Internet Connection to delete product');
    }
  }
}
