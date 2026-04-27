// ignore_for_file: use_super_parameters, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:one_profile/features/common/app_colors.dart';
import 'package:one_profile/features/presentation/home/home_screen_view_model.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';

class AchievementsPage extends StatelessWidget {
  const AchievementsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (l10n == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Achievements'),
          elevation: 0,
          backgroundColor: AppColors.primary_violet,
          foregroundColor: Colors.white,
        ),
        body: const Center(child: Text('Unable to load localization')),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Achievements'),
        elevation: 0,
        backgroundColor: AppColors.primary_violet,
        foregroundColor: Colors.white,
      ),
      body: ChangeNotifierProvider(
        create: (_) => HomeScreenViewModel(),
        child: Consumer<HomeScreenViewModel>(
          builder: (context, viewModel, _) {
            final localizations = AppLocalizations.of(context)!;
            if (viewModel.popularProducts.isEmpty) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                viewModel.initializeDataWithLocalization(localizations);
              });
            }
            final workpieces = viewModel.getPopularProducts();
            return GridView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: workpieces.length,
              itemBuilder: (context, index) {
                final workpiece = workpieces[index];
                return Card(
                  elevation: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Workpiece Image
                      ClipRRect(
                        borderRadius:
                            const BorderRadius.vertical(top: Radius.circular(4)),
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: AppColors.grey.withOpacity(0.1),
                          ),
                          child: workpiece.images.isNotEmpty
                              ? (workpiece.images[0].startsWith('http')
                                  ? Image.network(
                                      workpiece.images[0],
                                      fit: BoxFit.contain,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(Icons.image_not_supported);
                                      },
                                    )
                                  : Image.asset(
                                      workpiece.images[0],
                                      fit: BoxFit.contain,
                                    ))
                              : const Icon(Icons.image),
                        ),
                      ),
                      // Workpiece Info
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workpiece.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: AppColors.primary_black,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              workpiece.description,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
