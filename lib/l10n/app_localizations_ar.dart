// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appTitle => 'سجل طالب العلم';

  @override
  String get startNow => 'ابدأ الآن';

  @override
  String get firstName => 'الاسم الأول';

  @override
  String get lastName => 'اللقب / العائلة';

  @override
  String get kunya => 'الكنية (أبو فلان)';

  @override
  String get kunyaHint => 'أبو عبد الله';

  @override
  String get validationRequired => 'هذا الحقل مطلوب';

  @override
  String welcome(Object name) {
    return 'مرحباً بك يا $name';
  }

  @override
  String get totalLessons => 'مجموع الدروس';

  @override
  String get attendanceRate => 'نسبة الحضور';

  @override
  String get consistencyStreak => 'أيام المواظبة';

  @override
  String get searchHint => 'ابحث باسم الكتاب أو الشيخ...';

  @override
  String get filterAttended => 'المحضور';

  @override
  String get filterMissed => 'الفائت';

  @override
  String get addLesson => 'إضافة درس جديد';

  @override
  String get bookName => 'اسم المتن / الكتاب';

  @override
  String get teacherName => 'اسم الشيخ';

  @override
  String get date => 'التاريخ';

  @override
  String get status => 'حالة الحضور';

  @override
  String get notes => 'الفوائد العلمية والشوارد';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get attended => 'حضر';

  @override
  String get missed => 'غاب';

  @override
  String get excused => 'معذور';

  @override
  String get postponed => 'مؤجل';

  @override
  String get noLessons => 'لم يتم إضافة أي دروس بعد. ابدأ بطلب العلم!';

  @override
  String get deleteConfirm => 'هل أنت متأكد من حذف هذا الدرس؟';

  @override
  String get exportData => 'تصدير البيانات';

  @override
  String get importData => 'استيراد البيانات';

  @override
  String get darkMode => 'الوضع الليلي';

  @override
  String get aboutApp => 'حول التطبيق';

  @override
  String get aboutDescription =>
      'تطبيق يعين طالب العلم على ضبط فوائده ومتابعة دروسه وتقييم انتظامه في الطلب.';
}
