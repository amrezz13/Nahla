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
  /// **'Partly Cloudy'**
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

  /// No description provided for @addBeehive.
  ///
  /// In en, this message translates to:
  /// **'Add Beehive'**
  String get addBeehive;

  /// No description provided for @editBeehive.
  ///
  /// In en, this message translates to:
  /// **'Edit Beehive'**
  String get editBeehive;

  /// No description provided for @saveBeehive.
  ///
  /// In en, this message translates to:
  /// **'Save Beehive'**
  String get saveBeehive;

  /// No description provided for @identification.
  ///
  /// In en, this message translates to:
  /// **'Identification'**
  String get identification;

  /// No description provided for @systemNumber.
  ///
  /// In en, this message translates to:
  /// **'System #'**
  String get systemNumber;

  /// No description provided for @autoGenerated.
  ///
  /// In en, this message translates to:
  /// **'Auto-generated'**
  String get autoGenerated;

  /// No description provided for @hiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Hive Number'**
  String get hiveNumber;

  /// No description provided for @hiveNumberHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., A-5, 12, Blue-2'**
  String get hiveNumberHint;

  /// No description provided for @pleaseEnterHiveNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter hive number'**
  String get pleaseEnterHiveNumber;

  /// No description provided for @nameOptional.
  ///
  /// In en, this message translates to:
  /// **'Name (optional)'**
  String get nameOptional;

  /// No description provided for @nameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g., Strong Colony, New Split'**
  String get nameHint;

  /// No description provided for @hiveInfo.
  ///
  /// In en, this message translates to:
  /// **'Hive Information'**
  String get hiveInfo;

  /// No description provided for @frames.
  ///
  /// In en, this message translates to:
  /// **'Frames'**
  String get frames;

  /// No description provided for @healthStatus.
  ///
  /// In en, this message translates to:
  /// **'Health Status'**
  String get healthStatus;

  /// No description provided for @queenInfo.
  ///
  /// In en, this message translates to:
  /// **'Queen Info'**
  String get queenInfo;

  /// No description provided for @hasQueen.
  ///
  /// In en, this message translates to:
  /// **'Has Queen'**
  String get hasQueen;

  /// No description provided for @queenPresent.
  ///
  /// In en, this message translates to:
  /// **'Queen present'**
  String get queenPresent;

  /// No description provided for @noQueen.
  ///
  /// In en, this message translates to:
  /// **'No queen'**
  String get noQueen;

  /// No description provided for @queenOrigin.
  ///
  /// In en, this message translates to:
  /// **'Queen Origin'**
  String get queenOrigin;

  /// No description provided for @queenBreed.
  ///
  /// In en, this message translates to:
  /// **'Queen Breed'**
  String get queenBreed;

  /// No description provided for @queenAddedDate.
  ///
  /// In en, this message translates to:
  /// **'Queen Added Date'**
  String get queenAddedDate;

  /// No description provided for @selectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get selectDate;

  /// No description provided for @queenMarked.
  ///
  /// In en, this message translates to:
  /// **'Queen Marked'**
  String get queenMarked;

  /// No description provided for @markingColor.
  ///
  /// In en, this message translates to:
  /// **'Marking Color'**
  String get markingColor;

  /// No description provided for @photos.
  ///
  /// In en, this message translates to:
  /// **'Photos'**
  String get photos;

  /// No description provided for @addPhoto.
  ///
  /// In en, this message translates to:
  /// **'Add Photo'**
  String get addPhoto;

  /// No description provided for @selectImageType.
  ///
  /// In en, this message translates to:
  /// **'Select Image Type'**
  String get selectImageType;

  /// No description provided for @whatDoesPhotoShow.
  ///
  /// In en, this message translates to:
  /// **'What does this photo show?'**
  String get whatDoesPhotoShow;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @addNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Add any notes about this hive...'**
  String get addNotesHint;

  /// No description provided for @queenTypeLocal.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get queenTypeLocal;

  /// No description provided for @queenTypeImported.
  ///
  /// In en, this message translates to:
  /// **'Imported'**
  String get queenTypeImported;

  /// No description provided for @queenTypeBred.
  ///
  /// In en, this message translates to:
  /// **'Home Bred'**
  String get queenTypeBred;

  /// No description provided for @queenTypeSwarm.
  ///
  /// In en, this message translates to:
  /// **'From Swarm'**
  String get queenTypeSwarm;

  /// No description provided for @queenTypePurchased.
  ///
  /// In en, this message translates to:
  /// **'Purchased'**
  String get queenTypePurchased;

  /// No description provided for @queenTypeUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get queenTypeUnknown;

  /// No description provided for @queenBreedItalian.
  ///
  /// In en, this message translates to:
  /// **'Italian'**
  String get queenBreedItalian;

  /// No description provided for @queenBreedCarniolan.
  ///
  /// In en, this message translates to:
  /// **'Carniolan'**
  String get queenBreedCarniolan;

  /// No description provided for @queenBreedBuckfast.
  ///
  /// In en, this message translates to:
  /// **'Buckfast'**
  String get queenBreedBuckfast;

  /// No description provided for @queenBreedCaucasian.
  ///
  /// In en, this message translates to:
  /// **'Caucasian'**
  String get queenBreedCaucasian;

  /// No description provided for @queenBreedLocal.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get queenBreedLocal;

  /// No description provided for @queenBreedHybrid.
  ///
  /// In en, this message translates to:
  /// **'Hybrid'**
  String get queenBreedHybrid;

  /// No description provided for @queenBreedOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get queenBreedOther;

  /// No description provided for @healthHealthy.
  ///
  /// In en, this message translates to:
  /// **'Healthy'**
  String get healthHealthy;

  /// No description provided for @healthWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get healthWeak;

  /// No description provided for @healthSick.
  ///
  /// In en, this message translates to:
  /// **'Sick'**
  String get healthSick;

  /// No description provided for @healthCritical.
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get healthCritical;

  /// No description provided for @healthUnknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get healthUnknown;

  /// No description provided for @imageTypeQueen.
  ///
  /// In en, this message translates to:
  /// **'Queen'**
  String get imageTypeQueen;

  /// No description provided for @imageTypeBrood.
  ///
  /// In en, this message translates to:
  /// **'Brood'**
  String get imageTypeBrood;

  /// No description provided for @imageTypeHoney.
  ///
  /// In en, this message translates to:
  /// **'Honey'**
  String get imageTypeHoney;

  /// No description provided for @imageTypeFrames.
  ///
  /// In en, this message translates to:
  /// **'Frames'**
  String get imageTypeFrames;

  /// No description provided for @imageTypeDisease.
  ///
  /// In en, this message translates to:
  /// **'Disease'**
  String get imageTypeDisease;

  /// No description provided for @imageTypeGeneral.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get imageTypeGeneral;

  /// No description provided for @markingColorWhite.
  ///
  /// In en, this message translates to:
  /// **'White (1, 6)'**
  String get markingColorWhite;

  /// No description provided for @markingColorYellow.
  ///
  /// In en, this message translates to:
  /// **'Yellow (2, 7)'**
  String get markingColorYellow;

  /// No description provided for @markingColorRed.
  ///
  /// In en, this message translates to:
  /// **'Red (3, 8)'**
  String get markingColorRed;

  /// No description provided for @markingColorGreen.
  ///
  /// In en, this message translates to:
  /// **'Green (4, 9)'**
  String get markingColorGreen;

  /// No description provided for @markingColorBlue.
  ///
  /// In en, this message translates to:
  /// **'Blue (5, 0)'**
  String get markingColorBlue;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @dates.
  ///
  /// In en, this message translates to:
  /// **'Dates'**
  String get dates;

  /// No description provided for @updatedAt.
  ///
  /// In en, this message translates to:
  /// **'Updated'**
  String get updatedAt;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @deleteBeehive.
  ///
  /// In en, this message translates to:
  /// **'Delete Beehive'**
  String get deleteBeehive;

  /// No description provided for @deleteBeehiveConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this beehive? This action cannot be undone.'**
  String get deleteBeehiveConfirm;

  /// No description provided for @hive.
  ///
  /// In en, this message translates to:
  /// **'Hive'**
  String get hive;

  /// No description provided for @yes.
  ///
  /// In en, this message translates to:
  /// **'Yes'**
  String get yes;

  /// No description provided for @no.
  ///
  /// In en, this message translates to:
  /// **'No'**
  String get no;

  /// No description provided for @addInspection.
  ///
  /// In en, this message translates to:
  /// **'Add Inspection'**
  String get addInspection;

  /// No description provided for @viewInspections.
  ///
  /// In en, this message translates to:
  /// **'View Inspections'**
  String get viewInspections;

  /// No description provided for @inspections.
  ///
  /// In en, this message translates to:
  /// **'Inspections'**
  String get inspections;

  /// No description provided for @inspection.
  ///
  /// In en, this message translates to:
  /// **'Inspection'**
  String get inspection;

  /// No description provided for @inspectionDetails.
  ///
  /// In en, this message translates to:
  /// **'Inspection Details'**
  String get inspectionDetails;

  /// No description provided for @deleteInspection.
  ///
  /// In en, this message translates to:
  /// **'Delete Inspection'**
  String get deleteInspection;

  /// No description provided for @deleteInspectionConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete this inspection? This action cannot be undone.'**
  String get deleteInspectionConfirm;

  /// No description provided for @inspectionSaved.
  ///
  /// In en, this message translates to:
  /// **'Inspection saved successfully'**
  String get inspectionSaved;

  /// No description provided for @inspectionDeleted.
  ///
  /// In en, this message translates to:
  /// **'Inspection deleted'**
  String get inspectionDeleted;

  /// No description provided for @noInspectionsYet.
  ///
  /// In en, this message translates to:
  /// **'No inspections yet'**
  String get noInspectionsYet;

  /// No description provided for @noInspectionsDescription.
  ///
  /// In en, this message translates to:
  /// **'Start tracking your hive health by adding your first inspection.'**
  String get noInspectionsDescription;

  /// No description provided for @addFirstInspection.
  ///
  /// In en, this message translates to:
  /// **'Add First Inspection'**
  String get addFirstInspection;

  /// No description provided for @saveInspection.
  ///
  /// In en, this message translates to:
  /// **'Save Inspection'**
  String get saveInspection;

  /// No description provided for @inspectingHive.
  ///
  /// In en, this message translates to:
  /// **'Inspecting'**
  String get inspectingHive;

  /// No description provided for @basicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Information'**
  String get basicInfo;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @colonyStatus.
  ///
  /// In en, this message translates to:
  /// **'Colony Status'**
  String get colonyStatus;

  /// No description provided for @queenSeen.
  ///
  /// In en, this message translates to:
  /// **'Queen Seen'**
  String get queenSeen;

  /// No description provided for @queenCellsSeen.
  ///
  /// In en, this message translates to:
  /// **'Queen Cells Seen'**
  String get queenCellsSeen;

  /// No description provided for @eggsSeen.
  ///
  /// In en, this message translates to:
  /// **'Eggs Seen'**
  String get eggsSeen;

  /// No description provided for @larvaeSeen.
  ///
  /// In en, this message translates to:
  /// **'Larvae Seen'**
  String get larvaeSeen;

  /// No description provided for @broodPattern.
  ///
  /// In en, this message translates to:
  /// **'Brood Pattern'**
  String get broodPattern;

  /// No description provided for @population.
  ///
  /// In en, this message translates to:
  /// **'Population'**
  String get population;

  /// No description provided for @populationStrength.
  ///
  /// In en, this message translates to:
  /// **'Population Strength'**
  String get populationStrength;

  /// No description provided for @framesOfBees.
  ///
  /// In en, this message translates to:
  /// **'Frames of Bees'**
  String get framesOfBees;

  /// No description provided for @framesOfBrood.
  ///
  /// In en, this message translates to:
  /// **'Frames of Brood'**
  String get framesOfBrood;

  /// No description provided for @foodStores.
  ///
  /// In en, this message translates to:
  /// **'Food Stores'**
  String get foodStores;

  /// No description provided for @honeyStores.
  ///
  /// In en, this message translates to:
  /// **'Honey Stores'**
  String get honeyStores;

  /// No description provided for @pollenStores.
  ///
  /// In en, this message translates to:
  /// **'Pollen Stores'**
  String get pollenStores;

  /// No description provided for @needsFeeding.
  ///
  /// In en, this message translates to:
  /// **'Needs Feeding'**
  String get needsFeeding;

  /// No description provided for @needsFeedingAlert.
  ///
  /// In en, this message translates to:
  /// **'This hive needs feeding!'**
  String get needsFeedingAlert;

  /// No description provided for @health.
  ///
  /// In en, this message translates to:
  /// **'Health'**
  String get health;

  /// No description provided for @temperament.
  ///
  /// In en, this message translates to:
  /// **'Temperament'**
  String get temperament;

  /// No description provided for @diseasesObserved.
  ///
  /// In en, this message translates to:
  /// **'Diseases Observed'**
  String get diseasesObserved;

  /// No description provided for @pestsObserved.
  ///
  /// In en, this message translates to:
  /// **'Pests Observed'**
  String get pestsObserved;

  /// No description provided for @issues.
  ///
  /// In en, this message translates to:
  /// **'Issues'**
  String get issues;

  /// No description provided for @actionsTaken.
  ///
  /// In en, this message translates to:
  /// **'Actions Taken'**
  String get actionsTaken;

  /// No description provided for @actionNotes.
  ///
  /// In en, this message translates to:
  /// **'Action Notes'**
  String get actionNotes;

  /// No description provided for @actionNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Describe what you did...'**
  String get actionNotesHint;

  /// No description provided for @noPhotosYet.
  ///
  /// In en, this message translates to:
  /// **'No photos yet'**
  String get noPhotosYet;

  /// No description provided for @inspectionNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Add any additional observations...'**
  String get inspectionNotesHint;

  /// No description provided for @queen.
  ///
  /// In en, this message translates to:
  /// **'Queen'**
  String get queen;

  /// No description provided for @eggs.
  ///
  /// In en, this message translates to:
  /// **'Eggs'**
  String get eggs;

  /// No description provided for @larvae.
  ///
  /// In en, this message translates to:
  /// **'Larvae'**
  String get larvae;

  /// No description provided for @feed.
  ///
  /// In en, this message translates to:
  /// **'Feed'**
  String get feed;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @welcomeBack.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get welcomeBack;

  /// No description provided for @loginToContinue.
  ///
  /// In en, this message translates to:
  /// **'Login to continue managing your apiaries'**
  String get loginToContinue;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get createAccount;

  /// No description provided for @signUpToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Sign up to start managing your bees'**
  String get signUpToGetStarted;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @fullName.
  ///
  /// In en, this message translates to:
  /// **'Full Name'**
  String get fullName;

  /// No description provided for @fullNameHint.
  ///
  /// In en, this message translates to:
  /// **'Enter your full name'**
  String get fullNameHint;

  /// No description provided for @phoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Phone Number'**
  String get phoneNumber;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// No description provided for @pleaseEnterFullName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your full name'**
  String get pleaseEnterFullName;

  /// No description provided for @pleaseEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterPhone;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password must be at least 6 characters'**
  String get passwordTooShort;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @rememberMe.
  ///
  /// In en, this message translates to:
  /// **'Remember me'**
  String get rememberMe;

  /// No description provided for @forgotPassword.
  ///
  /// In en, this message translates to:
  /// **'Forgot Password?'**
  String get forgotPassword;

  /// No description provided for @forgotPasswordDescription.
  ///
  /// In en, this message translates to:
  /// **'Enter your email address and we\'ll send you a link to reset your password.'**
  String get forgotPasswordDescription;

  /// No description provided for @sendResetLink.
  ///
  /// In en, this message translates to:
  /// **'Send Reset Link'**
  String get sendResetLink;

  /// No description provided for @backToLogin.
  ///
  /// In en, this message translates to:
  /// **'Back to Login'**
  String get backToLogin;

  /// No description provided for @emailSent.
  ///
  /// In en, this message translates to:
  /// **'Email Sent!'**
  String get emailSent;

  /// No description provided for @checkYourEmail.
  ///
  /// In en, this message translates to:
  /// **'We\'ve sent a password reset link to your email. Please check your inbox.'**
  String get checkYourEmail;

  /// No description provided for @didntReceiveEmail.
  ///
  /// In en, this message translates to:
  /// **'Didn\'t receive the email? Resend'**
  String get didntReceiveEmail;

  /// No description provided for @orContinueWith.
  ///
  /// In en, this message translates to:
  /// **'or continue with'**
  String get orContinueWith;

  /// No description provided for @continueWithGoogle.
  ///
  /// In en, this message translates to:
  /// **'Continue with Google'**
  String get continueWithGoogle;

  /// No description provided for @dontHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get dontHaveAccount;

  /// No description provided for @alreadyHaveAccount.
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get alreadyHaveAccount;

  /// No description provided for @iAgreeToThe.
  ///
  /// In en, this message translates to:
  /// **'I agree to the'**
  String get iAgreeToThe;

  /// No description provided for @termsOfService.
  ///
  /// In en, this message translates to:
  /// **'Terms of Service'**
  String get termsOfService;

  /// No description provided for @and.
  ///
  /// In en, this message translates to:
  /// **'and'**
  String get and;

  /// No description provided for @privacyPolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get privacyPolicy;

  /// No description provided for @pleaseAcceptTerms.
  ///
  /// In en, this message translates to:
  /// **'Please accept the terms and conditions'**
  String get pleaseAcceptTerms;

  /// No description provided for @logoutConfirm.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to logout?'**
  String get logoutConfirm;

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @marketplace.
  ///
  /// In en, this message translates to:
  /// **'Marketplace'**
  String get marketplace;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @goodMorning.
  ///
  /// In en, this message translates to:
  /// **'Good Morning'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good Afternoon'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In en, this message translates to:
  /// **'Good Evening'**
  String get goodEvening;

  /// No description provided for @todayWeather.
  ///
  /// In en, this message translates to:
  /// **'Today\'s Weather'**
  String get todayWeather;

  /// No description provided for @goodForInspection.
  ///
  /// In en, this message translates to:
  /// **'Good for inspection'**
  String get goodForInspection;

  /// No description provided for @notGoodForInspection.
  ///
  /// In en, this message translates to:
  /// **'Not ideal for inspection'**
  String get notGoodForInspection;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @newInspection.
  ///
  /// In en, this message translates to:
  /// **'Inspect'**
  String get newInspection;

  /// No description provided for @recentActivity.
  ///
  /// In en, this message translates to:
  /// **'Recent Activity'**
  String get recentActivity;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @marketplaceComingSoon.
  ///
  /// In en, this message translates to:
  /// **'Buy and sell honey, queens, and equipment'**
  String get marketplaceComingSoon;

  /// No description provided for @editProfile.
  ///
  /// In en, this message translates to:
  /// **'Edit Profile'**
  String get editProfile;

  /// No description provided for @notifications.
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notifications;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @helpSupport.
  ///
  /// In en, this message translates to:
  /// **'Help & Support'**
  String get helpSupport;

  /// No description provided for @memberSince.
  ///
  /// In en, this message translates to:
  /// **'Member'**
  String get memberSince;

  /// No description provided for @weatherSunny.
  ///
  /// In en, this message translates to:
  /// **'Sunny'**
  String get weatherSunny;

  /// No description provided for @weatherCloudy.
  ///
  /// In en, this message translates to:
  /// **'Cloudy'**
  String get weatherCloudy;

  /// No description provided for @weatherWindy.
  ///
  /// In en, this message translates to:
  /// **'Windy'**
  String get weatherWindy;

  /// No description provided for @weatherHot.
  ///
  /// In en, this message translates to:
  /// **'Hot'**
  String get weatherHot;

  /// No description provided for @weatherCold.
  ///
  /// In en, this message translates to:
  /// **'Cold'**
  String get weatherCold;

  /// No description provided for @broodExcellent.
  ///
  /// In en, this message translates to:
  /// **'Excellent'**
  String get broodExcellent;

  /// No description provided for @broodGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get broodGood;

  /// No description provided for @broodSpotty.
  ///
  /// In en, this message translates to:
  /// **'Spotty'**
  String get broodSpotty;

  /// No description provided for @broodPoor.
  ///
  /// In en, this message translates to:
  /// **'Poor'**
  String get broodPoor;

  /// No description provided for @broodNone.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get broodNone;

  /// No description provided for @populationStrong.
  ///
  /// In en, this message translates to:
  /// **'Strong'**
  String get populationStrong;

  /// No description provided for @populationMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get populationMedium;

  /// No description provided for @populationWeak.
  ///
  /// In en, this message translates to:
  /// **'Weak'**
  String get populationWeak;

  /// No description provided for @populationVeryWeak.
  ///
  /// In en, this message translates to:
  /// **'Very Weak'**
  String get populationVeryWeak;

  /// No description provided for @storesLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get storesLow;

  /// No description provided for @storesAdequate.
  ///
  /// In en, this message translates to:
  /// **'Adequate'**
  String get storesAdequate;

  /// No description provided for @storesHigh.
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get storesHigh;

  /// No description provided for @temperamentCalm.
  ///
  /// In en, this message translates to:
  /// **'Calm'**
  String get temperamentCalm;

  /// No description provided for @temperamentNervous.
  ///
  /// In en, this message translates to:
  /// **'Nervous'**
  String get temperamentNervous;

  /// No description provided for @temperamentAggressive.
  ///
  /// In en, this message translates to:
  /// **'Aggressive'**
  String get temperamentAggressive;

  /// No description provided for @diseaseVarroa.
  ///
  /// In en, this message translates to:
  /// **'Varroa Mites'**
  String get diseaseVarroa;

  /// No description provided for @diseaseAmericanFoulbrood.
  ///
  /// In en, this message translates to:
  /// **'American Foulbrood'**
  String get diseaseAmericanFoulbrood;

  /// No description provided for @diseaseEuropeanFoulbrood.
  ///
  /// In en, this message translates to:
  /// **'European Foulbrood'**
  String get diseaseEuropeanFoulbrood;

  /// No description provided for @diseaseNosema.
  ///
  /// In en, this message translates to:
  /// **'Nosema'**
  String get diseaseNosema;

  /// No description provided for @diseaseChalkbrood.
  ///
  /// In en, this message translates to:
  /// **'Chalkbrood'**
  String get diseaseChalkbrood;

  /// No description provided for @diseaseSacbrood.
  ///
  /// In en, this message translates to:
  /// **'Sacbrood'**
  String get diseaseSacbrood;

  /// No description provided for @diseaseOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get diseaseOther;

  /// No description provided for @pestSmallHiveBeetle.
  ///
  /// In en, this message translates to:
  /// **'Small Hive Beetle'**
  String get pestSmallHiveBeetle;

  /// No description provided for @pestWaxMoth.
  ///
  /// In en, this message translates to:
  /// **'Wax Moth'**
  String get pestWaxMoth;

  /// No description provided for @pestAnts.
  ///
  /// In en, this message translates to:
  /// **'Ants'**
  String get pestAnts;

  /// No description provided for @pestWasps.
  ///
  /// In en, this message translates to:
  /// **'Wasps'**
  String get pestWasps;

  /// No description provided for @pestMice.
  ///
  /// In en, this message translates to:
  /// **'Mice'**
  String get pestMice;

  /// No description provided for @pestOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get pestOther;

  /// No description provided for @actionAddedFrames.
  ///
  /// In en, this message translates to:
  /// **'Added Frames'**
  String get actionAddedFrames;

  /// No description provided for @actionRemovedFrames.
  ///
  /// In en, this message translates to:
  /// **'Removed Frames'**
  String get actionRemovedFrames;

  /// No description provided for @actionFedSugarSyrup.
  ///
  /// In en, this message translates to:
  /// **'Fed Sugar Syrup'**
  String get actionFedSugarSyrup;

  /// No description provided for @actionFedPollen.
  ///
  /// In en, this message translates to:
  /// **'Fed Pollen'**
  String get actionFedPollen;

  /// No description provided for @actionTreatedVarroa.
  ///
  /// In en, this message translates to:
  /// **'Treated for Varroa'**
  String get actionTreatedVarroa;

  /// No description provided for @actionTreatedDisease.
  ///
  /// In en, this message translates to:
  /// **'Treated for Disease'**
  String get actionTreatedDisease;

  /// No description provided for @actionRequeened.
  ///
  /// In en, this message translates to:
  /// **'Requeened'**
  String get actionRequeened;

  /// No description provided for @actionSplitHive.
  ///
  /// In en, this message translates to:
  /// **'Split Hive'**
  String get actionSplitHive;

  /// No description provided for @actionCombinedHives.
  ///
  /// In en, this message translates to:
  /// **'Combined Hives'**
  String get actionCombinedHives;

  /// No description provided for @actionAddedSuper.
  ///
  /// In en, this message translates to:
  /// **'Added Super'**
  String get actionAddedSuper;

  /// No description provided for @actionRemovedSuper.
  ///
  /// In en, this message translates to:
  /// **'Removed Super'**
  String get actionRemovedSuper;

  /// No description provided for @actionHarvestedHoney.
  ///
  /// In en, this message translates to:
  /// **'Harvested Honey'**
  String get actionHarvestedHoney;

  /// No description provided for @actionMarkedQueen.
  ///
  /// In en, this message translates to:
  /// **'Marked Queen'**
  String get actionMarkedQueen;

  /// No description provided for @actionClippedQueen.
  ///
  /// In en, this message translates to:
  /// **'Clipped Queen'**
  String get actionClippedQueen;

  /// No description provided for @actionOther.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get actionOther;

  /// No description provided for @imageTypeEggs.
  ///
  /// In en, this message translates to:
  /// **'Eggs'**
  String get imageTypeEggs;

  /// No description provided for @imageTypeLarvae.
  ///
  /// In en, this message translates to:
  /// **'Larvae'**
  String get imageTypeLarvae;

  /// No description provided for @imageTypePollen.
  ///
  /// In en, this message translates to:
  /// **'Pollen'**
  String get imageTypePollen;

  /// No description provided for @imageTypePest.
  ///
  /// In en, this message translates to:
  /// **'Pest'**
  String get imageTypePest;
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
