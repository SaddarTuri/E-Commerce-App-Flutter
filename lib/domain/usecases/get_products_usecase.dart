import '../entities/product_entity.dart';
import '../repositories/product_repository.dart';

class GetProductsUseCase {
  const GetProductsUseCase(this._repository);

  final ProductRepository _repository;

  Future<List<ProductEntity>> call() {
    return _repository.getProducts();
  }
}
