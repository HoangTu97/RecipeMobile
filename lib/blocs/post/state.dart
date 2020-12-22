import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

import 'package:recipes/models/post.dart';

abstract class PostState extends Equatable {
  const PostState();

  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostFailure extends PostState {}

class PostSuccess extends PostState {
  final List<Post> posts;
  final bool hasReachedMax;

  PostSuccess({
    this.posts,
    this.hasReachedMax,
  });

  PostSuccess copyWith({
    List<Post> posts,
    bool hasReachedMax,
  }) {
    return PostSuccess(
      posts: posts ?? this.posts,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'posts': posts?.map((x) => x?.toMap())?.toList(),
      'hasReachedMax': hasReachedMax,
    };
  }

  factory PostSuccess.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return PostSuccess(
      posts: List<Post>.from(map['posts']?.map((x) => Post.fromMap(x))),
      hasReachedMax: map['hasReachedMax'],
    );
  }

  String toJson() => json.encode(toMap());

  factory PostSuccess.fromJson(String source) =>
      PostSuccess.fromMap(json.decode(source));

  @override
  String toString() =>
      'PostSuccess(posts: $posts, hasReachedMax: $hasReachedMax)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is PostSuccess &&
        listEquals(o.posts, posts) &&
        o.hasReachedMax == hasReachedMax;
  }

  @override
  int get hashCode => posts.hashCode ^ hasReachedMax.hashCode;
}
