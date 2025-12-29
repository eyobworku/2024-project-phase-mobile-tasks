import 'package:flutter_test/flutter_test.dart';
import 'package:task_11/features/ecommerce/data/models/product_model.dart';
import 'package:task_11/features/ecommerce/domain/entities/product.dart';

void main() {
  final tProductModel = ProductModel(
    id: '1',
    name: 'Test Product',
    description: 'Test Description',
    imageUrl: 'test.png',
    price: 100.0,
  );

  test('should be a subclass of Product entity', () async {
    expect(tProductModel, isA<Product>());
  });

  group('fromJson', () {
    test(
      'should return a valid model when the JSON price is a double',
      () async {
        final Map<String, dynamic> jsonMap = {
          "id": "1",
          "name": "Test Product",
          "description": "Test Description",
          "imageUrl": "test.png",
          "price": 100.0,
        };
        final result = ProductModel.fromJson(jsonMap);
        expect(result, tProductModel);
      },
    );
  });

  group('toJson', () {
    test('should return a JSON map containing the proper data', () async {
      final result = tProductModel.toJson();
      final expectedMap = {
        "id": "1",
        "name": "Test Product",
        "description": "Test Description",
        "imageUrl": "test.png",
        "price": 100.0,
      };
      expect(result, expectedMap);
    });
  });
}
