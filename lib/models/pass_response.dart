// To parse this JSON data, do
//
//     final passResponse = passResponseFromMap(jsonString);

import 'dart:convert';

class PassResponse {
  PassResponse({
    required this.ok,
    this.msg,
  });

  final bool ok;
  final String? msg;

  factory PassResponse.fromJson(String str) =>
      PassResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory PassResponse.fromMap(Map<String, dynamic> json) => PassResponse(
        ok: json["ok"],
        msg: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "msg": msg,
      };
}
