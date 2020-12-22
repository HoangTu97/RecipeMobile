import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:recipes/dto/recipe/RecipeListItemResponseDTO.dart';

class Recipe extends Equatable {
  final int id;
  final String title;
  final String photoUrl;
  final List<String> categories;

  Recipe({
    this.id,
    this.title,
    this.photoUrl,
    this.categories,
  });

  Recipe copyWith({
    int id,
    String title,
    String photoUrl,
    List<String> categories,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      photoUrl: photoUrl ?? this.photoUrl,
      categories: categories ?? this.categories,
    );
  }

  factory Recipe.fromResponse(RecipeListItemResponseDTO responseDTO) {
    if (responseDTO == null) return null;

    return Recipe(
      id: responseDTO.id,
      title: responseDTO.title,
      photoUrl: responseDTO.photoUrl,
      categories: responseDTO.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'photoUrl': photoUrl,
      'categories': categories,
    };
  }

  factory Recipe.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Recipe(
      id: map['id'],
      title: map['title'],
      photoUrl: map['photoUrl'],
      categories: List<String>.from(map['categories']),
    );
  }

  String toJson() => json.encode(toMap());

  factory Recipe.fromJson(String source) => Recipe.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, title, photoUrl, categories];
}
