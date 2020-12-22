import 'dart:convert';

import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;

  User({
    this.id,
  });

  factory User.fromJson(String source) => User.fromMap(json.decode(source));

  factory User.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return User(
      id: map['id'],
    );
  }

  @override
  List<Object> get props => [id];

  @override
  bool get stringify => true;

  User copyWith({
    String id,
  }) {
    return User(
      id: id ?? this.id,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'id': id,
    };
  }
}
