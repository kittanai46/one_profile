import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:one_profile/l10n/app_localizations.dart';
import 'package:one_profile/features/common/app_colors.dart';
import 'package:one_profile/features/common/app_font.dart';
import 'package:one_profile/features/presentation/home/resume/resume_view_models.dart';
import 'package:one_profile/features/presentation/widgets/app_bar_home_screen.dart';

class ResumeScreen extends StatelessWidget {
  const ResumeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ResumeViewModel(),
      child: Consumer<ResumeViewModel>(
        builder: (context, viewModel, _) {
          final localizations = AppLocalizations.of(context)!;

          return Scaffold(
            appBar: const PreferredSize(
              preferredSize: Size.fromHeight(kToolbarHeight),
              child: ResponsiveNavBar(),
            ),
            body: SafeArea(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Resume Title
                    Text(
                      localizations.resumeCv,
                      style: AppFont.promptHeadingLarge.copyWith(
                        color: AppColors.primary_blue,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Resume Content Section
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.primary_violet.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(
                          color: AppColors.primary_violet.withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            localizations.skillsAbilities,
                            style: AppFont.promptHeadingSmall.copyWith(
                              color: AppColors.primary_blue,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(height: 12),
                          Text(
                            'Your resume content goes here...',
                            style: AppFont.promptBodyMedium.copyWith(
                              color: Colors.black87,
                            ),
                          ),
                          const SizedBox(height: 20),
                          // Add more resume sections as needed
                          _buildResumeSection(
                            context,
                            'Experience',
                            'Add your work experience here',
                          ),
                          const SizedBox(height: 16),
                          _buildResumeSection(
                            context,
                            'Education',
                            'Add your education details here',
                          ),
                          const SizedBox(height: 16),
                          _buildResumeSection(
                            context,
                            'Skills',
                            'Add your skills here',
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildResumeSection(
    BuildContext context,
    String title,
    String content,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: AppFont.promptBodyLarge.copyWith(
            fontWeight: FontWeight.bold,
            color: AppColors.primary_blue,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          content,
          style: AppFont.promptBodyMedium.copyWith(color: Colors.grey[600]),
        ),
      ],
    );
  }
}
