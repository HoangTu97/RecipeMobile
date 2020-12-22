import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:recipes/models/index.dart' as model;

abstract class CategoryState extends Equatable {
  @override
  List<Object> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryFailure extends CategoryState {}

class CategorySuccess extends CategoryState {
  final List<model.Category> categories;

  CategorySuccess({
    this.categories,
  });

  CategorySuccess copyWith({
    List<model.Category> categories,
  }) {
    return CategorySuccess(
      categories: categories ?? this.categories,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categories': categories?.map((x) => x?.toMap())?.toList(),
    };
  }

  factory CategorySuccess.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return CategorySuccess(
      categories: List<model.Category>.from(
          map['categories']?.map((x) => model.Category.fromMap(x))),
    );
  }

  String toJson() => json.encode(toMap());

  factory CategorySuccess.fromJson(String source) =>
      CategorySuccess.fromMap(json.decode(source));

  @override
  String toString() => 'CategorySuccess(categories: $categories)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is CategorySuccess && listEquals(o.categories, categories);
  }

  @override
  int get hashCode => categories.hashCode;
}
