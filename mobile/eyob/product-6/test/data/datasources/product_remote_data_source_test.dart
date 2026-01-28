import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_application_2/data/datasources/product_remote_data_source_impl.dart';
import 'package:flutter_application_2/data/models/product_model.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late ProductRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = ProductRemoteDataSourceImpl(client: mockHttpClient);
    registerFallbackValue(Uri());
  });

  final tId = '6672776eb905525c145fe0bb';

  group('getProductsFromApi', () {
    test(
      'should return a list of ProductModel when the response is 200',
      () async {
        when(() => mockHttpClient.get(any())).thenAnswer(
          (_) async => http.Response(
            json.encode({
              'data': [
                {
                  'id': '1',
                  'name': 'A',
                  'description': 'B',
                  'price': 1.0,
                  'imageUrl': 'C',
                },
              ],
            }),
            200,
          ),
        );

        final result = await dataSource.getProductsFromApi();

        expect(result, isA<List<ProductModel>>());
      },
    );

    test(
      'should throw an exception when the response code is not 200',
      () async {
        when(
          () => mockHttpClient.get(any()),
        ).thenAnswer((_) async => http.Response('Error', 404));

        expect(() => dataSource.getProductsFromApi(), throwsException);
      },
    );
  });

  group('deleteProduct', () {
    test('should perform a DELETE request on the correct URL', () async {
      when(
        () => mockHttpClient.delete(any()),
      ).thenAnswer((_) async => http.Response('Deleted', 200));

      await dataSource.deleteProduct(tId);

      verify(
        () => mockHttpClient.delete(
          Uri.parse(
            'https://g5-flutter-learning-path-be.onrender.com/api/v1/products/$tId',
          ),
        ),
      );
    });
  });
}
