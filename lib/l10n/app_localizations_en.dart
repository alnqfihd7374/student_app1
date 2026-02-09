// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Student\'s Ledger';

  @override
  String get startNow => 'Start Now';

  @override
  String get firstName => 'First Name';

  @override
  String get lastName => 'Last Name';

  @override
  String get kunya => 'Kunya (Abu ...)';

  @override
  String get kunyaHint => 'Abu Abdullah';

  @override
  String get validationRequired => 'This field is required';

  @override
  String welcome(Object name) {
    return 'Welcome $name';
  }

  @override
  String get totalLessons => 'Total Lessons';

  @override
  String get attendanceRate => 'Attendance Rate';

  @override
  String get consistencyStreak => 'Consistency Streak';

  @override
  String get searchHint => 'Search by Book or Teacher...';

  @override
  String get filterAttended => 'Attended';

  @override
  String get filterMissed => 'Missed';

  @override
  String get addLesson => 'Add New Lesson';

  @override
  String get bookName => 'Book Title';

  @override
  String get teacherName => 'Teacher Name';

  @override
  String get date => 'Date';

  @override
  String get status => 'Attendance Status';

  @override
  String get notes => 'Scientific Benefits & Notes';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get attended => 'Attended';

  @override
  String get missed => 'Missed';

  @override
  String get excused => 'Excused';

  @override
  String get postponed => 'Postponed';

  @override
  String get noLessons => 'No lessons added yet. Start your journey!';

  @override
  String get deleteConfirm => 'Are you sure you want to delete this lesson?';

  @override
  String get exportData => 'Export Data';

  @override
  String get importData => 'Import Data';

  @override
  String get darkMode => 'Dark Mode';

  @override
  String get aboutApp => 'About App';

  @override
  String get aboutDescription =>
      'An app to help students of knowledge track their lessons and benefits.';
}
