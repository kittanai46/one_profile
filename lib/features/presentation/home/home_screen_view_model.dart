import 'package:flutter/material.dart';
import 'package:one_profile/features/data/home_data.dart';
import 'package:one_profile/l10n/app_localizations.dart';

class HomeScreenViewModel extends ChangeNotifier {
  // Categories
  late List<Map<String, dynamic>> categories;

  // Products
  List<Product> popularProducts = [];

  // Constructor
  HomeScreenViewModel() {
    _initializeData();
  }

  // Initialize data with localization
  void initializeDataWithLocalization(AppLocalizations localizations) {
    _initializeCategories();
    _initializePopularProductsWithLocalization(localizations);
    notifyListeners();
  }

  // Initialize data
  void _initializeData() {
    _initializeCategories();
  }

  // Initialize categories
  void _initializeCategories() {
    categories = [
      {"icon": flashIcon, "text": "Flash Deal"},
      {"icon": billIcon, "text": "Bill"},
      {"icon": gameIcon, "text": "Game"},
      {"icon": giftIcon, "text": "Daily Gift"},
      {"icon": discoverIcon, "text": "More"},
    ];
  }

  // Get popular products with localization
  void _initializePopularProductsWithLocalization(
    AppLocalizations localizations,
  ) {
    final allProducts = getDemoProducts(localizations);
    popularProducts = allProducts
        .where((product) => product.isPopular)
        .toList();
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
