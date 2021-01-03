import 'dart:convert';
import 'dart:ffi';

import 'package:equatable/equatable.dart';
import 'package:recipes/dto/post/PostListItemResponseDTO.dart';

class Post extends Equatable {
  final int id;

  final int userId;
  final String userName;

  final int recipeId;
  final String recipePhoto;
  final String recipeTitle;
  final String recipeDesc;
  final List<String> hashTags;

  final int likes;

  const Post({
    this.id,
    this.userId,
    this.userName,
    this.recipeId,
    this.recipePhoto,
    this.recipeTitle,
    this.recipeDesc,
    this.hashTags,
    this.likes,
  });

  factory Post.fromJson(String source) => Post.fromMap(json.decode(source));

  factory Post.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return Post(
      id: map['id'],
      userId: map['userId'],
      userName: map['userName'],
      recipeId: map['recipeId'],
      recipePhoto: map['recipePhoto'],
      recipeTitle: map['recipeTitle'],
      recipeDesc: map['recipeDesc'],
      hashTags: List<String>.from(map['hashTags']),
      likes: map['likes'],
    );
  }

  factory Post.fromResponse(PostListItemResponseDTO responseDTO) {
    if (responseDTO == null) return null;
    return Post(
      id: responseDTO.id,
      userId: responseDTO.userId,
      userName: responseDTO.userName,
      recipeId: responseDTO.recipeId,
      recipePhoto: responseDTO.recipePhoto,
      recipeTitle: responseDTO.recipeTitle,
      recipeDesc: responseDTO.recipeDesc,
      hashTags: responseDTO.tags,
      likes: responseDTO.countLike,
    );
  }

  @override
  List<Object> get props {
    return [
      id,
      userId,
      userName,
      recipeId,
      recipePhoto,
      recipeTitle,
      recipeDesc,
      hashTags,
      likes,
    ];
  }

  @override
  bool get stringify => true;

  Post copyWith({
    Uint32 id,
    Uint32 userId,
    String userName,
    Uint32 recipeId,
    String recipePhoto,
    String recipeTitle,
    String recipeDesc,
    List<String> hashTags,
    int likes,
  }) {
    return Post(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      userName: userName ?? this.userName,
      recipeId: recipeId ?? this.recipeId,
      recipePhoto: recipePhoto ?? this.recipePhoto,
      recipeTitle: recipeTitle ?? this.recipeTitle,
      recipeDesc: recipeDesc ?? this.recipeDesc,
      hashTags: hashTags ?? this.hashTags,
      likes: likes ?? this.likes,
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
      'hashTags': hashTags,
      'likes': likes,
    };
  }
}
