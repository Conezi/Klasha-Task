import 'dart:convert';

class Ingredient {
  Ingredient({
    required this.title,
    required this.useBy,
  });

  final String title;
  final DateTime useBy;

  Ingredient copyWith({
    String? title,
    DateTime? useBy,
  }) =>
      Ingredient(
        title: title ?? this.title,
        useBy: useBy ?? this.useBy,
      );

  factory Ingredient.fromJson(String str) => Ingredient.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Ingredient.fromMap(Map<String, dynamic> json) => Ingredient(
    title: json["title"],
    useBy: DateTime.parse(json["use-by"]),
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "use-by": useBy.toIso8601String(),
  };
}
