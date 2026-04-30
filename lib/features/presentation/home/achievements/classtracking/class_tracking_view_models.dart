import 'package:flutter/material.dart';
import '../../../../../l10n/app_localizations.dart';

class ClassTrackingViewModel extends ChangeNotifier {
  final AppLocalizations l10n;

  ClassTrackingViewModel(this.l10n);

  // Helper method to get feature list
  List<String> getFeatures() {
    return [
      l10n.iteam_01_FeatureA,
      l10n.iteam_01_FeatureB,
      l10n.iteam_01_FeatureC,
      l10n.iteam_01_FeatureD,
      l10n.iteam_01_FeatureE,
    ];
  }

  // Get title
  String getTitle() => l10n.iteam_01_name;

  // Get description
  String getDescription() => l10n.iteam_01_description;

  // Get page name
  String getPageName() => l10n.iteam_01_page_name;

  // Get page description
  String getPageDescription() => l10n.iteam_01_page_description;

  // Get student title
  String getStudentTitle() => l10n.iteam_01_page_titalA;

  // Get student subtitle list
  List<String> getStudentSubtitles() {
    return [
      l10n.iteam_01_page_SubtitalA1,
      l10n.iteam_01_page_SubtitalA2,
      l10n.iteam_01_page_SubtitalA3,
      l10n.iteam_01_page_SubtitalA4,
    ];
  }

  // Get instructor title
  String getInstructorTitle() => l10n.iteam_01_page_titalB;

  // Get instructor subtitle list
  List<String> getInstructorSubtitles() {
    return [
      l10n.iteam_01_page_SubtitalB1,
      l10n.iteam_01_page_SubtitalB2,
      l10n.iteam_01_page_SubtitalB3,
      l10n.iteam_01_page_SubtitalB4,
    ];
  }

  // Get key features label
  String getKeyFeaturesLabel() => l10n.keyFeatures;
}
