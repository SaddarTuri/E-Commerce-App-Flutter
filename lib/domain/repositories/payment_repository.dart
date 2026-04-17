abstract class PaymentRepository {
  Future<String> createPaymentIntent({
    required int amountInCents,
    required String currency,
  });
}
