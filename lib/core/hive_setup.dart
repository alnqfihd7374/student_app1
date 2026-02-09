import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:student_app/models/lesson.dart';

class HiveSetup {
  static const String lessonsBoxName = 'lessons_box';

  static Future<void> init() async {
    if (!kIsWeb) {
      final appDocumentDir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(appDocumentDir.path);
    } else {
      await Hive.initFlutter();
    }
    
    // Register Adapter
    Hive.registerAdapter(LessonAdapter());
    
    await Hive.openBox<Lesson>(lessonsBoxName);
  }
}
