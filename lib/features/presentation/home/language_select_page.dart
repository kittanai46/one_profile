import 'package:flutter/material.dart';
import 'package:one_profile/features/common/app_colors.dart';
import 'package:one_profile/l10n/app_localizations.dart';
import 'package:one_profile/l10n/locale_provider.dart';
import 'package:provider/provider.dart';

class LanguageSelectPage extends StatelessWidget {
  const LanguageSelectPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          AppLocalizations.of(context)!.language,
          style: const TextStyle(color: Colors.black),
        ),
      ),
      body: SafeArea(
        child: Consumer<LocaleProvider>(
          builder: (context, localeProvider, _) {
            return Column(
              children: [
                // English
                _LanguageOption(
                  language: 'English',
                  code: 'en',
                  isSelected: localeProvider.locale.languageCode == 'en',
                  onTap: () {
                    context.read<LocaleProvider>().setLocale(
                      const Locale('en'),
                    );
                  },
                ),
                const Divider(height: 1),
                // Thai
                _LanguageOption(
                  language: 'ไทย',
                  code: 'th',
                  isSelected: localeProvider.locale.languageCode == 'th',
                  onTap: () {
                    context.read<LocaleProvider>().setLocale(
                      const Locale('th'),
                    );
                  },
                ),
                const Divider(height: 1),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String language;
  final String code;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.language,
    required this.code,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  language,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  code.toUpperCase(),
                  style: const TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
            if (isSelected)
              const Icon(Icons.check_circle, color: AppColors.primary_violet)
            else
              const Icon(Icons.radio_button_unchecked, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
