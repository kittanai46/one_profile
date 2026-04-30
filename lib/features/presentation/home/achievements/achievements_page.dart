// ignore_for_file: use_super_parameters, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:one_profile/features/common/app_colors.dart';
import 'package:one_profile/features/data/project_data.dart';
import 'package:one_profile/features/presentation/home/achievements/classtracking/class_tracking_page.dart';

import '../../../../l10n/app_localizations.dart';

class AchievementsPage extends StatefulWidget {
  const AchievementsPage({super.key});

  @override
  State<AchievementsPage> createState() => _AchievementsPageState();
}

class _AchievementsPageState extends State<AchievementsPage> {
  late Future<List<ProjectModel>> _projectsFuture;

  @override
  void initState() {
    super.initState();
    _projectsFuture = getAllProjects();
  }

  String _getProjectTitle(String projectId, AppLocalizations l10n) {
    switch (projectId) {
      case 'iteam_01':
        return l10n.iteam_01.replaceAll('\n', ' ');
      case 'iteam_02':
        return l10n.iteam_02;
      case 'iteam_03':
        return l10n.iteam_03.replaceAll('\n', ' ');
      case 'iteam_04':
        return l10n.iteam_04;
      default:
        return projectId;
    }
  }

  String _getProjectDescription(String projectId, AppLocalizations l10n) {
    switch (projectId) {
      case 'iteam_01':
        return l10n.description_01;
      case 'iteam_02':
        return l10n.description_02;
      case 'iteam_03':
        return l10n.description_03;
      case 'iteam_04':
        return l10n.description_04;
      default:
        return '';
    }
  }

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
      body: FutureBuilder<List<ProjectModel>>(
        future: _projectsFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No achievements found'),
            );
          }

          final projects = snapshot.data!;
          return GridView.builder(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
            ),
            itemCount: projects.length,
            itemBuilder: (context, index) {
              final project = projects[index];
              final title = _getProjectTitle(project.id, l10n);
              final description = _getProjectDescription(project.id, l10n);

              return GestureDetector(
                onTap: () {
                  // Navigate to specific project page based on ID
                  if (project.id == 'iteam_01') {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClassTrackingPage(),
                      ),
                    );
                  } else {
                    // TODO: Add pages for iteam_02, iteam_03, iteam_04
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Page for ${title} coming soon'),
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                },
                child: Card(
                  elevation: 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Project Image
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
                          child: Image.network(
                            project.imageAsset,
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.image_not_supported);
                            },
                          ),
                        ),
                      ),
                      // Project Info
                      Padding(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
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
                              description,
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
                ),
              );
            },
          );
        },
      ),
    );
  }
}
