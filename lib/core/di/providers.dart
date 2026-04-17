import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_strings.dart';
import '../../core/network/dio_client.dart';
import '../../data/datasources/payment_remote_datasource.dart';
import '../../data/datasources/product_remote_datasource.dart';
import '../../data/repositories/payment_repository_impl.dart';
import '../../data/repositories/product_repository_impl.dart';
import '../../domain/repositories/payment_repository.dart';
import '../../domain/repositories/product_repository.dart';
import '../../domain/usecases/create_payment_intent_usecase.dart';
import '../../domain/usecases/get_products_usecase.dart';

final productDioProvider = Provider<Dio>((ref) {
  return DioClient.create(AppStrings.productsApiBaseUrl);
});

final paymentDioProvider = Provider<Dio>((ref) {
  final dio = DioClient.create(AppStrings.stripeApiBaseUrl);
  dio.options.headers = <String, dynamic>{
    'Authorization': 'Bearer ${AppStrings.stripeSecretKey}',
  };
  return dio;
});

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((
  ref,
) {
  return ProductRemoteDataSourceImpl(ref.watch(productDioProvider));
});

final paymentRemoteDataSourceProvider = Provider<PaymentRemoteDataSource>((
  ref,
) {
  return PaymentRemoteDataSourceImpl(ref.watch(paymentDioProvider));
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  return ProductRepositoryImpl(ref.watch(productRemoteDataSourceProvider));
});

final paymentRepositoryProvider = Provider<PaymentRepository>((ref) {
  return PaymentRepositoryImpl(ref.watch(paymentRemoteDataSourceProvider));
});

final getProductsUseCaseProvider = Provider<GetProductsUseCase>((ref) {
  return GetProductsUseCase(ref.watch(productRepositoryProvider));
});

final createPaymentIntentUseCaseProvider = Provider<CreatePaymentIntentUseCase>(
  (ref) {
    return CreatePaymentIntentUseCase(ref.watch(paymentRepositoryProvider));
  },
);
