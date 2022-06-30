// To parse this JSON data, do
//
//     final trolleyResponse = trolleyResponseFromMap(jsonString);

import 'dart:convert';

class TrolleyResponse {
  TrolleyResponse({
    required this.ok,
    required this.response,
  });

  final bool ok;
  final List<Response> response;

  factory TrolleyResponse.fromJson(String str) =>
      TrolleyResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory TrolleyResponse.fromMap(Map<String, dynamic> json) => TrolleyResponse(
        ok: json["ok"],
        response: List<Response>.from(
            json["response"].map((x) => Response.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "response": List<dynamic>.from(response.map((x) => x.toMap())),
      };
}

class Response {
  Response({
    required this.id,
    required this.items,
    required this.total,
    required this.uid,
    required this.pid,
    required this.createdAt,
    required this.updatedAt,
  });

  final String id;
  final int items;
  final int total;
  final String uid;
  final Pid pid;
  final DateTime createdAt;
  final DateTime updatedAt;

  factory Response.fromJson(String str) => Response.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Response.fromMap(Map<String, dynamic> json) => Response(
        id: json["_id"],
        items: json["items"],
        total: json["total"],
        uid: json["uid"],
        pid: Pid.fromMap(json["pid"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "items": items,
        "total": total,
        "uid": uid,
        "pid": pid.toMap(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
      };
}

class Pid {
  Pid({
    required this.id,
    required this.title,
    required this.description,
    required this.images,
    required this.inStock,
    required this.price,
    required this.size,
    required this.slug,
    required this.tags,
    required this.favorite,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
    required this.mid,
  });

  final String id;
  final String title;
  final String description;
  final String images;
  final int inStock;
  final int price;
  final List<String> size;
  final String slug;
  final List<String> tags;
  final String favorite;
  final String user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;
  final bool mid;

  factory Pid.fromJson(String str) => Pid.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Pid.fromMap(Map<String, dynamic> json) => Pid(
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        images: json["images"],
        inStock: json["inStock"],
        price: json["price"],
        size: List<String>.from(json["size"].map((x) => x)),
        slug: json["slug"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        favorite: json["favorite"],
        user: json["user"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        mid: json["mid"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "title": title,
        "description": description,
        "images": images,
        "inStock": inStock,
        "price": price,
        "size": List<dynamic>.from(size.map((x) => x)),
        "slug": slug,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "favorite": favorite,
        "user": user,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "mid": mid,
      };
}
