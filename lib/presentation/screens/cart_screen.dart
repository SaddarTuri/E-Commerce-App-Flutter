import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/price_formatter.dart';
import '../providers/cart_provider.dart';
import '../providers/navigation_provider.dart';
import '../providers/payment_provider.dart';
import '../widgets/cart_item_tile.dart';
import 'empty_cart_screen.dart';
import 'payment_success_screen.dart';

class CartScreen extends ConsumerWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cartItems = ref.watch(cartProvider);

    if (cartItems.isEmpty) {
      return const Scaffold(
        backgroundColor: AppColors.background,
        body: EmptyCartScreen(),
      );
    }

    final total = ref.watch(cartTotalProvider);

    final paymentState = ref.watch(paymentProvider);
    final isLoading = paymentState.status == PaymentStatus.loading;

    ref.listen<PaymentState>(paymentProvider, (previous, current) {
      switch (current.status) {
        case PaymentStatus.success:
          ref.read(cartProvider.notifier).clear();
          ref.read(paymentProvider.notifier).reset();
          Navigator.push(
            context,
            MaterialPageRoute<void>(
              builder: (_) => PaymentSuccessScreen(totalPaid: total),
            ),
          );
        case PaymentStatus.failed:
          final msg = current.errorMessage ?? AppStrings.paymentFailed;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(msg), backgroundColor: AppColors.danger),
          );
          ref.read(paymentProvider.notifier).reset();
        case PaymentStatus.cancelled:
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text(AppStrings.paymentCancelled)),
          );
          ref.read(paymentProvider.notifier).reset();
        default:
          break;
      }
    });

    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      if (Navigator.canPop(context)) {
                        Navigator.pop(context);
                        return;
                      }
                      ref.read(bottomNavIndexProvider.notifier).state = 0;
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.primaryDark,
                    ),
                  ),
                  const SizedBox(width: 14),
                  const Text(
                    AppStrings.yourCart,
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              _CartHeader(count: cartItems.length),
              const SizedBox(height: 16),
              Expanded(
                child: ListView.builder(
                  itemCount: cartItems.length,
                  itemBuilder: (context, index) {
                    final item = cartItems[index];
                    return CartItemTile(
                      item: item,
                      onRemove: () => ref
                          .read(cartProvider.notifier)
                          .removeFromCart(item.product.id),
                      onIncrease: () => ref
                          .read(cartProvider.notifier)
                          .increaseQuantity(item.product.id),
                      onDecrease: () => ref
                          .read(cartProvider.notifier)
                          .decreaseQuantity(item.product.id),
                    );
                  },
                ),
              ),
              _PriceRow(
                label: AppStrings.subtotal,
                value: PriceFormatter.format(total),
              ),
              const SizedBox(height: 8),
              const _PriceRow(
                label: AppStrings.shipping,
                value: AppStrings.shippingDynamic,
              ),
              const SizedBox(height: 8),
              _PriceRow(
                label: AppStrings.total,
                value: PriceFormatter.format(total),
                isTotal: true,
              ),
              const SizedBox(height: 16),
              _BuyNowButton(
                isLoading: isLoading,
                onPressed: () => ref.read(paymentProvider.notifier).pay(total),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _CartHeader extends StatelessWidget {
  const _CartHeader({required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                AppStrings.itemsInCart,
                style: TextStyle(fontSize: 13, color: AppColors.textSecondary),
              ),
              Text(
                count.toString().padLeft(2, '0'),
                style: const TextStyle(
                  fontSize: 26,
                  color: AppColors.primaryDark,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
          const Spacer(),
          const Icon(
            Icons.shopping_bag_outlined,
            color: AppColors.border,
            size: 72,
          ),
        ],
      ),
    );
  }
}

class _PriceRow extends StatelessWidget {
  const _PriceRow({
    required this.label,
    required this.value,
    this.isTotal = false,
  });

  final String label;
  final String value;
  final bool isTotal;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.textPrimary,
            fontSize: isTotal ? 16 : 14,
            fontWeight: isTotal ? FontWeight.w700 : FontWeight.w400,
          ),
        ),
        const Spacer(),
        Text(
          value,
          style: TextStyle(
            color: isTotal ? AppColors.primaryDark : AppColors.textSecondary,
            fontSize: isTotal ? 24 : 14,
            fontWeight: isTotal ? FontWeight.w800 : FontWeight.w400,
          ),
        ),
      ],
    );
  }
}

class _BuyNowButton extends StatelessWidget {
  const _BuyNowButton({required this.isLoading, required this.onPressed});

  final bool isLoading;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 56,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          disabledBackgroundColor: AppColors.primary.withAlpha(180),
          foregroundColor: AppColors.surface,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          elevation: 0,
        ),
        child: isLoading
            ? const SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  color: AppColors.surface,
                  strokeWidth: 2.5,
                ),
              )
            : const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppStrings.buyNow,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(width: 8),
                  Icon(Icons.arrow_forward, size: 18),
                ],
              ),
      ),
    );
  }
}
