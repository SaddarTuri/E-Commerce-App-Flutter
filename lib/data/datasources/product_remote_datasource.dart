import 'package:dio/dio.dart';

import '../models/product_model.dart';

abstract class ProductRemoteDataSource {
  Future<List<ProductModel>> getProducts();
}

class ProductRemoteDataSourceImpl implements ProductRemoteDataSource {
  const ProductRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<List<ProductModel>> getProducts() async {
    final response = await _dio.get('/products');
    final data = (response.data as List<dynamic>? ?? <dynamic>[]);
    return data
        .map(
          (dynamic item) => ProductModel.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  }
}
