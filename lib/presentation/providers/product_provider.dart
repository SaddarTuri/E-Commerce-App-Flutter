import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/di/providers.dart';
import '../../domain/entities/product_entity.dart';

final productProvider = FutureProvider<List<ProductEntity>>((ref) async {
  return ref.watch(getProductsUseCaseProvider).call();
});
