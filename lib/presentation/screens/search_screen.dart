import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../providers/navigation_provider.dart';
import '../widgets/cart_action_icon.dart';
import 'cart_screen.dart';

class SearchScreen extends ConsumerWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const imageUrls = [
      AppStrings.dummySearchImageA,
      AppStrings.dummySearchImageB,
      AppStrings.dummySearchImageC,
      AppStrings.dummySearchImageD,
      AppStrings.dummySearchImageE,
    ];

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          children: [
            Row(
              children: [
                InkWell(
                  onTap: () =>
                      ref.read(bottomNavIndexProvider.notifier).state = 0,
                  child: const Icon(
                    Icons.arrow_back,
                    color: AppColors.primaryDark,
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  AppStrings.search,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                const Spacer(),
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
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: [
                  const TextField(
                    decoration: InputDecoration(
                      hintText: AppStrings.searchProducts,
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: AppColors.surface,
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.all(Radius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Row(
                    children: [
                      Text(
                        AppStrings.recentSearches,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      Spacer(),
                      Text(
                        AppStrings.clearAll,
                        style: TextStyle(color: AppColors.primaryDark),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: AppStrings.searchTags
                        .map(
                          (tag) => Chip(
                            label: Text(tag),
                            backgroundColor: AppColors.chipBackground,
                            side: BorderSide.none,
                          ),
                        )
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    AppStrings.popularCategories,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GridView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          childAspectRatio: 1.1,
                        ),
                    itemCount: AppStrings.popularCategoryNames.length,
                    itemBuilder: (context, index) {
                      return Container(
                        decoration: BoxDecoration(
                          color: AppColors.card,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                imageUrls[index],
                                fit: BoxFit.cover,
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: Text(
                                  AppStrings.popularCategoryNames[index],
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.textPrimary,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    AppStrings.suggestedForYou,
                    style: TextStyle(
                      color: AppColors.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _suggestionCard(
                    AppStrings.fluxPrecisionRunner,
                    AppStrings.fluxPrice,
                    AppStrings.dummySuggestImageA,
                  ),
                  const SizedBox(height: 10),
                  _suggestionCard(
                    AppStrings.essentialLinenShirt,
                    AppStrings.linenShirtPrice,
                    AppStrings.dummySuggestImageB,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget _suggestionCard(String title, String price, String imageUrl) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              imageUrl,
              width: 64,
              height: 56,
              fit: BoxFit.cover,
              errorBuilder: (_, error, stackTrace) {
                return Container(
                  width: 64,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.card,
                    borderRadius: BorderRadius.circular(10),
                  ),
                );
              },
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                Text(
                  price,
                  style: const TextStyle(color: AppColors.textSecondary),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}
