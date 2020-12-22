import 'dart:convert';

import 'package:flutter/foundation.dart';

class RecipeListItemResponseDTO {
  final int id;
  final String title;
  final String photoUrl;
  final List<String> categories;

  RecipeListItemResponseDTO({
    this.id,
    this.title,
    this.photoUrl,
    this.categories,
  });

  factory RecipeListItemResponseDTO.fromJson(String source) =>
      RecipeListItemResponseDTO.fromMap(json.decode(source));

  factory RecipeListItemResponseDTO.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RecipeListItemResponseDTO(
      id: map['id'] as int,
      title: map['title'] as String,
      photoUrl: map['photo_url'] as String,
      categories: List<String>.from(map['categories']),
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        photoUrl.hashCode ^
        categories.hashCode;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecipeListItemResponseDTO &&
        o.id == id &&
        o.title == title &&
        o.photoUrl == photoUrl &&
        listEquals(o.categories, categories);
  }

  RecipeListItemResponseDTO copyWith({
    int id,
    String title,
    String photoUrl,
    List<String> categories,
  }) {
    return RecipeListItemResponseDTO(
      id: id ?? this.id,
      title: title ?? this.title,
      photoUrl: photoUrl ?? this.photoUrl,
      categories: categories ?? this.categories,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'photoUrl': photoUrl,
      'categories': categories,
    };
  }

  @override
  String toString() {
    return 'RecipeListItemResponseDTO(id: $id, title: $title, photoUrl: $photoUrl, categories: $categories)';
  }
}
