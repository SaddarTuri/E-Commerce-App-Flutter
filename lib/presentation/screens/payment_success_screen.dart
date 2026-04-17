import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/price_formatter.dart';
import '../widgets/primary_button.dart';

class PaymentSuccessScreen extends StatelessWidget {
  const PaymentSuccessScreen({super.key, required this.totalPaid});

  final double totalPaid;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Row(
                children: [
                  Icon(Icons.menu, color: AppColors.primaryDark),
                  SizedBox(width: 10),
                  Text(
                    AppStrings.appName,
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  Spacer(),
                  Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.primaryDark,
                  ),
                ],
              ),
              const SizedBox(height: 40),
              const Center(
                child: CircleAvatar(
                  radius: 48,
                  backgroundColor: AppColors.success,
                  child: Icon(Icons.check, color: AppColors.surface, size: 40),
                ),
              ),
              const SizedBox(height: 22),
              const Center(
                child: Text(
                  AppStrings.paymentSuccessful,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text(
                  AppStrings.paymentSuccessSubtitle,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: AppColors.textSecondary,
                    fontSize: 16,
                  ),
                ),
              ),
              const SizedBox(height: 18),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Row(
                      children: [
                        Text(
                          AppStrings.orderNumber,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                        Spacer(),
                        Text(
                          AppStrings.date,
                          style: TextStyle(
                            color: AppColors.textSecondary,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 6),
                    const Row(
                      children: [
                        Text(
                          AppStrings.orderCode,
                          style: TextStyle(fontWeight: FontWeight.w700),
                        ),
                        Spacer(),
                        Text(AppStrings.orderDate),
                      ],
                    ),
                    const Divider(height: 28),
                    Row(
                      children: [
                        const Text(
                          AppStrings.totalPaid,
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                        const Spacer(),
                        Text(
                          PriceFormatter.format(totalPaid),
                          style: const TextStyle(
                            color: AppColors.primaryDark,
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 16,
                ),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: AppColors.primary,
                      child: Icon(
                        Icons.local_shipping,
                        color: AppColors.surface,
                      ),
                    ),
                    SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            AppStrings.estimatedDelivery,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Text(
                            AppStrings.deliveryDate,
                            style: TextStyle(color: AppColors.textSecondary),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      AppStrings.track,
                      style: TextStyle(
                        color: AppColors.primaryDark,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              PrimaryButton(
                label: AppStrings.continueShopping,
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              PrimaryButton(
                label: AppStrings.downloadInvoice,
                onPressed: () {},
                backgroundColor: AppColors.chipBackground,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
