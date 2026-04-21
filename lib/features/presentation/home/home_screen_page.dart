// ignore_for_file: use_super_parameters, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:one_profile/features/common/app_images.dart';
import 'package:one_profile/features/common/app_font.dart';
import 'package:one_profile/features/data/contact_data.dart';
import 'package:one_profile/l10n/app_localizations.dart';
import 'package:one_profile/l10n/locale_provider.dart';
import 'package:provider/provider.dart';
import 'package:one_profile/features/common/app_colors.dart';
import 'package:one_profile/features/presentation/home/home_screen_view_model.dart';
import 'package:one_profile/features/presentation/routes/home_routes.dart';
import 'package:one_profile/features/presentation/widgets/app_bar_home_screen.dart';
import 'package:one_profile/features/presentation/widgets/app_drawer.dart';
import 'package:one_profile/features/presentation/home/workpiece/work_piece_screen_page.dart';

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
                        const WelcomeBanner(),
                        const SizedBox(height: 25),
                        const SkillBanner(),
                        const SizedBox(height: 20),
                        const WorkPiece(),
                        const SizedBox(height: 20),
                        const SpecialOffers(),
                        const SizedBox(height: 20),
                        const HistoryBanner(),
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
          Image.network(AppImages.profileImage, height: 90),
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
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.text_position,
                  style: AppFont.promptBodyMedium.copyWith(
                    color: AppColors.primary_blue,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 4),
                Text(
                  AppLocalizations.of(context)!.text_location,
                  style: AppFont.promptBodySmall.copyWith(
                    color: AppColors.primary_blue,
                  ),
                  overflow: TextOverflow.ellipsis,
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(AppRoutes.resume);
      },
      child: Container(
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
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
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
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: AppLocalizations.of(context)!.competitionAndCollaboration,
            press: () {},
          ),
        ),
        SizedBox(
          height: 130,
          child: Consumer<HomeScreenViewModel>(
            builder: (context, viewModel, _) {
              return PageView(
                controller: viewModel.pageController,
                onPageChanged: (index) {
                  viewModel.updateCurrentPage(index);
                },
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SpecialOfferCard(
                      image: AppImages.tesaTopgunIcon,
                      eventtitle: AppLocalizations.of(context)!.tesaTopgunTitle,
                      subevent: AppLocalizations.of(context)!.tesaTopgunSubTitle,
                      press: () => viewModel.onSpecialOfferPressed(0),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SpecialOfferCard(
                      image: AppImages.popularVoteIcon,
                      eventtitle: AppLocalizations.of(context)!.popularVoteTitle,
                      subevent: AppLocalizations.of(context)!.popularVoteSubTitle,
                      press: () => viewModel.onSpecialOfferPressed(1),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: SpecialOfferCard(
                      image: AppImages.eventPoliceCareIcon,
                      eventtitle: AppLocalizations.of(
                        context,
                      )!.eventPoliceCareTitle,
                      subevent: AppLocalizations.of(
                        context,
                      )!.eventPoliceCareSubTitle,
                      press: () => viewModel.onSpecialOfferPressed(2),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
        const SizedBox(height: 16),
        // Dot indicators
        Consumer<HomeScreenViewModel>(
          builder: (context, viewModel, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  height: 8,
                  width: viewModel.currentPage == index ? 24 : 8,
                  decoration: BoxDecoration(
                    color: viewModel.currentPage == index
                        ? AppColors.primary_violet
                        : AppColors.grey.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class SpecialOfferCard extends StatelessWidget {
  const SpecialOfferCard({
    Key? key,
    required this.eventtitle,
    required this.image,
    required this.subevent,
    required this.press,
  }) : super(key: key);

  final String eventtitle, image;
  final String subevent;
  final GestureTapCallback press;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            Image.network(image, fit: BoxFit.cover, width: double.infinity),
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
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text.rich(
                TextSpan(
                  style: const TextStyle(color: Colors.white),
                  children: [
                    TextSpan(
                      text: "$eventtitle\n",
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    TextSpan(text: subevent, style: AppFont.promptBodySmall),
                  ],
                ),
              ),
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
    return Consumer<HomeScreenViewModel>(
      builder: (context, viewModel, _) {
        return Container(
          width: double.infinity,
          margin: const EdgeInsets.all(15),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
          decoration: BoxDecoration(
            color: AppColors.primary_violet,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary_violet.withOpacity(0.3),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of(context)!.contactChannels,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              Text(
                "Get in Touch",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              ...ContactDataManager.contactItems.map(
                (contact) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: _buildContactItem(
                    context: context,
                    viewModel: viewModel,
                    iconPath: contact.iconPath,
                    titleKey: contact.titleKey,
                    valueKey: contact.valueKey,
                    contactType: contact.type,
                    qrCodePath: contact.qrCodePath,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContactItem({
    required BuildContext context,
    required HomeScreenViewModel viewModel,
    required String iconPath,
    required String titleKey,
    required String valueKey,
    required ContactType contactType,
    String? qrCodePath,
  }) {
    final localizations = AppLocalizations.of(context)!;
    final title = viewModel.getLocalizedContactValue(localizations, titleKey);
    final value = viewModel.getLocalizedContactValue(localizations, valueKey);

    return Row(
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: iconPath.startsWith('http')
              ? Image.network(iconPath)
              : Image.asset(iconPath),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white70,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 12),
        if (qrCodePath != null)
          GestureDetector(
            onTap: () => viewModel.showQRCodeDialog(context, qrCodePath),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                Icons.qr_code,
                color: AppColors.primary_white,
                size: 28,
              ),
            ),
          ),
        if (qrCodePath != null) const SizedBox(width: 12),
        if (contactType == ContactType.phone)
          GestureDetector(
            onTap: () => viewModel.dialPhone(value),
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: Icon(
                Icons.phone,
                color: AppColors.primary_white,
                size: 28,
              ),
            ),
          ),
        if (contactType == ContactType.phone) const SizedBox(width: 12),
        GestureDetector(
          onTap: () =>
              viewModel.copyToClipboard(context, value, contactType, localizations),
          child: MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Icon(
              Icons.content_copy,
              color: AppColors.primary_white,
              size: 25,
            ),
          ),
        ),
      ],
    );
  }
}
