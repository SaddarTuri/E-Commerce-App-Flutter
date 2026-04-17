import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../providers/navigation_provider.dart';
import '../widgets/primary_button.dart';

class EmptyCartScreen extends ConsumerWidget {
  const EmptyCartScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
                    AppStrings.appName,
                    style: TextStyle(
                      fontSize: 17,
                      color: AppColors.primaryDark,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.shopping_bag_outlined,
                    color: AppColors.primaryDark,
                  ),
                ],
              ),
              const SizedBox(height: 44),
              Container(
                width: 130,
                height: 130,
                decoration: const BoxDecoration(
                  color: AppColors.surface,
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.shopping_basket,
                  color: AppColors.primary,
                  size: 60,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                AppStrings.cartEmptyTitle,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 10),
              const Text(
                AppStrings.cartEmptySubtitle,
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary, fontSize: 14),
              ),
              const SizedBox(height: 20),
              PrimaryButton(
                label: AppStrings.startShopping,
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                  ref.read(bottomNavIndexProvider.notifier).state = 0;
                },
              ),
              const SizedBox(height: 20),
              Row(
                children: const [
                  Expanded(
                    child: _InfoCard(
                      title: AppStrings.newArrivals,
                      subtitle: AppStrings.latestCuratedPieces,
                    ),
                  ),
                  SizedBox(width: 12),
                  Expanded(
                    child: _InfoCard(
                      title: AppStrings.bestSellers,
                      subtitle: AppStrings.communityFavorites,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.chipBackground,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.verified, color: AppColors.mutedIcon),
          const SizedBox(height: 10),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
          Text(
            subtitle,
            style: const TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
