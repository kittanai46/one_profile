import 'package:one_profile/features/common/app_images.dart';

enum ContactType { email, phone, line, github, linkedin }

class ContactItem {
  final String iconPath; // image asset path
  final String titleKey; // localization key for title
  final String valueKey; // localization key for value
  final ContactType type; // contact type for handling actions
  final String? qrCodePath; // optional QR code image path

  const ContactItem({
    required this.iconPath,
    required this.titleKey,
    required this.valueKey,
    required this.type,
    this.qrCodePath,
  });
}

class ContactDataManager {
  static final List<ContactItem> contactItems = [
    ContactItem(
      iconPath: AppImages.gmailIcon,
      titleKey: "email",
      valueKey: "contactGmail",
      type: ContactType.email,
    ),
    ContactItem(
      iconPath: AppImages.phoneIcon,
      titleKey: "phone",
      valueKey: "contactPhone",
      type: ContactType.phone,
    ),
    ContactItem(
      iconPath: AppImages.lineIcon,
      titleKey: "line",
      valueKey: "contactLineid",
      type: ContactType.line,
      qrCodePath: AppImages.lineQRCode,
    ),
    ContactItem(
      iconPath: AppImages.githubIcon,
      titleKey: "github",
      valueKey: "contactGithub",
      type: ContactType.github,
      qrCodePath: AppImages.githubQRCode,
    ),
    ContactItem(
      iconPath: AppImages.linkedinIcon,
      titleKey: "linkedin",
      valueKey: "contactLinkedin",
      type: ContactType.linkedin,
      qrCodePath: AppImages.linkedinQRCode,
    ),
  ];
}
