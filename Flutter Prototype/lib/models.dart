import 'package:flutter/material.dart';

class StudyFile {
  String name;
  String topic;

  StudyFile({required this.name, required this.topic});
}

class Course {
  final String id;
  String name;
  String code;
  String semester;
  List<StudyFile> files;

  Course({
    required this.id,
    required this.name,
    required this.code,
    required this.semester,
    List<StudyFile>? files,
  }) : files = files ?? [];
}

class Availability {
  List<int> days; // 0 = Mon ... 6 = Sun
  TimeOfDay start;
  TimeOfDay end;

  Availability({
    required this.days,
    required this.start,
    required this.end,
  });
}
