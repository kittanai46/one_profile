// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one_profile/features/common/app_images.dart';
import 'package:one_profile/features/common/app_font.dart';
import 'package:one_profile/l10n/app_localizations.dart';
import 'package:one_profile/l10n/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:one_profile/features/common/app_colors.dart';
import 'package:one_profile/features/data/home_data.dart';
import 'package:one_profile/features/presentation/home/home_screen_view_model.dart';
import 'package:one_profile/features/presentation/routes/home_routes.dart';
import 'package:one_profile/features/presentation/widgets/app_bar_home_screen.dart';
import 'package:one_profile/features/presentation/widgets/app_drawer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<LocaleProvider>(
      builder: (context, localeProvider, _) {
        return ChangeNotifierProvider(
          key: ValueKey<String>(localeProvider.locale.languageCode),
          create: (_) => HomeScreenViewModel(),
          child: Consumer<HomeScreenViewModel>(
            builder: (context, viewModel, _) {
              final localizations = AppLocalizations.of(context)!;
              // Initialize with localization after build phase completes
              if (viewModel.popularProducts.isEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  viewModel.initializeDataWithLocalization(localizations);
                });
              }
              return Scaffold(
                appBar: const PreferredSize(
                  preferredSize: Size.fromHeight(kToolbarHeight),
                  child: ResponsiveNavBar(),
                ),
                endDrawer: const AppDrawer(),
                body: SafeArea(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    child: Column(
                      children: [
                        //ลำดับการจัดวาง Widget
                        const WelcomeBanner(),
                        const SizedBox(height: 25),
                        const SkillBanner(),
                        const SizedBox(height: 20),
                        const ApplicationDev(),
                        const SizedBox(height: 20),
                        const SpecialOffers(),
                        const SizedBox(height: 20),
                        const HistoryBanner(),
                        const SizedBox(height: 20),
                        const ContactBanner(),
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class IconBtnWithCounter extends StatelessWidget {
  const IconBtnWithCounter({
    Key? key,
    required this.svgSrc,
    this.numOfitem = 0,
    required this.press,
  }) : super(key: key);

  final String svgSrc;
  final int numOfitem;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(100),
      onTap: press,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            height: 46,
            width: 46,
            decoration: BoxDecoration(
              color: AppColors.grey.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: SvgPicture.string(svgSrc),
          ),
          if (numOfitem != 0)
            Positioned(
              top: -3,
              right: 0,
              child: Container(
                height: 20,
                width: 20,
                decoration: BoxDecoration(
                  color: AppColors.primary_red,
                  shape: BoxShape.circle,
                  border: Border.all(width: 1.5, color: Colors.white),
                ),
                child: Center(
                  child: Text(
                    "$numOfitem",
                    style: const TextStyle(
                      fontSize: 12,
                      height: 1,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class WelcomeBanner extends StatelessWidget {
  const WelcomeBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 0),
      padding: const EdgeInsets.only(left: 12, right: 12, bottom: 0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.asset(AppImages.profileImage, height: 90),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  AppLocalizations.of(context)!.text_name,
                  style: AppFont.promptBodyLarge.copyWith(
                    color: AppColors.primary_blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.text_position,
                  style: AppFont.promptBodyMedium.copyWith(
                    color: AppColors.primary_blue,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.text_location,
                  style: AppFont.promptBodySmall.copyWith(
                    color: AppColors.primary_blue,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SkillBanner extends StatelessWidget {
  const SkillBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.primary_violet,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: "${AppLocalizations.of(context)!.skillsAbilities}\n",
            ),
            TextSpan(
              text: AppLocalizations.of(context)!.resumeCv,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class ApplicationDev extends StatelessWidget {
  const ApplicationDev({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: AppLocalizations.of(context)!.applicationsDeveloped,
            press: () =>
                Navigator.of(context).pushNamed(AppRoutes.applicationDev),
          ),
        ),
        Consumer<HomeScreenViewModel>(
          builder: (context, viewModel, _) {
            final popularProducts = viewModel.getPopularProducts();
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  ...List.generate(popularProducts.length, (index) {
                    return Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: ProductCard(
                        product: popularProducts[index],
                        onPress: () {
                          if (index == 0) {
                            Navigator.of(
                              context,
                            ).pushNamed(AppRoutes.classTracking);
                          } else {
                            viewModel.onProductPressed(popularProducts[index]);
                          }
                        },
                        isFirstProduct: index == 0,
                      ),
                    );
                  }),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}

class HistoryBanner extends StatelessWidget {
  const HistoryBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(15),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        color: AppColors.primary_violet,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(color: Colors.white),
          children: [
            TextSpan(text: "${AppLocalizations.of(context)!.workHistory}\n"),
            TextSpan(
              text: AppLocalizations.of(context)!.cashbackOffer,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    Key? key,
    required this.icon,
    required this.text,
    required this.press,
  }) : super(key: key);

  final String icon, text;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: AppColors.lightOrange,
              borderRadius: BorderRadius.circular(10),
            ),
            child: SvgPicture.string(icon),
          ),
          const SizedBox(height: 4),
          Text(text, textAlign: TextAlign.center),
        ],
      ),
    );
  }
}

class SpecialOffers extends StatelessWidget {
  const SpecialOffers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = context.read<HomeScreenViewModel>();

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: AppLocalizations.of(context)!.competitionAndCollaboration,
            press: () {},
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: [
              SpecialOfferCard(
                image: specialOfferImage1,
                category: AppLocalizations.of(context)!.smartphoneCategory,
                numOfBrands: 18,
                press: () => viewModel.onSpecialOfferPressed(0),
              ),
              SpecialOfferCard(
                image: specialOfferImage2,
                category: AppLocalizations.of(context)!.fashionCategory,
                numOfBrands: 24,
                press: () => viewModel.onSpecialOfferPressed(1),
              ),
              const SizedBox(width: 20),
            ],
          ),
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.category,
    required this.image,
    required this.numOfBrands,
    required this.press,
  }) : super(key: key);

  final String category, image;
  final int numOfBrands;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20),
      child: GestureDetector(
        onTap: press,
        child: SizedBox(
          width: 242,
          height: 100,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: Stack(
              children: [
                Image.network(image, fit: BoxFit.cover),
                Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.black54,
                        Colors.black38,
                        Colors.black26,
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 15,
                    vertical: 10,
                  ),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(color: Colors.white),
                      children: [
                        TextSpan(
                          text: "$category\n",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextSpan(
                          text:
                              "$numOfBrands ${AppLocalizations.of(context)!.brands}",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  const SectionTitle({Key? key, required this.title, required this.press})
    : super(key: key);

  final String title;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
        TextButton(
          onPressed: press,
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          child: Text(AppLocalizations.of(context)!.seeMore),
        ),
      ],
    );
  }
}

class ProductCard extends StatelessWidget {
  const ProductCard({
    Key? key,
    this.width = 140,
    this.aspectRetio = 1.02,
    required this.product,
    required this.onPress,
    this.isFirstProduct = false,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final VoidCallback onPress;
  final bool isFirstProduct;

  @override
  Widget build(BuildContext context) {
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
                  color: AppColors.grey.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: isFirstProduct
                    ? Image.asset(AppImages.classTrackingIcon)
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

class ContactBanner extends StatelessWidget {
  const ContactBanner({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      decoration: BoxDecoration(
        color: AppColors.primary_violet,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text.rich(
        TextSpan(
          style: const TextStyle(color: Colors.white),
          children: [
            TextSpan(
              text: AppLocalizations.of(context)!.contactChannels,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
