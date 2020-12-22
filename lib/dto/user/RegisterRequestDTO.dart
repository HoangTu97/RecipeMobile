import 'dart:convert';

import 'package:meta/meta.dart';

import 'LoginRequestDTO.dart';

class RegisterRequestDTO extends LoginRequestDTO {
  final String username;
  final String password;

  RegisterRequestDTO({
    @required this.username,
    @required this.password,
  });

  RegisterRequestDTO copyWith({
    String username,
    String password,
  }) {
    return RegisterRequestDTO(
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

  factory RegisterRequestDTO.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RegisterRequestDTO(
      username: map['username'],
      password: map['password'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterRequestDTO.fromJson(String source) =>
      RegisterRequestDTO.fromMap(json.decode(source));

  @override
  String toString() =>
      'RegisterRequestDTO(username: $username, password: $password)';

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is RegisterRequestDTO &&
        o.username == username &&
        o.password == password;
  }

  @override
  int get hashCode => username.hashCode ^ password.hashCode;
}
