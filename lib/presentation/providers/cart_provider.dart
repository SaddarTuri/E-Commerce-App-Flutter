import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/cart_item_entity.dart';
import '../../domain/entities/product_entity.dart';

class CartNotifier extends StateNotifier<List<CartItemEntity>> {
  CartNotifier() : super(const []);

  void addToCart(ProductEntity product) {
    final index = state.indexWhere((item) => item.product.id == product.id);
    if (index == -1) {
      state = [...state, CartItemEntity(product: product, quantity: 1)];
      return;
    }
    final next = [...state];
    next[index] = next[index].copyWith(quantity: next[index].quantity + 1);
    state = next;
  }

  void removeFromCart(int productId) {
    state = state.where((item) => item.product.id != productId).toList();
  }

  void increaseQuantity(int productId) {
    state = state
        .map(
          (item) => item.product.id == productId
              ? item.copyWith(quantity: item.quantity + 1)
              : item,
        )
        .toList();
  }

  void decreaseQuantity(int productId) {
    state = state
        .map(
          (item) => item.product.id == productId
              ? item.copyWith(quantity: item.quantity - 1)
              : item,
        )
        .where((item) => item.quantity > 0)
        .toList();
  }

  void clear() => state = const [];
}

final cartProvider = StateNotifierProvider<CartNotifier, List<CartItemEntity>>(
  (ref) => CartNotifier(),
);
final cartTotalProvider = Provider<double>((ref) {
  return ref
      .watch(cartProvider)
      .fold<double>(
        0,
        (sum, item) => sum + (item.product.price * item.quantity),
      );
});

final cartCountProvider = Provider<int>((ref) {
  return ref
      .watch(cartProvider)
      .fold<int>(0, (sum, item) => sum + item.quantity);
});
