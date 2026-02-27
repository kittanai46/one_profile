import 'package:one_profile/features/data/home_data.dart';

class AchievementItem {
  final Product product;
  final bool useAssetImage;
  final String? assetImagePath;

  AchievementItem({
    required this.product,
    this.useAssetImage = false,
    this.assetImagePath,
  });
}

List<AchievementItem> achievementlist(List<Product> products) {
  return products.map((product) {
    return AchievementItem(
      product: product,
      useAssetImage: false,
      assetImagePath: null,
    );
  }).toList();
}
