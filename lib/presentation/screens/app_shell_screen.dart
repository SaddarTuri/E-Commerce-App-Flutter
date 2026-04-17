import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_strings.dart';
import '../providers/navigation_provider.dart';
import 'product_listing_screen.dart';
import 'profile_screen.dart';
import 'search_screen.dart';

class AppShellScreen extends ConsumerWidget {
  const AppShellScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final navIndex = ref.watch(bottomNavIndexProvider);
    final safeIndex = navIndex > 2 ? 0 : navIndex;

    return Scaffold(
      backgroundColor: AppColors.background,
      drawer: const _AppDrawer(),
      body: IndexedStack(
        index: safeIndex,
        children: const [
          ProductListingScreen(),
          SearchScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: NavigationBar(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.chipBackground,
        selectedIndex: safeIndex,
        onDestinationSelected: (index) {
          ref.read(bottomNavIndexProvider.notifier).state = index;
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.storefront_outlined),
            label: AppStrings.shop,
          ),
          NavigationDestination(
            icon: Icon(Icons.search),
            label: AppStrings.search,
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            label: AppStrings.profile,
          ),
        ],
      ),
    );
  }
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.background,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            children: [
              Row(
                children: [
                  ClipOval(
                    child: Image.network(
                      AppStrings.profileAvatarUrl,
                      width: 56,
                      height: 56,
                      fit: BoxFit.cover,
                      errorBuilder: (_, error, stackTrace) =>
                          const CircleAvatar(
                            radius: 28,
                            backgroundColor: AppColors.card,
                            child: Icon(
                              Icons.person,
                              color: AppColors.textSecondary,
                            ),
                          ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Text(
                      AppStrings.alexName,
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              _DrawerTile(
                icon: Icons.link,
                title: AppStrings.connectStripe,
                onTap: () => _showComingSoon(context),
              ),
              const SizedBox(height: 10),
              _DrawerTile(
                icon: Icons.settings_outlined,
                title: AppStrings.settings,
                onTap: () => _showComingSoon(context),
              ),
              const SizedBox(height: 10),
              _DrawerTile(
                icon: Icons.language,
                title: AppStrings.language,
                onTap: () => _showComingSoon(context),
              ),
              const Spacer(),
              _DrawerTile(
                icon: Icons.logout,
                title: AppStrings.logout,
                isDanger: true,
                onTap: () => _showComingSoon(context),
              ),
            ],
          ),
        ),
      ),
    );
  }

  static void _showComingSoon(BuildContext context) {
    Navigator.pop(context);
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text(AppStrings.comingSoon)));
  }
}

class _DrawerTile extends StatelessWidget {
  const _DrawerTile({
    required this.icon,
    required this.title,
    required this.onTap,
    this.isDanger = false,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;
  final bool isDanger;

  @override
  Widget build(BuildContext context) {
    final iconColor = isDanger ? AppColors.logoutText : AppColors.primaryDark;
    final textColor = isDanger ? AppColors.logoutText : AppColors.textPrimary;

    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 14),
        decoration: BoxDecoration(
          color: isDanger ? AppColors.logoutBackground : AppColors.card,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Icon(icon, color: iconColor, size: 20),
            const SizedBox(width: 12),
            Text(
              title,
              style: TextStyle(
                color: textColor,
                fontSize: 15,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
