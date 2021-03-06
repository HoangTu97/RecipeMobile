import 'dart:convert';

import 'package:flutter/foundation.dart';

class RecipeDetailResponseDTO {
  final int id;
  final String title;
  final List<String> photos;
  final int duration;
  final String description;
  final List<String> categories;
  final List<String> steps;

  RecipeDetailResponseDTO({
    this.id,
    this.title,
    this.photos,
    this.duration,
    this.description,
    this.categories,
    this.steps,
  });

  factory RecipeDetailResponseDTO.fromJson(String source) =>
      RecipeDetailResponseDTO.fromMap(json.decode(source));

  factory RecipeDetailResponseDTO.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RecipeDetailResponseDTO(
      id: map['id'] as int,
      title: map['title'] as String,
      photos: map['photos'] == null ? [] : List<String>.from(map['photos']),
      duration: map['duration'] as int,
      description: map['description'] as String,
      categories:
          map['categories'] == null ? [] : List<String>.from(map['categories']),
      steps: map['steps'] == null ? [] : List<String>.from(map['steps']),
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
    List<String> steps,
  }) {
    return RecipeDetailResponseDTO(
      id: id ?? this.id,
      title: title ?? this.title,
      photos: photos ?? this.photos,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      categories: categories ?? this.categories,
      steps: steps ?? this.steps,
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
      'steps': steps,
    };
  }

  @override
  String toString() {
    return 'RecipeDetailResponseDTO(id: $id, title: $title, photos: $photos, duration: $duration, description: $description, categories: $categories, steps: $steps)';
  }
}
