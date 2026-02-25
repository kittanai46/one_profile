// ignore_for_file: use_super_parameters, deprecated_member_use, avoid_print

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:one_profile/features/common/app_colors.dart';
import 'package:one_profile/features/data/project_data.dart';
import 'package:one_profile/features/presentation/home/achievement/template_screen_page.dart';

import '../../../../l10n/app_localizations.dart';


class ClassTrackingScreen extends StatelessWidget {
  const ClassTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final project = classTrackingProject;
    final l10n = AppLocalizations.of(context);
    
    if (l10n == null) {
      return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text('Class Tracking'),
          elevation: 0,
          backgroundColor: AppColors.primary_violet,
          foregroundColor: Colors.white,
        ),
        body: const Center(
          child: Text('Unable to load localization'),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(l10n.classTrackingTitle),
        elevation: 0,
        backgroundColor: AppColors.primary_violet,
        foregroundColor: Colors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            children: [
              // Hero Image Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    project.imageAsset,
                    height: 250,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Title and Description using Banner Template
              BannerTemplate(
                title: project.title,
                subtitle: project.description,
                backgroundColor: AppColors.primary_violet.withOpacity(0.1),
                textColor: AppColors.primary_black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                borderRadius: 12,
              ),
              const SizedBox(height: 24),

              // Features Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeaderTemplate(title: l10n.keyFeatures),
                    const SizedBox(height: 16),
                    ..._buildFeatureList(context, project.features),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Tech Stack Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeaderTemplate(title: l10n.technologyStack),
                    const SizedBox(height: 12),
                    _buildTechStack(context, project.technologies),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // Stats Section
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionHeaderTemplate(title: l10n.projectStats),
                    const SizedBox(height: 16),
                    StatsTemplate(
                      stats: project.stats
                          .map(
                            (stat) =>
                                StatItem(value: stat.value, label: stat.label),
                          )
                          .toList(),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              // External Links Section
              if (project.links.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Project Links',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      ..._buildLinkButtons(context, project.links),
                    ],
                  ),
                ),
              const SizedBox(height: 24),

              // Action Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(l10n.viewFullProject),
                          duration: const Duration(seconds: 2),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary_violet,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      l10n.viewFullProject,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  List<Widget> _buildFeatureList(
    BuildContext context,
    List<ProjectFeature> features,
  ) {
    return features
        .map(
          (feature) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    color: AppColors.primary_violet,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 16),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    feature.title,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppColors.primary_black,
                    ),
                  ),
                ),
              ],
            ),
          ),
        )
        .toList();
  }

  Widget _buildTechStack(BuildContext context, List<String> technologies) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: technologies
          .map(
            (tech) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppColors.primary_violet.withOpacity(0.1),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: AppColors.primary_violet.withOpacity(0.3),
                ),
              ),
              child: Text(
                tech,
                style: TextStyle(
                  color: AppColors.primary_violet,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
          .toList(),
    );
  }

  List<Widget> _buildLinkButtons(
    BuildContext context,
    List<ProjectLink> links,
  ) {
    return links
        .map(
          (link) => Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => _launchUrl(link.url),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary_violet,
                  side: BorderSide(color: AppColors.primary_violet),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      link.type == LinkType.github ? Icons.code : Icons.launch,
                      size: 18,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      link.label,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
        .toList();
  }

  Future<void> _launchUrl(String url) async {
    try {
      final uri = Uri.parse(url);
      if (await canLaunchUrl(uri)) {
        await launchUrl(uri, mode: LaunchMode.externalApplication);
      }
    } catch (e) {
      // Handle error
      print('Could not launch $url: $e');
    }
  }
}
