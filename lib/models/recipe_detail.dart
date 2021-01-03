import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:recipes/dto/recipe/RecipeDetailResponseDTO.dart';

class RecipeDetail extends Equatable {
  final int id;
  final String title;
  final List<String> photos;
  final int duration;
  final String description;
  final List<String> categories;
  final List<String> steps;

  RecipeDetail({
    this.id,
    this.title,
    this.photos,
    this.duration,
    this.description,
    this.categories,
    this.steps,
  });

  RecipeDetail copyWith({
    int id,
    String title,
    List<String> photos,
    int duration,
    String description,
    List<String> categories,
    List<String> steps,
  }) {
    return RecipeDetail(
      id: id ?? this.id,
      title: title ?? this.title,
      photos: photos ?? this.photos,
      duration: duration ?? this.duration,
      description: description ?? this.description,
      categories: categories ?? this.categories,
      steps: steps ?? this.steps,
    );
  }

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

  factory RecipeDetail.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RecipeDetail(
      id: map['id'],
      title: map['title'],
      photos: List<String>.from(map['photos']),
      duration: map['duration'],
      description: map['description'],
      categories: List<String>.from(map['categories']),
      steps: List<String>.from(map['steps']),
    );
  }

  factory RecipeDetail.fromResponse(RecipeDetailResponseDTO responseDTO) {
    if (responseDTO == null) return null;
    return RecipeDetail(
      id: responseDTO.id,
      title: responseDTO.title,
      photos: responseDTO.photos,
      duration: responseDTO.duration,
      description: responseDTO.description,
      categories: responseDTO.categories,
      steps: responseDTO.steps,
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeDetail.fromJson(String source) =>
      RecipeDetail.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props {
    return [
      id,
      title,
      photos,
      duration,
      description,
      categories,
      steps,
    ];
  }
}
