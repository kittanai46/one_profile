import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:one_profile/features/data/achievements_data.dart';
import 'package:one_profile/features/data/contact_data.dart';
import 'package:one_profile/l10n/app_localizations.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeScreenViewModel extends ChangeNotifier {
  // Categories
  late List<Map<String, dynamic>> categories;

  // Products
  List<Product> popularProducts = [];

  // Special Offers - Pagination
  late PageController pageController;
  int currentPage = 0;
  late Timer autoScrollTimer;

  HomeScreenViewModel() {
    pageController = PageController(viewportFraction: 0.85);
  }

  // Initialize data with localization
  void initializeDataWithLocalization(AppLocalizations localizations) {
    _initializePopularProductsWithLocalization(localizations);
    _startAutoScroll();
    notifyListeners();
  }

  // Get popular products with localization
  void _initializePopularProductsWithLocalization(
    AppLocalizations localizations,
  ) {
    final allProducts = getAchievements(localizations);
    popularProducts = allProducts.where((product) => product.isShow).toList();
  }

  // Auto-scroll for special offers
  void _startAutoScroll() {
    autoScrollTimer = Timer.periodic(const Duration(seconds: 4), (timer) {
      currentPage = (currentPage + 1) % 3;
      if (pageController.hasClients) {
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void updateCurrentPage(int index) {
    currentPage = index;
    notifyListeners();
  }

  // Get all categories
  List<Map<String, dynamic>> getCategories() {
    return categories;
  }

  // Get popular products
  List<Product> getPopularProducts() {
    return popularProducts;
  }

  // Contact handling methods
  String getLocalizedContactValue(AppLocalizations localizations, String key) {
    switch (key) {
      case "email":
        return localizations.email;
      case "contactGmail":
        return localizations.contactGmail;
      case "phone":
        return localizations.phone;
      case "contactPhone":
        return localizations.contactPhone;
      case "line":
        return localizations.line;
      case "contactLineid":
        return localizations.contactLineid;
      case "github":
        return localizations.github;
      case "contactGithub":
        return localizations.contactGithub;
      case "linkedin":
        return localizations.linkedin;
      case "contactLinkedin":
        return localizations.contactLinkedin;
      default:
        return key;
    }
  }

  Future<void> copyToClipboard(
    BuildContext context,
    String value,
    ContactType contactType,
    AppLocalizations localizations,
  ) async {
    await Clipboard.setData(ClipboardData(text: value));
    if (context.mounted) {
      String message = '';
      switch (contactType) {
        case ContactType.email:
          message = 'Email ${localizations.copied}';
          break;
        case ContactType.phone:
          message = 'Phone Number ${localizations.copied}';
          break;
        case ContactType.line:
          message = 'Line ID ${localizations.copied}';
          break;
        case ContactType.github:
          message = 'GitHub ${localizations.copied}';
          break;
        case ContactType.linkedin:
          message = 'LinkedIn ${localizations.copied}';
          break;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  Future<void> dialPhone(String phoneNumber) async {
    final phoneUrl = 'tel:$phoneNumber';
    if (await canLaunchUrl(Uri.parse(phoneUrl))) {
      await launchUrl(Uri.parse(phoneUrl));
    }
  }

  void showQRCodeDialog(BuildContext context, String qrCodePath) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.8,
              ),
              child: qrCodePath.startsWith('http')
                  ? Image.network(qrCodePath)
                  : Image.asset(qrCodePath),
            ),
          ),
        );
      },
    );
  }

  // On special offer pressed
  void onSpecialOfferPressed(int index) {
    // Handle special offer navigation
    debugPrint('Special offer $index pressed');
  }

  @override
  void dispose() {
    autoScrollTimer.cancel();
    pageController.dispose();
    super.dispose();
  }
}
