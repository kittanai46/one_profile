// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:one_profile/features/presentation/routes/home_routes.dart';
import 'package:one_profile/l10n/app_localizations.dart';

import '../../../data/home_data.dart';
import 'achievement_list.dart';

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final achievementItems = achievementlist(getDemoProducts(localizations));

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(title: const Text("Products")),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: GridView.builder(
            itemCount: achievementItems.length,
            gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 0.7,
              mainAxisSpacing: 20,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) => ProductCard(
              item: achievementItems[index],
              index: index,
              onPress: () {
                if (index == 0) {
                  Navigator.of(context).pushNamed(AppRoutes.classTracking);
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.item,
    required this.onPress,
    this.index = -1,
  }) : super(key: key);

  final double width, aspectRetio;
  final AchievementItem item;
  final VoidCallback onPress;
  final int index;

  @override
  Widget build(BuildContext context) {
    final product = item.product;

    return SizedBox(
      width: width,
      child: GestureDetector(
        onTap: onPress,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1.02,
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFF979797).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: item.useAssetImage && item.assetImagePath != null
                    ? Image.asset(item.assetImagePath!)
                    : Image.network(product.images[0]),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.title,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
            ),
          ],
        ),
      ),
    );
  }
}
