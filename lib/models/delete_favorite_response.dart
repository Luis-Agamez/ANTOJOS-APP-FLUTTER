// To parse this JSON data, do
//
//     final deleteFavoritesResponse = deleteFavoritesResponseFromMap(jsonString);

import 'dart:convert';

class DeleteFavoritesResponse {
  DeleteFavoritesResponse({
    required this.ok,
    this.message,
  });

  final bool ok;
  final String? message;

  factory DeleteFavoritesResponse.fromJson(String str) =>
      DeleteFavoritesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DeleteFavoritesResponse.fromMap(Map<String, dynamic> json) =>
      DeleteFavoritesResponse(
        ok: json["ok"],
        message: json["message"],
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "message": message,
      };
}
