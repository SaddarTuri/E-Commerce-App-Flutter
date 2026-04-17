import 'package:dio/dio.dart';

abstract class PaymentRemoteDataSource {
  Future<String> createPaymentIntent({
    required int amountInCents,
    required String currency,
  });
}

class PaymentRemoteDataSourceImpl implements PaymentRemoteDataSource {
  const PaymentRemoteDataSourceImpl(this._dio);

  final Dio _dio;

  @override
  Future<String> createPaymentIntent({
    required int amountInCents,
    required String currency,
  }) async {
    // Stripe API requires application/x-www-form-urlencoded.
    // We use FormData-style string encoding so bracket-notation keys
    // (automatic_payment_methods[enabled]) are properly serialised.
    final response = await _dio.post<Map<String, dynamic>>(
      '/payment_intents',
      data:
          'amount=$amountInCents'
          '&currency=$currency'
          '&automatic_payment_methods[enabled]=true',
      options: Options(contentType: Headers.formUrlEncodedContentType),
    );

    final body = response.data;
    if (body == null) {
      throw Exception('Empty response from Stripe');
    }
    final secret = body['client_secret'] as String?;
    if (secret == null || secret.isEmpty) {
      throw Exception('client_secret missing in Stripe response: $body');
    }
    return secret;
  }
}
