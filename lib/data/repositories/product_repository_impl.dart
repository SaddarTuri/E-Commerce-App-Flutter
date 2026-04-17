import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repository.dart';
import '../datasources/product_remote_datasource.dart';

class ProductRepositoryImpl implements ProductRepository {
  const ProductRepositoryImpl(this._remoteDataSource);

  final ProductRemoteDataSource _remoteDataSource;

  @override
  Future<List<ProductEntity>> getProducts() async {
    final models = await _remoteDataSource.getProducts();
    return models.map((product) => product.toEntity()).toList();
  }
}
