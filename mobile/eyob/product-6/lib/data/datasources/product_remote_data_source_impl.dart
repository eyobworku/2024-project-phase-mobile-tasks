import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import './product_remote_data_source.dart';

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  final http.Client client;
  final String baseUrl =
      'https://g5-flutter-learning-path-be.onrender.com/api/v1';

  ProductRemoteDataSourceImpl({required this.client});

  @override
  Future<List<ProductModel>> getProductsFromApi() async {
    final response = await client.get(Uri.parse('$baseUrl/products'));

    if (response.statusCode == 200) {
      final List decodeData = json.decode(response.body)['data'];
      return decodeData.map((json) => ProductModel.fromJson(json)).toList();
    } else {
      throw Exception('Server Failure');
    }
  }

  @override
  Future<ProductModel> getProductDetail(String id) async {
    final response = await client.get(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode == 200) {
      return ProductModel.fromJson(json.decode(response.body)['data']);
    } else {
      throw Exception('Product not found');
    }
  }

  @override
  Future<void> uploadProduct(ProductModel product) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/products'));

    request.fields['name'] = product.name;
    request.fields['description'] = product.description;
    request.fields['price'] = product.price.toString();

    request.files.add(
      await http.MultipartFile.fromPath('image', product.imageUrl),
    );

    final streamedResponse = await request.send();
    final response = await http.Response.fromStream(streamedResponse);

    if (response.statusCode != 201) {
      throw Exception('Failed to create product: ${response.body}');
    }
  }

  @override
  Future<void> updateProduct(ProductModel product) async {
    final response = await client.put(
      Uri.parse('$baseUrl/products/${product.id}'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'name': product.name,
        'description': product.description,
        'price': product.price,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update product: ${response.body}');
    }
  }

  @override
  Future<void> deleteProduct(String id) async {
    final response = await client.delete(Uri.parse('$baseUrl/products/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete product');
    }
  }
}
