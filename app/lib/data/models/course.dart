import 'dart:convert';

class Course {
  final int id;
  final String description;
  final String courseSyllabus;

  Course({
    required this.id,
    required this.description,
    required this.courseSyllabus,
  });

  factory Course.fromRawJson(String str) => Course.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Course.fromJson(Map<String, dynamic> json) => Course(
        id: json["codigo"],
        description: json["descricao"],
        courseSyllabus: json["ementa"],
      );

  Map<String, dynamic> toJson() => {
        "codigo": id,
        "descricao": description,
        "ementa": courseSyllabus,
      };
}
