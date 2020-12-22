import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:recipes/dto/category/CategoryListItemResponseDTO.dart';

class Category extends Equatable {
  final int id;
  final String name;
  final String image;
  final int numberRecipes;

  Category({
    this.id,
    this.name,
    this.image,
    this.numberRecipes,
  });

  Category copyWith({
    int id,
    String name,
    String image,
    int numberRecipes,
  }) {
    return Category(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      numberRecipes: numberRecipes ?? this.numberRecipes,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'numberRecipes': numberRecipes,
    };
  }

  factory Category.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Category(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      numberRecipes: map['numberRecipes'],
    );
  }

  factory Category.fromResponse(CategoryListItemResponseDTO responseDTO) {
    if (responseDTO == null) return null;
    return Category(
      id: responseDTO.id,
      name: responseDTO.name,
      image: responseDTO.image,
      numberRecipes: responseDTO.numberRecipes,
    );
  }

  String toJson() => json.encode(toMap());

  factory Category.fromJson(String source) =>
      Category.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [id, name, image, numberRecipes];
}
