// ignore_for_file: unreachable_switch_case

import 'package:flutter/material.dart';
import 'package:one_profile/features/presentation/home/home_screen_page.dart';
import 'package:one_profile/features/presentation/home/splash_screen_page.dart';
import 'package:one_profile/features/presentation/home/achievement/achievement_screen_page.dart';
import 'package:one_profile/features/presentation/home/achievement/classtracking_screen_page.dart';
import 'package:one_profile/features/presentation/home/language_select_page.dart';

class AppRoutes {
  static const String splash = '/splash';
  static const String home = '/home';
  static const String applicationDev = '/application_dev';
  static const String classTracking = '/class_tracking';
  static const String languageSelect = '/language_select';
}

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    final String routeName = settings.name ?? '/splash';

    switch (routeName) {
      case AppRoutes.splash:
      case '/splash':
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: const RouteSettings(name: '/splash'),
        );
      case AppRoutes.home:
      case '/home':
      case '/':
        return MaterialPageRoute(
          builder: (_) => const HomeScreen(),
          settings: const RouteSettings(name: '/home'),
        );
      case AppRoutes.applicationDev:
      case '/application_dev':
        return MaterialPageRoute(
          builder: (_) => const ProductsScreen(),
          settings: const RouteSettings(name: '/application_dev'),
        );
      case AppRoutes.classTracking:
      case '/class_tracking':
        return MaterialPageRoute(
          builder: (_) => const ClassTrackingScreen(),
          settings: const RouteSettings(name: '/class_tracking'),
        );
      case AppRoutes.languageSelect:
      case '/language_select':
        return MaterialPageRoute(
          builder: (_) => const LanguageSelectPage(),
          settings: const RouteSettings(name: '/language_select'),
        );
      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
          settings: const RouteSettings(name: '/splash'),
        );
    }
  }
}
