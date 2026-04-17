import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../providers/cart_provider.dart';

class CartActionIcon extends ConsumerWidget {
  const CartActionIcon({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final count = ref.watch(cartCountProvider);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(24),
      child: SizedBox(
        width: 34,
        height: 34,
        child: Stack(
          clipBehavior: Clip.hardEdge,
          children: [
            const Align(
              alignment: Alignment.center,
              child: Icon(Icons.shopping_cart, color: AppColors.primaryDark),
            ),
            if (count > 0)
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  height: 16,
                  constraints: const BoxConstraints(minWidth: 16),
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                  alignment: Alignment.center,
                  decoration: const BoxDecoration(
                    color: AppColors.badgeRed,
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    count > 99 ? '99+' : '$count',
                    style: const TextStyle(
                      color: AppColors.surface,
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
