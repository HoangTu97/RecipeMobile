import 'dart:convert';

import 'package:equatable/equatable.dart';

import 'package:recipes/models/recipe_detail.dart';

abstract class RecipeDetailState extends Equatable {
  @override
  List<Object> get props => [];
}

class RecipeDetailInitial extends RecipeDetailState {}

class RecipeDetailFailure extends RecipeDetailState {}

class RecipeDetailSuccess extends RecipeDetailState {
  final RecipeDetail detail;

  RecipeDetailSuccess({
    this.detail,
  });

  RecipeDetailSuccess copyWith({
    RecipeDetail detail,
  }) {
    return RecipeDetailSuccess(
      detail: detail ?? this.detail,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'detail': detail?.toMap(),
    };
  }

  factory RecipeDetailSuccess.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RecipeDetailSuccess(
      detail: RecipeDetail.fromMap(map['detail']),
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeDetailSuccess.fromJson(String source) =>
      RecipeDetailSuccess.fromMap(json.decode(source));

  @override
  String toString() => 'RecipeDetailSuccess(detail: $detail)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecipeDetailSuccess && o.detail == detail;
  }

  @override
  int get hashCode => detail.hashCode;
}
