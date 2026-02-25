import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_th.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('th'),
  ];

  /// No description provided for @appTitle.
  ///
  /// In en, this message translates to:
  /// **'One Profile'**
  String get appTitle;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to'**
  String get welcome;

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello, World!'**
  String get helloWorld;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @resume.
  ///
  /// In en, this message translates to:
  /// **'Resume'**
  String get resume;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @welcomeMessageToProfile.
  ///
  /// In en, this message translates to:
  /// **'Welcome to my personal profile'**
  String get welcomeMessageToProfile;

  /// No description provided for @skillsAbilities.
  ///
  /// In en, this message translates to:
  /// **'Skills and abilities'**
  String get skillsAbilities;

  /// No description provided for @resumeCv.
  ///
  /// In en, this message translates to:
  /// **'Resume/CV'**
  String get resumeCv;

  /// No description provided for @workHistory.
  ///
  /// In en, this message translates to:
  /// **'Work History'**
  String get workHistory;

  /// No description provided for @cashbackOffer.
  ///
  /// In en, this message translates to:
  /// **'Cashback 20%'**
  String get cashbackOffer;

  /// No description provided for @competitionAndCollaboration.
  ///
  /// In en, this message translates to:
  /// **'Competitions and collaborations'**
  String get competitionAndCollaboration;

  /// No description provided for @seeMore.
  ///
  /// In en, this message translates to:
  /// **'See more'**
  String get seeMore;

  /// No description provided for @applicationsDeveloped.
  ///
  /// In en, this message translates to:
  /// **'Applications developed/collaborated'**
  String get applicationsDeveloped;

  /// No description provided for @contactChannels.
  ///
  /// In en, this message translates to:
  /// **'Contact channels'**
  String get contactChannels;

  /// No description provided for @smartphoneCategory.
  ///
  /// In en, this message translates to:
  /// **'Smartphone'**
  String get smartphoneCategory;

  /// No description provided for @fashionCategory.
  ///
  /// In en, this message translates to:
  /// **'Fashion'**
  String get fashionCategory;

  /// No description provided for @brands.
  ///
  /// In en, this message translates to:
  /// **'Brands'**
  String get brands;

  /// No description provided for @appdescription.
  ///
  /// In en, this message translates to:
  /// **'Digital Resume & Experience Showcase'**
  String get appdescription;

  /// No description provided for @classTrackingTitle.
  ///
  /// In en, this message translates to:
  /// **'Class Tracking System'**
  String get classTrackingTitle;

  /// No description provided for @classTrackingDescription.
  ///
  /// In en, this message translates to:
  /// **'A comprehensive class management and tracking system designed to help educators and students keep track of attendance, grades, and course progress in real-time.'**
  String get classTrackingDescription;

  /// No description provided for @keyFeatures.
  ///
  /// In en, this message translates to:
  /// **'Key Features'**
  String get keyFeatures;

  /// No description provided for @technologyStack.
  ///
  /// In en, this message translates to:
  /// **'Technology Stack'**
  String get technologyStack;

  /// No description provided for @projectStats.
  ///
  /// In en, this message translates to:
  /// **'Project Stats'**
  String get projectStats;

  /// No description provided for @viewFullProject.
  ///
  /// In en, this message translates to:
  /// **'View Full Project'**
  String get viewFullProject;

  /// No description provided for @yearStarted.
  ///
  /// In en, this message translates to:
  /// **'Year Started'**
  String get yearStarted;

  /// No description provided for @usersCount.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get usersCount;

  /// No description provided for @ratingLabel.
  ///
  /// In en, this message translates to:
  /// **'Rating'**
  String get ratingLabel;

  /// No description provided for @github.
  ///
  /// In en, this message translates to:
  /// **'GitHub'**
  String get github;

  /// No description provided for @liveDemo.
  ///
  /// In en, this message translates to:
  /// **'Live Demo'**
  String get liveDemo;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'th'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'th':
      return AppLocalizationsTh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
