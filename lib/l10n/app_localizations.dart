import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

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
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'BeeKeeper'**
  String get appName;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome'**
  String get welcome;

  /// No description provided for @getStarted.
  ///
  /// In en, this message translates to:
  /// **'Get Started'**
  String get getStarted;

  /// No description provided for @tagline.
  ///
  /// In en, this message translates to:
  /// **'Manage your hives smartly'**
  String get tagline;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @sun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get sun;

  /// No description provided for @mon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get mon;

  /// No description provided for @tue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get tue;

  /// No description provided for @wed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get wed;

  /// No description provided for @thu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get thu;

  /// No description provided for @fri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get fri;

  /// No description provided for @sat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get sat;

  /// No description provided for @weatherClear.
  ///
  /// In en, this message translates to:
  /// **'Clear sky'**
  String get weatherClear;

  /// No description provided for @weatherMainlyClear.
  ///
  /// In en, this message translates to:
  /// **'Mainly clear'**
  String get weatherMainlyClear;

  /// No description provided for @weatherPartlyCloudy.
  ///
  /// In en, this message translates to:
  /// **'Partly cloudy'**
  String get weatherPartlyCloudy;

  /// No description provided for @weatherOvercast.
  ///
  /// In en, this message translates to:
  /// **'Overcast'**
  String get weatherOvercast;

  /// No description provided for @weatherFoggy.
  ///
  /// In en, this message translates to:
  /// **'Foggy'**
  String get weatherFoggy;

  /// No description provided for @weatherDrizzle.
  ///
  /// In en, this message translates to:
  /// **'Drizzle'**
  String get weatherDrizzle;

  /// No description provided for @weatherRainy.
  ///
  /// In en, this message translates to:
  /// **'Rainy'**
  String get weatherRainy;

  /// No description provided for @weatherFreezingRain.
  ///
  /// In en, this message translates to:
  /// **'Freezing rain'**
  String get weatherFreezingRain;

  /// No description provided for @weatherSnowy.
  ///
  /// In en, this message translates to:
  /// **'Snowy'**
  String get weatherSnowy;

  /// No description provided for @weatherRainShowers.
  ///
  /// In en, this message translates to:
  /// **'Rain showers'**
  String get weatherRainShowers;

  /// No description provided for @weatherThunderstorm.
  ///
  /// In en, this message translates to:
  /// **'Thunderstorm'**
  String get weatherThunderstorm;

  /// No description provided for @weatherUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get weatherUnknown;

  /// No description provided for @windN.
  ///
  /// In en, this message translates to:
  /// **'N'**
  String get windN;

  /// No description provided for @windNE.
  ///
  /// In en, this message translates to:
  /// **'NE'**
  String get windNE;

  /// No description provided for @windE.
  ///
  /// In en, this message translates to:
  /// **'E'**
  String get windE;

  /// No description provided for @windSE.
  ///
  /// In en, this message translates to:
  /// **'SE'**
  String get windSE;

  /// No description provided for @windS.
  ///
  /// In en, this message translates to:
  /// **'S'**
  String get windS;

  /// No description provided for @windSW.
  ///
  /// In en, this message translates to:
  /// **'SW'**
  String get windSW;

  /// No description provided for @windW.
  ///
  /// In en, this message translates to:
  /// **'W'**
  String get windW;

  /// No description provided for @windNW.
  ///
  /// In en, this message translates to:
  /// **'NW'**
  String get windNW;

  /// No description provided for @beeTooCold.
  ///
  /// In en, this message translates to:
  /// **'Too cold for bee activity'**
  String get beeTooCold;

  /// No description provided for @beeSluggish.
  ///
  /// In en, this message translates to:
  /// **'Bees may be sluggish'**
  String get beeSluggish;

  /// No description provided for @beeGoodTemp.
  ///
  /// In en, this message translates to:
  /// **'Good temperature for bees'**
  String get beeGoodTemp;

  /// No description provided for @beeHot.
  ///
  /// In en, this message translates to:
  /// **'Hot - ensure water source'**
  String get beeHot;

  /// No description provided for @beeTooHot.
  ///
  /// In en, this message translates to:
  /// **'Too hot - bees may beard'**
  String get beeTooHot;

  /// No description provided for @beeLowHumidity.
  ///
  /// In en, this message translates to:
  /// **'Low humidity - check water'**
  String get beeLowHumidity;

  /// No description provided for @beeHighHumidity.
  ///
  /// In en, this message translates to:
  /// **'High humidity - ventilation needed'**
  String get beeHighHumidity;

  /// No description provided for @beeTooWindy.
  ///
  /// In en, this message translates to:
  /// **'Too windy for inspection'**
  String get beeTooWindy;

  /// No description provided for @beeWindy.
  ///
  /// In en, this message translates to:
  /// **'Windy - bees may be defensive'**
  String get beeWindy;

  /// No description provided for @beeRainy.
  ///
  /// In en, this message translates to:
  /// **'Rainy - no inspection today'**
  String get beeRainy;

  /// No description provided for @beeShowers.
  ///
  /// In en, this message translates to:
  /// **'Showers - wait for clear weather'**
  String get beeShowers;

  /// No description provided for @beeStorm.
  ///
  /// In en, this message translates to:
  /// **'Storm - stay indoors'**
  String get beeStorm;

  /// No description provided for @beeGreatDay.
  ///
  /// In en, this message translates to:
  /// **'Great day for beekeeping!'**
  String get beeGreatDay;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @back.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get back;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @register.
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get register;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @weather.
  ///
  /// In en, this message translates to:
  /// **'Weather'**
  String get weather;

  /// No description provided for @temperature.
  ///
  /// In en, this message translates to:
  /// **'Temperature'**
  String get temperature;

  /// No description provided for @humidity.
  ///
  /// In en, this message translates to:
  /// **'Humidity'**
  String get humidity;

  /// No description provided for @wind.
  ///
  /// In en, this message translates to:
  /// **'Wind'**
  String get wind;

  /// No description provided for @hourlyForecast.
  ///
  /// In en, this message translates to:
  /// **'Hourly Forecast'**
  String get hourlyForecast;

  /// No description provided for @dailyForecast.
  ///
  /// In en, this message translates to:
  /// **'7-Day Forecast'**
  String get dailyForecast;

  /// No description provided for @beekeepingConditions.
  ///
  /// In en, this message translates to:
  /// **'Beekeeping Conditions'**
  String get beekeepingConditions;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error'**
  String get error;

  /// No description provided for @tryAgain.
  ///
  /// In en, this message translates to:
  /// **'Try Again'**
  String get tryAgain;

  /// No description provided for @manageApiaries.
  ///
  /// In en, this message translates to:
  /// **'Manage Your Apiaries'**
  String get manageApiaries;

  /// No description provided for @manageApiariesDesc.
  ///
  /// In en, this message translates to:
  /// **'Track all your hives in one place. Monitor locations, colonies, and equipment.'**
  String get manageApiariesDesc;

  /// No description provided for @trackInspections.
  ///
  /// In en, this message translates to:
  /// **'Track Inspections'**
  String get trackInspections;

  /// No description provided for @trackInspectionsDesc.
  ///
  /// In en, this message translates to:
  /// **'Log inspections, queen status, health issues, and treatments with ease.'**
  String get trackInspectionsDesc;

  /// No description provided for @recordHarvests.
  ///
  /// In en, this message translates to:
  /// **'Record Harvests'**
  String get recordHarvests;

  /// No description provided for @recordHarvestsDesc.
  ///
  /// In en, this message translates to:
  /// **'Keep track of honey production, yields, and quality for each hive.'**
  String get recordHarvestsDesc;

  /// No description provided for @buySell.
  ///
  /// In en, this message translates to:
  /// **'Buy & Sell'**
  String get buySell;

  /// No description provided for @buySellDesc.
  ///
  /// In en, this message translates to:
  /// **'Connect with traders. Sell your honey or buy beekeeping supplies.'**
  String get buySellDesc;

  /// No description provided for @apiaries.
  ///
  /// In en, this message translates to:
  /// **'Apiaries'**
  String get apiaries;

  /// No description provided for @noApiaries.
  ///
  /// In en, this message translates to:
  /// **'No apiaries yet'**
  String get noApiaries;

  /// No description provided for @addFirstApiary.
  ///
  /// In en, this message translates to:
  /// **'Tap + to add your first apiary'**
  String get addFirstApiary;

  /// No description provided for @addApiary.
  ///
  /// In en, this message translates to:
  /// **'Add Apiary'**
  String get addApiary;

  /// No description provided for @apiaryName.
  ///
  /// In en, this message translates to:
  /// **'Apiary Name'**
  String get apiaryName;

  /// No description provided for @apiaryNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter apiary name'**
  String get apiaryNameHint;

  /// No description provided for @apiaryNameRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter apiary name'**
  String get apiaryNameRequired;

  /// No description provided for @apiaryLocation.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get apiaryLocation;

  /// No description provided for @apiaryLocationHint.
  ///
  /// In en, this message translates to:
  /// **'Enter location'**
  String get apiaryLocationHint;

  /// No description provided for @apiaryLocationRequired.
  ///
  /// In en, this message translates to:
  /// **'Please enter location'**
  String get apiaryLocationRequired;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get notes;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'Optional notes'**
  String get notesHint;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @hives.
  ///
  /// In en, this message translates to:
  /// **'Hives'**
  String get hives;

  /// No description provided for @beehives.
  ///
  /// In en, this message translates to:
  /// **'Beehives'**
  String get beehives;

  /// No description provided for @noHives.
  ///
  /// In en, this message translates to:
  /// **'No hives yet'**
  String get noHives;

  /// No description provided for @addHive.
  ///
  /// In en, this message translates to:
  /// **'Add Hive'**
  String get addHive;

  /// No description provided for @createdAt.
  ///
  /// In en, this message translates to:
  /// **'Created'**
  String get createdAt;

  /// No description provided for @deleteApiary.
  ///
  /// In en, this message translates to:
  /// **'Delete Apiary'**
  String get deleteApiary;

  /// No description provided for @deleteApiaryConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete'**
  String get deleteApiaryConfirm;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @selectImage.
  ///
  /// In en, this message translates to:
  /// **'Select Image'**
  String get selectImage;

  /// No description provided for @camera.
  ///
  /// In en, this message translates to:
  /// **'Camera'**
  String get camera;

  /// No description provided for @gallery.
  ///
  /// In en, this message translates to:
  /// **'Gallery'**
  String get gallery;

  /// No description provided for @tapToAddPhoto.
  ///
  /// In en, this message translates to:
  /// **'Tap to add photo'**
  String get tapToAddPhoto;

  /// No description provided for @gettingLocation.
  ///
  /// In en, this message translates to:
  /// **'Getting location...'**
  String get gettingLocation;

  /// No description provided for @locationWillBeAdded.
  ///
  /// In en, this message translates to:
  /// **'Location will be added with photo'**
  String get locationWillBeAdded;

  /// No description provided for @pleaseAddImage.
  ///
  /// In en, this message translates to:
  /// **'Please add a photo'**
  String get pleaseAddImage;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @tapToTakePhoto.
  ///
  /// In en, this message translates to:
  /// **'Tap to take photo'**
  String get tapToTakePhoto;

  /// No description provided for @tapToOpenMaps.
  ///
  /// In en, this message translates to:
  /// **'Tap to open in Maps'**
  String get tapToOpenMaps;
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
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
