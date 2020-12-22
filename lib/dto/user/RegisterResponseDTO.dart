import 'dart:convert';

import 'package:equatable/equatable.dart';

class RegisterResponseDTO extends Equatable {
  final String token;

  RegisterResponseDTO({
    this.token,
  });

  RegisterResponseDTO copyWith({
    String token,
  }) {
    return RegisterResponseDTO(
      token: token ?? this.token,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'token': token,
    };
  }

  factory RegisterResponseDTO.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return RegisterResponseDTO(
      token: map['token'],
    );
  }

  String toJson() => json.encode(toMap());

  factory RegisterResponseDTO.fromJson(String source) =>
      RegisterResponseDTO.fromMap(json.decode(source));

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [token];
}
