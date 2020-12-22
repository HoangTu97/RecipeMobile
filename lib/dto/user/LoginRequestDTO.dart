import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

class LoginRequestDTO extends Equatable {
  final String username;
  final String password;

  LoginRequestDTO({
    @required this.username,
    @required this.password,
  });

  LoginRequestDTO copyWith({
    String username,
    String password,
  }) {
    return LoginRequestDTO(
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'username': username,
      'password': password,
    };
  }

  factory LoginRequestDTO.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LoginRequestDTO(
      username: map['username'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginRequestDTO.fromJson(String source) =>
      LoginRequestDTO.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [username, password];
}
