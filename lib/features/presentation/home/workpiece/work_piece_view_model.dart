import 'package:flutter/material.dart';
import 'package:one_profile/features/common/app_images.dart';
import 'package:one_profile/features/data/home_data.dart';
import 'package:one_profile/features/presentation/routes/home_routes.dart';

class WorkPieceViewModel extends ChangeNotifier {
  /// Get image path for product based on index
  String? getProductImagePath(int index) {
    switch (index) {
      case 0:
        return AppImages.classTrackingIcon;
      case 1:
        return AppImages.wpfIcon;
      case 2:
        return AppImages.automationIcon;
      case 3:
        return AppImages.backofficeIcon;
      default:
        return null;
    }
  }

  /// Handle product card press
  void onProductPressed(int index, Product product, BuildContext context) {
    if (index == 0) {
      Navigator.of(context).pushNamed(AppRoutes.classTracking);
    } else {
      debugPrint('Product ${product.title} pressed');
    }
  }
}
