import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../core/utils/price_formatter.dart';
import '../../domain/entities/product_entity.dart';
import 'primary_button.dart';

class ProductCard extends StatelessWidget {
  const ProductCard({
    super.key,
    required this.product,
    required this.onAddToCart,
  });

  final ProductEntity product;
  final VoidCallback onAddToCart;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: AspectRatio(
              aspectRatio: 1.2,
              child: Image.network(
                product.image,
                fit: BoxFit.cover,
                errorBuilder: (_, error, stackTrace) => Container(
                  color: AppColors.card,
                  child: const Center(
                    child: Text(
                      AppStrings.noImage,
                      style: TextStyle(color: AppColors.textSecondary),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.textPrimary,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            PriceFormatter.format(product.price),
            style: const TextStyle(
              color: AppColors.primaryDark,
              fontSize: 16,
              fontWeight: FontWeight.w700,
            ),
          ),
          const Spacer(),
          PrimaryButton(
            label: AppStrings.addToCart,
            onPressed: onAddToCart,
            icon: Icons.shopping_cart_checkout,
            compact: true,
            height: 44,
          ),
        ],
      ),
    );
  }
}
