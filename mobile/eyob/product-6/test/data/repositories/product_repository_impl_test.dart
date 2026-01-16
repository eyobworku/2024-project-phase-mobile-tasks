import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:flutter_application_2/domain/entities/product.dart';
import 'package:flutter_application_2/data/repositories/product_repository_impl.dart';
import 'package:flutter_application_2/data/datasources/product_remote_data_source.dart';
import 'package:flutter_application_2/data/datasources/product_local_data_source.dart';
import 'package:flutter_application_2/core/network/network_info.dart';

// Create Mock classes
class MockRemoteDataSource extends Mock implements ProductRemoteDataSource {}

class MockLocalDataSource extends Mock implements ProductLocalDataSource {}

class MockNetworkInfo extends Mock implements NetworkInfo {}

class FakeProduct extends Fake implements Product {}

void main() {
  late ProductRepositoryImpl repository;
  late MockRemoteDataSource mockRemoteDataSource;
  late MockLocalDataSource mockLocalDataSource;
  late MockNetworkInfo mockNetworkInfo;

  setUpAll(() {
    registerFallbackValue(FakeProduct());
  });

  setUp(() {
    mockRemoteDataSource = MockRemoteDataSource();
    mockLocalDataSource = MockLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = ProductRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tProduct = Product(
    id: '1',
    name: 'Test Product',
    description: 'Test Desc',
    price: 10.0,
    imageUrl: 'test.png',
  );
  final tProducts = [tProduct];

  group('getAllProducts', () {
    test('should return remote data and cache it when online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemoteDataSource.getProductsFromApi(),
      ).thenAnswer((_) async => tProducts);
      when(
        () => mockLocalDataSource.cacheProducts(any()),
      ).thenAnswer((_) async => {});

      final result = await repository.getAllProducts();

      expect(result, tProducts);
      verify(() => mockRemoteDataSource.getProductsFromApi()).called(1);
      verify(() => mockLocalDataSource.cacheProducts(tProducts)).called(1);
    });

    test('should return local data when offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
      when(
        () => mockLocalDataSource.getLastProducts(),
      ).thenAnswer((_) async => tProducts);

      final result = await repository.getAllProducts();

      expect(result, tProducts);
      verifyNever(() => mockRemoteDataSource.getProductsFromApi());
      verify(() => mockLocalDataSource.getLastProducts()).called(1);
    });
  });

  group('createProduct', () {
    test('should call remote source when online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemoteDataSource.uploadProduct(any()),
      ).thenAnswer((_) async => {});

      await repository.createProduct(tProduct);

      verify(() => mockRemoteDataSource.uploadProduct(tProduct)).called(1);
    });

    test('should throw Exception when offline', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);

      expect(() => repository.createProduct(tProduct), throwsException);
      verifyNever(() => mockRemoteDataSource.uploadProduct(any()));
    });
  });

  group('deleteProduct', () {
    test('should delete from remote when online', () async {
      when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(
        () => mockRemoteDataSource.deleteProduct(any()),
      ).thenAnswer((_) async => {});

      await repository.deleteProduct('1');

      verify(() => mockRemoteDataSource.deleteProduct('1')).called(1);
    });
  });
}
