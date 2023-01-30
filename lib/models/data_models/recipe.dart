import 'dart:convert';

class Recipe {
  Recipe({
    required this.title,
    required this.ingredients,
  });

  final String title;
  final List<String> ingredients;

  Recipe copyWith({
    String? title,
    List<String>? ingredients,
  }) =>
      Recipe(
        title: title ?? this.title,
        ingredients: ingredients ?? this.ingredients,
      );

  factory Recipe.fromJson(String str) => Recipe.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Recipe.fromMap(Map<String, dynamic> json) => Recipe(
    title: json["title"],
    ingredients: List<String>.from(json["ingredients"].map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "title": title,
    "ingredients": List<dynamic>.from(ingredients.map((x) => x)),
  };
}
