import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:student_app/models/lesson.dart';
import 'package:student_app/core/hive_setup.dart';

class LessonProvider with ChangeNotifier {
  Box<Lesson>? _box;
  List<Lesson> _lessons = [];
  bool _isLoading = true;

  // Search & Filter
  String _searchQuery = '';
  String? _statusFilter; // 'attended', 'missed', or null
  String? get statusFilter => _statusFilter;

  List<Lesson> get lessons {
    if (_box == null) return [];
    
    var filtered = _lessons;

    // Apply Status Filter
    if (_statusFilter != null) {
      filtered = filtered.where((l) => l.status == _statusFilter).toList();
    }

    // Apply Search
    if (_searchQuery.isNotEmpty) {
      final q = _searchQuery.toLowerCase();
      filtered = filtered.where((l) => 
        l.title.toLowerCase().contains(q) || 
        l.teacher.toLowerCase().contains(q)
      ).toList();
    }

    // Sort by date descending
    filtered.sort((a, b) => b.date.compareTo(a.date));
    return filtered;
  }

  bool get isLoading => _isLoading;

  Future<void> init() async {
    // We assume Hive is initialized in main.dart
    // await Hive.openBox<Lesson>(HiveSetup.lessonsBoxName); // Moved to main/hive_setup
    if (Hive.isBoxOpen(HiveSetup.lessonsBoxName)) {
        _box = Hive.box<Lesson>(HiveSetup.lessonsBoxName);
        _refresh();
    }
  }
  
  void setBox(Box<Lesson> box) {
    _box = box;
    _refresh();
  }

  void _refresh() {
    if (_box != null) {
      _lessons = _box!.values.toList();
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> addLesson(Lesson lesson) async {
    if (_box != null) {
      await _box!.add(lesson);
      _refresh();
    }
  }

  Future<void> updateLesson(Lesson lesson) async {
    if (lesson.isInBox) {
      await lesson.save();
      _refresh();
    }
  }

  Future<void> deleteLesson(Lesson lesson) async {
    if (lesson.isInBox) {
      await lesson.delete();
      _refresh();
    }
  }

  // Analytics
  int get totalLessons => _lessons.length;
  
  double get attendanceRate {
    if (_lessons.isEmpty) return 0.0;
    final attended = _lessons.where((l) => l.status == 'attended').length;
    return attended / _lessons.length;
  }

  int get consistencyStreak {
    // Simple streak logic: consecutive attended lessons sorted by date
    if (_lessons.isEmpty) return 0;
    final sorted = List<Lesson>.from(_lessons)..sort((a, b) => b.date.compareTo(a.date));
    int streak = 0;
    for (var l in sorted) {
      if (l.status == 'attended') {
        streak++;
      } else {
        break;
      }
    }
    return streak;
  }

  // Filter setters
  void setSearchQuery(String query) {
    _searchQuery = query;
    notifyListeners();
  }

  void setStatusFilter(String? status) {
    _statusFilter = status;
    notifyListeners();
  }
}
