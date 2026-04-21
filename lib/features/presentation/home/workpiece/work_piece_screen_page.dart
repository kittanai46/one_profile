// ignore_for_file: use_super_parameters, deprecated_member_use

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:one_profile/features/common/app_colors.dart';
import 'package:one_profile/features/common/app_font.dart';
import 'package:one_profile/features/common/app_images.dart';
import 'package:one_profile/features/data/home_data.dart';
import 'package:one_profile/features/presentation/home/home_screen_view_model.dart';
import 'package:one_profile/features/presentation/home/workpiece/work_piece_view_model.dart';
import 'package:one_profile/features/presentation/routes/home_routes.dart';
import 'package:one_profile/l10n/app_localizations.dart';
import 'package:provider/provider.dart';

class WorkPiece extends StatefulWidget {
  const WorkPiece({super.key});

  @override
  State<WorkPiece> createState() => _WorkPieceState();
}

class _WorkPieceState extends State<WorkPiece> {
  late ScrollController _scrollController;
  late Timer _autoScrollTimer;
  double _scrollPosition = 0;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _startAutoScroll();
  }

  void _startAutoScroll() {
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      if (mounted && _scrollController.hasClients && _scrollController.position.hasContentDimensions) {
        _scrollPosition += 200;
        if (_scrollPosition > _scrollController.position.maxScrollExtent) {
          _scrollPosition = 0;
        }
        _scrollController.animateTo(
          _scrollPosition,
          duration: const Duration(milliseconds: 800),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _autoScrollTimer.cancel();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SectionTitle(
            title: AppLocalizations.of(context)!.applicationsDeveloped,
            press: () => Navigator.of(context).pushNamed(AppRoutes.workPiece),
          ),
        ),
        ChangeNotifierProvider(
          create: (_) => WorkPieceViewModel(),
          child: Consumer2<HomeScreenViewModel, WorkPieceViewModel>(
            builder: (context, homeViewModel, workPieceViewModel, _) {
              final popularProducts = homeViewModel.getPopularProducts();
              return SingleChildScrollView(
                controller: _scrollController,
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    ...List.generate(popularProducts.length, (index) {
                      final imagePath = workPieceViewModel.getProductImagePath(
                        index,
                      );
                      return Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: ProductCard(
                          product: popularProducts[index],
                          imagePath: imagePath,
                          onPress: () {
                            workPieceViewModel.onProductPressed(
                              index,
                              popularProducts[index],
                              context,
                            );
                          },
                        ),
                      );
                    }),
                  ],
                ),
              );
            },
          ),
        ),
      ],
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
        Text(title, style: AppFont.promptBodyBoldTitle),
        TextButton(
          onPressed: press,
          style: TextButton.styleFrom(foregroundColor: Colors.grey),
          child: Text(
            AppLocalizations.of(context)!.seeMore,
            style: AppFont.promptBodyMedium,
          ),
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
    this.imagePath,
  }) : super(key: key);

  final double width, aspectRetio;
  final Product product;
  final VoidCallback onPress;
  final String? imagePath;

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
                child: imagePath != null
                    ? (imagePath!.startsWith('http')
                        ? Image.network(imagePath!)
                        : Image.asset(imagePath!))
                    : Image.network(AppImages.classTrackingIcon),
              ),
            ),
            const SizedBox(height: 10),
            SizedBox(
              height: 50,
              child: Text(
                product.title,
                style: AppFont.promptBodyMedium,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
