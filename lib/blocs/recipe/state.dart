import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:recipes/models/recipe.dart';

abstract class RecipeState extends Equatable {
  const RecipeState();

  @override
  List<Object> get props => [];
}

class RecipeInitial extends RecipeState {}

class RecipeFailure extends RecipeState {}

class RecipeSuccess extends RecipeState {
  final List<Recipe> recipes;
  final bool hasReachedMax;

  const RecipeSuccess({
    this.recipes,
    this.hasReachedMax,
  });

  RecipeSuccess copyWith({
    List<Recipe> recipes,
    bool hasReachedMax,
  }) {
    return RecipeSuccess(
      recipes: recipes ?? this.recipes,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'recipes': recipes?.map((x) => x?.toMap())?.toList(),
      'hasReachedMax': hasReachedMax,
    };
  }

  factory RecipeSuccess.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RecipeSuccess(
      recipes: List<Recipe>.from(map['recipes']?.map((x) => Recipe.fromMap(x))),
      hasReachedMax: map['hasReachedMax'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeSuccess.fromJson(String source) =>
      RecipeSuccess.fromMap(json.decode(source));

  @override
  String toString() =>
      'RecipeSuccess(recipes: $recipes, hasReachedMax: $hasReachedMax)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecipeSuccess &&
        listEquals(o.recipes, recipes) &&
        o.hasReachedMax == hasReachedMax;
  }

  @override
  int get hashCode => recipes.hashCode ^ hasReachedMax.hashCode;
}
