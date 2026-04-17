import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../providers/navigation_provider.dart';
import '../widgets/cart_action_icon.dart';
import 'cart_screen.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
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
                  AppStrings.profile,
                  style: TextStyle(
                    fontSize: 20,
                    color: AppColors.primaryDark,
                    fontWeight: FontWeight.w700,
                  ),
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
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 8),
                    SizedBox(
                      width: 90,
                      height: 90,
                      child: Stack(
                        children: [
                          ClipOval(
                            child: Image.network(
                              AppStrings.profileAvatarUrl,
                              width: 90,
                              height: 90,
                              fit: BoxFit.cover,
                              errorBuilder: (_, error, stackTrace) {
                                return const CircleAvatar(
                                  radius: 45,
                                  backgroundColor: AppColors.card,
                                  child: Icon(
                                    Icons.person,
                                    size: 48,
                                    color: AppColors.textSecondary,
                                  ),
                                );
                              },
                            ),
                          ),
                          Positioned(
                            right: 0,
                            bottom: 0,
                            child: Container(
                              width: 26,
                              height: 26,
                              decoration: BoxDecoration(
                                color: AppColors.primary,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: AppColors.surface,
                                  width: 2,
                                ),
                              ),
                              child: const Icon(
                                Icons.edit,
                                size: 13,
                                color: AppColors.surface,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      AppStrings.alexName,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 3),
                    const Text(
                      AppStrings.alexEmail,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.successChip,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Text(
                        AppStrings.goldMember,
                        style: TextStyle(
                          fontSize: 11,
                          letterSpacing: 0.8,
                          color: AppColors.success,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    const _ProfileOptionCard(
                      title: AppStrings.myOrders,
                      icon: Icons.local_shipping_outlined,
                    ),
                    const SizedBox(height: 10),
                    const _ProfileOptionCard(
                      title: AppStrings.shippingAddress,
                      icon: Icons.location_on_outlined,
                    ),
                    const SizedBox(height: 10),
                    const _ProfileOptionCard(
                      title: AppStrings.paymentMethods,
                      icon: Icons.credit_card_outlined,
                    ),
                    const SizedBox(height: 22),
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        AppStrings.accountPreferences,
                        style: TextStyle(
                          color: AppColors.textSecondary,
                          letterSpacing: 2.0,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    const _ProfileOptionCard(
                      title: AppStrings.settings,
                      icon: Icons.settings_outlined,
                    ),
                    const SizedBox(height: 10),
                    const _ProfileOptionCard(
                      title: AppStrings.helpSupport,
                      icon: Icons.help_outline,
                    ),
                    const SizedBox(height: 22),
                    InkWell(
                      borderRadius: BorderRadius.circular(14),
                      onTap: () {},
                      child: Container(
                        width: double.infinity,
                        height: 52,
                        decoration: BoxDecoration(
                          color: AppColors.logoutBackground,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.logout,
                              color: AppColors.logoutText,
                              size: 20,
                            ),
                            SizedBox(width: 8),
                            Text(
                              AppStrings.logout,
                              style: TextStyle(
                                color: AppColors.logoutText,
                                fontWeight: FontWeight.w600,
                                fontSize: 15,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      AppStrings.appVersion,
                      style: TextStyle(
                        color: AppColors.textSecondary,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 8),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileOptionCard extends StatelessWidget {
  const _ProfileOptionCard({required this.title, required this.icon});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {},
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
        decoration: BoxDecoration(
          color: AppColors.card,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: AppColors.chipBackground,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: AppColors.primaryDark, size: 18),
            ),
            const SizedBox(width: 14),
            Text(
              title,
              style: const TextStyle(
                fontSize: 15,
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              color: AppColors.textSecondary,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }
}
