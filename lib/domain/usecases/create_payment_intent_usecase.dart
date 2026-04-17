import '../repositories/payment_repository.dart';

class CreatePaymentIntentUseCase {
  const CreatePaymentIntentUseCase(this._repository);

  final PaymentRepository _repository;

  Future<String> call({required int amountInCents, required String currency}) {
    return _repository.createPaymentIntent(
      amountInCents: amountInCents,
      currency: currency,
    );
  }
}
