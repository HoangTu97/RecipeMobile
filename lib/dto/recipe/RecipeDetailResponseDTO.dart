import 'dart:convert';

import 'package:flutter/foundation.dart';

class RecipeDetailResponseDTO {
  final int id;
  final String title;
  final List<String> photos;
  final int duration;
  final String description;
  final List<String> categories;

  RecipeDetailResponseDTO({
    this.id,
    this.title,
    this.photos,
    this.duration,
    this.description,
    this.categories,
  });

  factory RecipeDetailResponseDTO.fromJson(String source) =>
      RecipeDetailResponseDTO.fromMap(json.decode(source));

  factory RecipeDetailResponseDTO.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RecipeDetailResponseDTO(
      id: map['id'] as int,
      title: map['title'] as String,
      photos: List<String>.from(map['photos']),
      duration: map['duration'] as int,
      description: map['description'] as String,
      categories: List<String>.from(map['categories']),
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        title.hashCode ^
        photos.hashCode ^
        duration.hashCode ^
        description.hashCode ^
        categories.hashCode;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecipeDetailResponseDTO &&
        o.id == id &&
        o.title == title &&
        listEquals(o.photos, photos) &&
        o.duration == duration &&
        o.description == description &&
        listEquals(o.categories, categories);
  }

  RecipeDetailResponseDTO copyWith({
    int id,
    String title,
    List<String> photos,
    int duration,
    String description,
    List<String> categories,
  }) {
    return RecipeDetailResponseDTO(
      id: id ?? this.id,
      title: title ?? this.title,
      photos: photos ?? this.photos,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      categories: categories ?? this.categories,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'photos': photos,
      'duration': duration,
      'description': description,
      'categories': categories,
    };
  }

  @override
  String toString() {
    return 'RecipeDetailResponseDTO(id: $id, title: $title, photos: $photos, duration: $duration, description: $description, categories: $categories)';
  }
}
