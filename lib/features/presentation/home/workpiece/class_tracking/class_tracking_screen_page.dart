// ignore_for_file: use_super_parameters, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:one_profile/features/common/app_colors.dart';
import 'package:one_profile/features/data/project_data.dart';
import '../../common/project_detail_screen.dart';

import '../../../../../l10n/app_localizations.dart';

class ClassTrackingScreen extends StatelessWidget {
  const ClassTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    if (l10n == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Bluetooth Class Tracking'),
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
        title: Text(l10n.classTrackingTitle),
        elevation: 0,
        backgroundColor: AppColors.primary_violet,
        foregroundColor: Colors.white,
      ),
      body: FutureBuilder<ProjectModel>(
        future: getClassTrackingProject(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  const Text('Error loading project'),
                  const SizedBox(height: 8),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Text(
                      '${snapshot.error}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Text('No data available'),
            );
          }

          final project = snapshot.data!;

          return ProjectDetailScreen(
            project: project,
            appBarTitle: l10n.classTrackingTitle,
          );
        },
      ),
    );
  }
}
