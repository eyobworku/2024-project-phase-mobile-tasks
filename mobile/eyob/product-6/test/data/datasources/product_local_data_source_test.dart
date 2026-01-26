import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_application_2/data/datasources/product_local_data_source_impl.dart';
import 'package:flutter_application_2/data/models/product_model.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ProductLocalDataSourceImpl dataSource;
  late MockSharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    dataSource = ProductLocalDataSourceImpl(
      sharedPreferences: mockSharedPreferences,
    );
  });

  group('getLastProducts', () {
    final tProductModel = ProductModel(
      id: '1',
      name: 'Test',
      description: 'Desc',
      price: 10,
      imageUrl: 'img',
    );
    final tProductJson = json.encode(tProductModel.toJson());
    final tJsonList = [tProductJson];

    test(
      'should return List<ProductModel> from SharedPreferences when there is cached data',
      () async {
        // Arrange
        when(
          () => mockSharedPreferences.getStringList(any()),
        ).thenReturn(tJsonList);

        // Act
        final result = await dataSource.getLastProducts();

        // Assert
        verify(() => mockSharedPreferences.getStringList(CACHED_PRODUCTS));
        expect(result, equals([tProductModel]));
      },
    );

    test('should throw Exception when there is no cached data', () async {
      // Arrange
      when(() => mockSharedPreferences.getStringList(any())).thenReturn(null);

      // Act
      final call = dataSource.getLastProducts;

      // Assert
      expect(() => call(), throwsException);
    });
  });

  group('cacheProducts', () {
    final tProductModels = [
      ProductModel(
        id: '1',
        name: 'Test',
        description: 'Desc',
        price: 10,
        imageUrl: 'img',
      ),
    ];

    test(
      'should call SharedPreferences to cache the list of products',
      () async {
        // Arrange
        when(
          () => mockSharedPreferences.setStringList(any(), any()),
        ).thenAnswer((_) async => true);

        // Act
        await dataSource.cacheProducts(tProductModels);

        // Assert
        final expectedJsonList = tProductModels
            .map((p) => json.encode(p.toJson()))
            .toList();
        verify(
          () => mockSharedPreferences.setStringList(
            CACHED_PRODUCTS,
            expectedJsonList,
          ),
        );
      },
    );
  });
}
