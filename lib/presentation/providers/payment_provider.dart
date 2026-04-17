import 'package:flutter/material.dart' show ThemeMode;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import '../../core/constants/app_strings.dart';
import '../../core/di/providers.dart';

enum PaymentStatus { initial, loading, success, cancelled, failed }

class PaymentState {
  const PaymentState({this.status = PaymentStatus.initial, this.errorMessage});

  final PaymentStatus status;
  final String? errorMessage; // non-null only on failure

  PaymentState copyWith({PaymentStatus? status, String? errorMessage}) {
    return PaymentState(
      status: status ?? this.status,
      errorMessage: errorMessage,
    );
  }
}

class PaymentNotifier extends StateNotifier<PaymentState> {
  PaymentNotifier(this._ref) : super(const PaymentState());

  final Ref _ref;

  Future<void> pay(double total) async {
    state = const PaymentState(status: PaymentStatus.loading);

    try {
      final amountInCents = (total * 100).round();
      final clientSecret = await _ref
          .read(createPaymentIntentUseCaseProvider)
          .call(amountInCents: amountInCents, currency: AppStrings.usd);

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: AppStrings.atelierMerchant,
          style: ThemeMode.light,
          allowsDelayedPaymentMethods: true,
        ),
      );
      await Stripe.instance.presentPaymentSheet();

      state = const PaymentState(status: PaymentStatus.success);
    } on StripeException catch (e) {
      final isCancelled = e.error.code == FailureCode.Canceled;
      state = PaymentState(
        status: isCancelled ? PaymentStatus.cancelled : PaymentStatus.failed,
        errorMessage: isCancelled ? null : e.error.localizedMessage,
      );
    } catch (e) {
      state = PaymentState(
        status: PaymentStatus.failed,
        errorMessage: e.toString(),
      );
    }
  }

  void reset() => state = const PaymentState();
}

final paymentProvider = StateNotifierProvider<PaymentNotifier, PaymentState>(
  (ref) => PaymentNotifier(ref),
);
