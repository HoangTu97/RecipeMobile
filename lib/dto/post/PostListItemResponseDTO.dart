import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/foundation.dart';

class PostListItemResponseDTO {
  final Uint32 id;

  final Uint32 userId;
  final String userName;

  final Uint32 recipeId;
  final String recipePhoto;
  final String recipeTitle;
  final String recipeDesc;
  final List<String> tags;

  final int countLike;

  PostListItemResponseDTO({
    this.id,
    this.userId,
    this.userName,
    this.recipeId,
    this.recipePhoto,
    this.recipeTitle,
    this.recipeDesc,
    this.tags,
    this.countLike,
  });

  factory PostListItemResponseDTO.fromJson(String source) =>
      PostListItemResponseDTO.fromMap(json.decode(source));

  factory PostListItemResponseDTO.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PostListItemResponseDTO(
      id: map['id'] as Uint32,
      userId: map['user_id'] as Uint32,
      userName: map['user_name'] as String,
      recipeId: map['recipe_id'] as Uint32,
      recipePhoto: map['recipe_photo'] as String,
      recipeTitle: map['recipe_title'] as String,
      recipeDesc: map['recipe_desc'] as String,
      tags: List<String>.from(map['tags']),
      countLike: map['count_like'] as int,
    );
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        userName.hashCode ^
        recipeId.hashCode ^
        recipePhoto.hashCode ^
        recipeTitle.hashCode ^
        recipeDesc.hashCode ^
        tags.hashCode ^
        countLike.hashCode;
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PostListItemResponseDTO &&
        o.id == id &&
        o.userId == userId &&
        o.userName == userName &&
        o.recipeId == recipeId &&
        o.recipePhoto == recipePhoto &&
        o.recipeTitle == recipeTitle &&
        o.recipeDesc == recipeDesc &&
        listEquals(o.tags, tags) &&
        o.countLike == countLike;
  }

  PostListItemResponseDTO copyWith({
    Uint32 id,
    Uint32 userId,
    String userName,
    Uint32 recipeId,
    String recipePhoto,
    String recipeTitle,
    String recipeDesc,
    List<String> tags,
    int countLike,
  }) {
    return PostListItemResponseDTO(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      recipeId: recipeId ?? this.recipeId,
      recipePhoto: recipePhoto ?? this.recipePhoto,
      recipeTitle: recipeTitle ?? this.recipeTitle,
      recipeDesc: recipeDesc ?? this.recipeDesc,
      tags: tags ?? this.tags,
      countLike: countLike ?? this.countLike,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'userName': userName,
      'recipeId': recipeId,
      'recipePhoto': recipePhoto,
      'recipeTitle': recipeTitle,
      'recipeDesc': recipeDesc,
      'tags': tags,
      'countLike': countLike,
    };
  }

  @override
  String toString() {
    return 'PostListItemResponseDTO(id: $id, userId: $userId, userName: $userName, recipeId: $recipeId, recipePhoto: $recipePhoto, recipeTitle: $recipeTitle, recipeDesc: $recipeDesc, tags: $tags, countLike: $countLike)';
  }
}
