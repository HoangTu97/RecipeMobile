import 'dart:convert';

class CategoryListItemResponseDTO {
  final int id;
  final String name;
  final String image;
  final int numberRecipes;

  CategoryListItemResponseDTO({
    this.id,
    this.name,
    this.image,
    this.numberRecipes,
  });

  factory CategoryListItemResponseDTO.fromJson(String source) =>
      CategoryListItemResponseDTO.fromMap(json.decode(source));

  factory CategoryListItemResponseDTO.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CategoryListItemResponseDTO(
      id: map['id'],
      name: map['name'],
      image: map['image'],
      numberRecipes: map['numberRecipes'],
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        image.hashCode ^
        numberRecipes.hashCode;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CategoryListItemResponseDTO &&
        o.id == id &&
        o.name == name &&
        o.image == image &&
        o.numberRecipes == numberRecipes;
  }

  CategoryListItemResponseDTO copyWith({
    int id,
    String name,
    String image,
    int numberRecipes,
  }) {
    return CategoryListItemResponseDTO(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      numberRecipes: numberRecipes ?? this.numberRecipes,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'image': image,
      'numberRecipes': numberRecipes,
    };
  }

  @override
  String toString() {
    return 'CategoryListItemResponseDTO(id: $id, name: $name, image: $image, numberRecipes: $numberRecipes)';
  }
}
