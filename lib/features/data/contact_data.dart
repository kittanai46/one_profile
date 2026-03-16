import 'package:one_profile/features/common/app_images.dart';

class ContactItem {
  final String iconPath; // image asset path
  final String titleKey; // localization key for title
  final String valueKey; // localization key for value

  const ContactItem({
    required this.iconPath,
    required this.titleKey,
    required this.valueKey,
  });
}

class ContactDataManager {
  static final List<ContactItem> contactItems = [
    ContactItem(
      iconPath: AppImages.gmailIcon,
      titleKey: "email",
      valueKey: "contactGmail",
    ),
    ContactItem(
      iconPath: AppImages.phoneIcon,
      titleKey: "phone",
      valueKey: "contactPhone",
    ),
    ContactItem(
      iconPath: AppImages.lineIcon,
      titleKey: "line",
      valueKey: "contactLineid",
    ),
    ContactItem(
      iconPath: AppImages.githubIcon,
      titleKey: "github",
      valueKey: "contactGithub",
    ),
  ];
}
