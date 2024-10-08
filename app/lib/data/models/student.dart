import 'dart:convert';

class Strudent {
  final int id;
  final String name;

  Strudent({
    required this.id,
    required this.name,
  });

  factory Strudent.fromRawJson(String str) =>
      Strudent.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Strudent.fromJson(Map<String, dynamic> json) => Strudent(
        id: json["codigo"],
        name: json["nome"],
      );

  Map<String, dynamic> toJson() => {
        "codigo": id,
        "nome": name,
      };
}
