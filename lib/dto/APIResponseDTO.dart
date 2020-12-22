import 'dart:convert';

class APIResponseDTO {
  final String error;
  final bool success;
  final dynamic data;

  APIResponseDTO({
    this.error,
    this.success,
    this.data,
  });

  factory APIResponseDTO.fromJson(String source) =>
      APIResponseDTO.fromMap(json.decode(source));

  factory APIResponseDTO.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return APIResponseDTO(
      error: map['error'],
      success: map['success'],
      data: map['data'],
    );
  }

  @override
  int get hashCode => error.hashCode ^ success.hashCode ^ data.hashCode;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is APIResponseDTO &&
        o.error == error &&
        o.success == success &&
        o.data == data;
  }

  APIResponseDTO copyWith({
    String error,
    bool success,
    dynamic data,
  }) {
    return APIResponseDTO(
      error: error ?? this.error,
      success: success ?? this.success,
      data: data ?? this.data,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'error': error,
      'success': success,
      'data': data,
    };
  }

  @override
  String toString() =>
      'APIResponseDTO(error: $error, success: $success, data: $data)';
}
