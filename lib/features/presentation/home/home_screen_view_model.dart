import 'package:flutter/material.dart';
import 'package:one_profile/features/data/home_data.dart';
import 'package:one_profile/l10n/app_localizations.dart';

class HomeScreenViewModel extends ChangeNotifier {
  // Categories
  late List<Map<String, dynamic>> categories;

  // Products
  List<Product> popularProducts = [];

  // Initialize data with localization
  void initializeDataWithLocalization(AppLocalizations localizations) {
    _initializePopularProductsWithLocalization(localizations);
    notifyListeners();
  }

  // Get popular products with localization
  void _initializePopularProductsWithLocalization(
    AppLocalizations localizations,
  ) {
    final allProducts = getWorkpiece(localizations);
    popularProducts = allProducts.where((product) => product.isShow).toList();
  }

  // Get all categories
  List<Map<String, dynamic>> getCategories() {
    return categories;
  }

  // Get popular products
  List<Product> getPopularProducts() {
    return popularProducts;
  }

  // On category pressed
  void onCategoryPressed(int index) {
    // Handle category navigation or action
    debugPrint('Category ${categories[index]["text"]} pressed');
  }

  // On product pressed
  void onProductPressed(Product product) {
    // Handle product navigation or action
    debugPrint('Product ${product.title} pressed');
  }

  // On search
  void onSearch(String query) {
    // Handle search logic
    debugPrint('Search query: $query');
  }

  // On cart pressed
  void onCartPressed() {
    // Handle cart navigation
    debugPrint('Cart pressed');
  }

  // On notification pressed
  void onNotificationPressed() {
    // Handle notification navigation
    debugPrint('Notification pressed');
  }

  // On special offer pressed
  void onSpecialOfferPressed(int index) {
    // Handle special offer navigation
    debugPrint('Special offer $index pressed');
  }
}
