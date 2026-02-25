import 'package:flutter/material.dart';
import 'package:one_profile/features/common/app_font.dart';
import 'package:one_profile/features/l10n/app_localizations.dart';
import 'package:one_profile/features/presentation/routes/home_routes.dart';

class ResponsiveNavBar extends StatelessWidget {
  const ResponsiveNavBar({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final bool isLargeScreen = width > 800;

    return AppBar(
      backgroundColor: Colors.white,
      elevation: 0,
      titleSpacing: 0,
      leading: null,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '${AppLocalizations.of(context)!.welcome} ${AppLocalizations.of(context)!.appTitle}',
              style: AppFont.promptBodyLarge.copyWith(color: Colors.black),
            ),
            if (isLargeScreen) _navBarItems(context),
          ],
        ),
      ),
      actions: [
        if (!isLargeScreen)
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openEndDrawer(),
          )
        else
          const SizedBox(width: 16),
      ],
    );
  }

  Widget _navBarItems(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(AppRoutes.languageSelect);
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 16),
          child: Row(
            children: [
              const Icon(Icons.language, color: Colors.black),
              const SizedBox(width: 8),
              Text(
                AppLocalizations.of(context)!.language,
                style: const TextStyle(fontSize: 16, color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
