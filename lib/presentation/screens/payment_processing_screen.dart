import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';

class PaymentProcessingScreen extends StatelessWidget {
  const PaymentProcessingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.overlay,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(color: AppColors.surface),
            SizedBox(height: 16),
            Text(
              AppStrings.processingPayment,
              style: TextStyle(color: AppColors.surface),
            ),
          ],
        ),
      ),
    );
  }
}
