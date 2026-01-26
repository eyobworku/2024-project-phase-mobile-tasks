import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/product_model.dart';
import './product_local_data_source.dart';

const CACHED_PRODUCTS = 'CACHED_PRODUCTS';

class ProductLocalDataSourceImpl implements ProductLocalDataSource {
  final SharedPreferences sharedPreferences;

  ProductLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheProducts(List<ProductModel> productsToCache) {
    final List<String> productJsonList = productsToCache
        .map((product) => json.encode(product.toJson()))
        .toList();
    return sharedPreferences.setStringList(CACHED_PRODUCTS, productJsonList);
  }

  @override
  Future<List<ProductModel>> getLastProducts() {
    final jsonStringList = sharedPreferences.getStringList(CACHED_PRODUCTS);
    if (jsonStringList != null) {
      return Future.value(
        jsonStringList
            .map(
              (productJson) => ProductModel.fromJson(json.decode(productJson)),
            )
            .toList(),
      );
    } else {
      throw Exception('No cached products found');
    }
  }

  @override
  Future<ProductModel> getCachedProductDetail(String id) async {
    final products = await getLastProducts();

    try {
      return products.firstWhere((product) => product.id == id);
    } catch (e) {
      throw Exception('Product with ID $id not found in cache');
    }
  }
}
