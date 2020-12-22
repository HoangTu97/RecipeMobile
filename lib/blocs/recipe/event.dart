import 'dart:convert';

import 'package:equatable/equatable.dart';

abstract class RecipeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class RecipeFetched extends RecipeEvent {
  final String text;

  RecipeFetched({
    this.text,
  });

  RecipeFetched copyWith({
    String text,
  }) {
    return RecipeFetched(
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  factory RecipeFetched.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RecipeFetched(
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeFetched.fromJson(String source) =>
      RecipeFetched.fromMap(json.decode(source));

  @override
  String toString() => 'RecipeFetched(text: $text)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecipeFetched && o.text == text;
  }

  @override
  int get hashCode => text.hashCode;
}

class RecipeReload extends RecipeEvent {
  final String text;

  RecipeReload({
    this.text,
  });

  RecipeReload copyWith({
    String text,
  }) {
    return RecipeReload(
      text: text ?? this.text,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'text': text,
    };
  }

  factory RecipeReload.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RecipeReload(
      text: map['text'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RecipeReload.fromJson(String source) =>
      RecipeReload.fromMap(json.decode(source));

  @override
  String toString() => 'RecipeReload(text: $text)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RecipeReload && o.text == text;
  }

  @override
  int get hashCode => text.hashCode;
}
