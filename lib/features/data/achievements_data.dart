
import 'package:one_profile/features/common/app_images.dart';
import 'package:one_profile/l10n/app_localizations.dart';

class Product {
  final int id;
  final String title, description;
  final List<String> images;
  final bool isShow;

  Product({
    required this.id,
    required this.images,
    this.isShow = false,
    required this.title,
    required this.description,
  });
}

List<Product> getAchievements(AppLocalizations localizations) => [
  Product(
    id: 1,
    images: [AppImages.classTrackingIcon],
    title: localizations.iteam_01,
    description: localizations.description_01,
    isShow: true,
  ),
  Product(
    id: 2,
    images: [AppImages.wpfIcon],
    title: localizations.iteam_02,
    description: localizations.description_02,
    isShow: true,
  ),
  Product(
    id: 3,
    images: [AppImages.automationIcon],
    title: localizations.iteam_03,
    description: localizations.description_03,
    isShow: true,
  ),
  Product(
    id: 4,
    images: [AppImages.backofficeIcon],
    title: localizations.iteam_04,
    description: localizations.description_04,
    isShow: true,
  ),
];
