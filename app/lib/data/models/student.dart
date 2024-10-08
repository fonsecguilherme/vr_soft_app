import 'dart:convert';

class Student {
  final int id;
  final String name;

  Student({
    required this.id,
    required this.name,
  });

  factory Student.fromRawJson(String str) =>
      Student.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Student.fromJson(Map<String, dynamic> json) => Student(
        id: json["codigo"],
        name: json["nome"],
      );

  Map<String, dynamic> toJson() => {
        "codigo": id,
        "nome": name,
      };
}
