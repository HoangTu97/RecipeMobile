import 'dart:convert';

import 'package:equatable/equatable.dart';

class LoginResponseDTO extends Equatable {
  final String token;

  LoginResponseDTO({
    this.token,
  });

  LoginResponseDTO copyWith({
    String token,
  }) {
    return LoginResponseDTO(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }

  factory LoginResponseDTO.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return LoginResponseDTO(
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory LoginResponseDTO.fromJson(String source) =>
      LoginResponseDTO.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [token];
}
