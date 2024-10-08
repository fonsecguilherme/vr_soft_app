import 'dart:convert';

import 'package:app/data/models/course.dart';

class Student {
  final int id;
  final String name;
  final List<Course> courses;

  Student({required this.id, required this.name, required this.courses});

  factory Student.fromRawJson(String str) => Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["codigo"],
        name: json["nome"],
        courses: List<Course>.from(
          json["cursos"].map((x) => Course.fromJson(x as Map<String, dynamic>)),
        ),
      );

  Map<String, dynamic> toJson() => {
        "codigo": id,
        "nome": name,
        "cursos": courses,
      };
}
