import 'dart:convert';

import 'package:flutter/foundation.dart';

class ListResponseDTO {
  final int totalItems;
  final List<dynamic> items;

  ListResponseDTO({this.totalItems, this.items});

  factory ListResponseDTO.fromJson(String source) =>
      ListResponseDTO.fromMap(json.decode(source));

  factory ListResponseDTO.fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
    return ListResponseDTO(
      totalItems: map['totalItems'],
      items: List<dynamic>.from(map['items']),
    );
  }

  @override
  int get hashCode => totalItems.hashCode ^ items.hashCode;

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is ListResponseDTO &&
        o.totalItems == totalItems &&
        listEquals(o.items, items);
  }

  ListResponseDTO copyWith({
    int totalItems,
    List<dynamic> items,
  }) {
    return ListResponseDTO(
      totalItems: totalItems ?? this.totalItems,
      items: items ?? this.items,
    );
  }

  String toJson() => json.encode(toMap());

  Map<String, dynamic> toMap() {
    return {
      'totalItems': totalItems,
      'items': items,
    };
  }

  @override
  String toString() =>
      'ListResponseDTO(totalItems: $totalItems, items: $items)';
}
