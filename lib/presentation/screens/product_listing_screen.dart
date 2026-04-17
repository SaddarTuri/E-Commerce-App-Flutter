import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../../domain/entities/product_entity.dart';
import '../providers/cart_provider.dart';
import '../providers/product_provider.dart';
import '../widgets/cart_action_icon.dart';
import '../widgets/product_card.dart';
import 'cart_screen.dart';

class ProductListingScreen extends ConsumerStatefulWidget {
  const ProductListingScreen({super.key});

  @override
  ConsumerState<ProductListingScreen> createState() =>
      _ProductListingScreenState();
}

class _ProductListingScreenState extends ConsumerState<ProductListingScreen> {
  late final PageController _pageController;
  Timer? _timer;
  int _bannerIndex = 0;
  int _selectedCategoryIndex = 0;

  static const _categories = [
    AppStrings.allItems,
    AppStrings.apparel,
    AppStrings.home,
    AppStrings.beauty,
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_pageController.hasClients) {
        return;
      }
      final next = (_bannerIndex + 1) % AppStrings.shopBannerImages.length;
      _pageController.animateToPage(
        next,
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _pageController.dispose();
    super.dispose();
  }

  List<ProductEntity> _filterProducts(List<ProductEntity> items) {
    final selected = _categories[_selectedCategoryIndex];
    if (selected == AppStrings.allItems) {
      return items;
    }

    return items.where((product) {
      final category = product.category.toLowerCase();
      if (selected == AppStrings.apparel) {
        return category.contains('clothing') || category.contains('apparel');
      }
      if (selected == AppStrings.home) {
        return category.contains('electronics') || category.contains('home');
      }
      if (selected == AppStrings.beauty) {
        return category.contains('jewel') ||
            category.contains('beauty') ||
            category.contains('cosmetic');
      }
      return true;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final products = ref.watch(productProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(16),
                  onTap: () => Scaffold.of(context).openDrawer(),
                  child: const Icon(Icons.menu, color: AppColors.primaryDark),
                ),
                const SizedBox(width: 10),
                const Text(
                  AppStrings.shop,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const Icon(Icons.search, color: AppColors.textPrimary),
                const SizedBox(width: 16),
                CartActionIcon(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (_) => const CartScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 14),
            SizedBox(
              height: 135,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: PageView.builder(
                  controller: _pageController,
                  onPageChanged: (index) {
                    if (!mounted) {
                      return;
                    }
                    setState(() => _bannerIndex = index);
                  },
                  itemCount: AppStrings.shopBannerImages.length,
                  itemBuilder: (context, index) {
                    return Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          AppStrings.shopBannerImages[index],
                          fit: BoxFit.cover,
                        ),
                        Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight,
                              colors: [Color(0x77000000), Color(0x22000000)],
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(18),
                          child: Text(
                            AppStrings.shopBannerTexts[index],
                            style: const TextStyle(
                              color: AppColors.surface,
                              fontSize: 18,
                              height: 1.1,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                AppStrings.shopBannerImages.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  width: _bannerIndex == index ? 18 : 6,
                  height: 6,
                  decoration: BoxDecoration(
                    color: _bannerIndex == index
                        ? AppColors.primary
                        : AppColors.border,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 40,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final isSelected = index == _selectedCategoryIndex;
                  return InkWell(
                    onTap: () {
                      if (!mounted) {
                        return;
                      }
                      setState(() => _selectedCategoryIndex = index);
                    },
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 18),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: isSelected
                            ? AppColors.primary
                            : AppColors.chipBackground,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        _categories[index],
                        style: TextStyle(
                          color: isSelected
                              ? AppColors.surface
                              : AppColors.textSecondary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (_, index) => const SizedBox(width: 8),
                itemCount: _categories.length,
              ),
            ),
            const SizedBox(height: 14),
            Expanded(
              child: products.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (error, stackTrace) =>
                    const Center(child: Text(AppStrings.fetchError)),
                data: (items) {
                  final filteredItems = _filterProducts(items);
                  if (filteredItems.isEmpty) {
                    return const Center(
                      child: Text(AppStrings.noItemsInCategory),
                    );
                  }
                  return GridView.builder(
                    itemCount: filteredItems.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.58,
                        ),
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return ProductCard(
                        product: item,
                        onAddToCart: () {
                          ref.read(cartProvider.notifier).addToCart(item);
                          ScaffoldMessenger.of(context).hideCurrentSnackBar();
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text(AppStrings.itemAddedToCart),
                              duration: Duration(milliseconds: 1000),
                            ),
                          );
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
