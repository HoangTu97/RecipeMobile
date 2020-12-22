import 'dart:convert';

import 'package:equatable/equatable.dart';

abstract class RecipeDetailEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RecipeDetailFetched extends RecipeDetailEvent {
  final int id;

  RecipeDetailFetched({
    this.id,
  });

  RecipeDetailFetched copyWith({
    int id,
  }) {
    return RecipeDetailFetched(
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }

  factory RecipeDetailFetched.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RecipeDetailFetched(
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeDetailFetched.fromJson(String source) =>
      RecipeDetailFetched.fromMap(json.decode(source));

  @override
  String toString() => 'RecipeDetailFetched(id: $id)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecipeDetailFetched && o.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
