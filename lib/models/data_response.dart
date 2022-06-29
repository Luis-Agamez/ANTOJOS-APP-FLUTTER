// To parse this JSON data, do
//
//     final dataResponse = dataResponseFromMap(jsonString);

import 'dart:convert';

import 'package:antojos_app/models/user.dart';

class DataResponse {
  DataResponse({
    required this.ok,
    required this.user,
    required this.msg,
  });

  final bool ok;
  final User user;
  final String msg;

  factory DataResponse.fromJson(String str) =>
      DataResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory DataResponse.fromMap(Map<String, dynamic> json) => DataResponse(
        ok: json["ok"],
        user: User.fromMap(json["user"]),
        msg: json["msg"],
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "user": user.toMap(),
        "msg": msg,
      };
}
