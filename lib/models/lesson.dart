import 'package:hive/hive.dart';

part 'lesson.g.dart';

@HiveType(typeId: 0)
class Lesson extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String title;

  @HiveField(2)
  final String teacher;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String status; // 'attended', 'missed', 'excused', 'postponed'

  @HiveField(5)
  final String? notes;

  Lesson({
    required this.id,
    required this.title,
    required this.teacher,
    required this.date,
    required this.status,
    this.notes,
  });

  Lesson copyWith({
    String? id,
    String? title,
    String? teacher,
    DateTime? date,
    String? status,
    String? notes,
  }) {
    return Lesson(
      id: id ?? this.id,
      title: title ?? this.title,
      teacher: teacher ?? this.teacher,
      date: date ?? this.date,
      status: status ?? this.status,
      notes: notes ?? this.notes,
    );
  }
}
