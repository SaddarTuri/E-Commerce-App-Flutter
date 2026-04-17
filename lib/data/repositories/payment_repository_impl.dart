import '../../domain/repositories/payment_repository.dart';
import '../datasources/payment_remote_datasource.dart';

class PaymentRepositoryImpl implements PaymentRepository {
  const PaymentRepositoryImpl(this._remoteDataSource);

  final PaymentRemoteDataSource _remoteDataSource;

  @override
  Future<String> createPaymentIntent({
    required int amountInCents,
    required String currency,
  }) {
    return _remoteDataSource.createPaymentIntent(
      amountInCents: amountInCents,
      currency: currency,
    );
  }
}
