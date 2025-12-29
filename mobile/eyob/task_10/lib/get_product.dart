import './product_usecase.dart';

class GetProduct {
  final ProductRepository repository;

  GetProduct(this.repository);

  Future<void> execute(String id) async {
    return await repository.getProduct(id);
  }
}
