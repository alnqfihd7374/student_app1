import 'dart:convert';

class Lesson {
  final String id;
  final String bookName;
  final String teacherName;
  final String teacherTitle;
  final List<String> days;
  final int currentLessonNumber;
  final List<DateTime> missedLessonsDates;

  Lesson({
    required this.id,
    required this.bookName,
    required this.teacherName,
    required this.teacherTitle,
    required this.days,
    required this.currentLessonNumber,
    required this.missedLessonsDates,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'bookName': bookName,
      'teacherName': teacherName,
      'teacherTitle': teacherTitle,
      'days': days,
      'currentLessonNumber': currentLessonNumber,
      'missedLessonsDates': missedLessonsDates.map((x) => x.toIso8601String()).toList(),
    };
  }

  factory Lesson.fromMap(Map<String, dynamic> map) {
    return Lesson(
      id: map['id'] ?? '',
      bookName: map['bookName'] ?? '',
      teacherName: map['teacherName'] ?? '',
      teacherTitle: map['teacherTitle'] ?? '',
      days: List<String>.from(map['days'] ?? []),
      currentLessonNumber: map['currentLessonNumber']?.toInt() ?? 0,
      missedLessonsDates: List<DateTime>.from(
          (map['missedLessonsDates'] as List<dynamic>?)?.map((x) => DateTime.parse(x)) ?? []),
    );
  }

  String toJson() => json.encode(toMap());

  factory Lesson.fromJson(String source) => Lesson.fromMap(json.decode(source));

  Lesson copyWith({
    String? id,
    String? bookName,
    String? teacherName,
    String? teacherTitle,
    List<String>? days,
    int? currentLessonNumber,
    List<DateTime>? missedLessonsDates,
  }) {
    return Lesson(
      id: id ?? this.id,
      bookName: bookName ?? this.bookName,
      teacherName: teacherName ?? this.teacherName,
      teacherTitle: teacherTitle ?? this.teacherTitle,
      days: days ?? this.days,
      currentLessonNumber: currentLessonNumber ?? this.currentLessonNumber,
      missedLessonsDates: missedLessonsDates ?? this.missedLessonsDates,
    );
  }
}
