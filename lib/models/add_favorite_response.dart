// To parse this JSON data, do
//
//     final addFavoritesResponse = addFavoritesResponseFromMap(jsonString);

import 'dart:convert';

class AddFavoritesResponse {
  AddFavoritesResponse({
    required this.ok,
    required this.msg,
  });

  final bool ok;
  final String msg;

  factory AddFavoritesResponse.fromJson(String str) =>
      AddFavoritesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory AddFavoritesResponse.fromMap(Map<String, dynamic> json) =>
      AddFavoritesResponse(
        ok: json["ok"],
        msg: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "msg": msg,
      };
}
