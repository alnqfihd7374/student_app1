import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

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
  ];

  /// No description provided for @appTitle.
  ///
  /// In ar, this message translates to:
  /// **'سجل طالب العلم'**
  String get appTitle;

  /// No description provided for @startNow.
  ///
  /// In ar, this message translates to:
  /// **'ابدأ الآن'**
  String get startNow;

  /// No description provided for @firstName.
  ///
  /// In ar, this message translates to:
  /// **'الاسم الأول'**
  String get firstName;

  /// No description provided for @lastName.
  ///
  /// In ar, this message translates to:
  /// **'اللقب / العائلة'**
  String get lastName;

  /// No description provided for @kunya.
  ///
  /// In ar, this message translates to:
  /// **'الكنية (أبو فلان)'**
  String get kunya;

  /// No description provided for @kunyaHint.
  ///
  /// In ar, this message translates to:
  /// **'أبو عبد الله'**
  String get kunyaHint;

  /// No description provided for @validationRequired.
  ///
  /// In ar, this message translates to:
  /// **'هذا الحقل مطلوب'**
  String get validationRequired;

  /// No description provided for @welcome.
  ///
  /// In ar, this message translates to:
  /// **'مرحباً بك يا {name}'**
  String welcome(Object name);

  /// No description provided for @totalLessons.
  ///
  /// In ar, this message translates to:
  /// **'مجموع الدروس'**
  String get totalLessons;

  /// No description provided for @attendanceRate.
  ///
  /// In ar, this message translates to:
  /// **'نسبة الحضور'**
  String get attendanceRate;

  /// No description provided for @consistencyStreak.
  ///
  /// In ar, this message translates to:
  /// **'أيام المواظبة'**
  String get consistencyStreak;

  /// No description provided for @searchHint.
  ///
  /// In ar, this message translates to:
  /// **'ابحث باسم الكتاب أو الشيخ...'**
  String get searchHint;

  /// No description provided for @filterAttended.
  ///
  /// In ar, this message translates to:
  /// **'المحضور'**
  String get filterAttended;

  /// No description provided for @filterMissed.
  ///
  /// In ar, this message translates to:
  /// **'الفائت'**
  String get filterMissed;

  /// No description provided for @addLesson.
  ///
  /// In ar, this message translates to:
  /// **'إضافة درس جديد'**
  String get addLesson;

  /// No description provided for @bookName.
  ///
  /// In ar, this message translates to:
  /// **'اسم المتن / الكتاب'**
  String get bookName;

  /// No description provided for @teacherName.
  ///
  /// In ar, this message translates to:
  /// **'اسم الشيخ'**
  String get teacherName;

  /// No description provided for @date.
  ///
  /// In ar, this message translates to:
  /// **'التاريخ'**
  String get date;

  /// No description provided for @status.
  ///
  /// In ar, this message translates to:
  /// **'حالة الحضور'**
  String get status;

  /// No description provided for @notes.
  ///
  /// In ar, this message translates to:
  /// **'الفوائد العلمية والشوارد'**
  String get notes;

  /// No description provided for @save.
  ///
  /// In ar, this message translates to:
  /// **'حفظ'**
  String get save;

  /// No description provided for @cancel.
  ///
  /// In ar, this message translates to:
  /// **'إلغاء'**
  String get cancel;

  /// No description provided for @attended.
  ///
  /// In ar, this message translates to:
  /// **'حضر'**
  String get attended;

  /// No description provided for @missed.
  ///
  /// In ar, this message translates to:
  /// **'غاب'**
  String get missed;

  /// No description provided for @excused.
  ///
  /// In ar, this message translates to:
  /// **'معذور'**
  String get excused;

  /// No description provided for @postponed.
  ///
  /// In ar, this message translates to:
  /// **'مؤجل'**
  String get postponed;

  /// No description provided for @noLessons.
  ///
  /// In ar, this message translates to:
  /// **'لم يتم إضافة أي دروس بعد. ابدأ بطلب العلم!'**
  String get noLessons;

  /// No description provided for @deleteConfirm.
  ///
  /// In ar, this message translates to:
  /// **'هل أنت متأكد من حذف هذا الدرس؟'**
  String get deleteConfirm;

  /// No description provided for @exportData.
  ///
  /// In ar, this message translates to:
  /// **'تصدير البيانات'**
  String get exportData;

  /// No description provided for @importData.
  ///
  /// In ar, this message translates to:
  /// **'استيراد البيانات'**
  String get importData;

  /// No description provided for @darkMode.
  ///
  /// In ar, this message translates to:
  /// **'الوضع الليلي'**
  String get darkMode;

  /// No description provided for @aboutApp.
  ///
  /// In ar, this message translates to:
  /// **'حول التطبيق'**
  String get aboutApp;

  /// No description provided for @aboutDescription.
  ///
  /// In ar, this message translates to:
  /// **'تطبيق يعين طالب العلم على ضبط فوائده ومتابعة دروسه وتقييم انتظامه في الطلب.'**
  String get aboutDescription;
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
      <String>['ar', 'en'].contains(locale.languageCode);

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
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
