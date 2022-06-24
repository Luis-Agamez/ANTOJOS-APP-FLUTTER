// To parse this JSON data, do
//
//     final favoritesResponse = favoritesResponseFromMap(jsonString);

import 'dart:convert';

import 'package:antojos_app/models/product.dart';

class FavoritesResponse {
  FavoritesResponse({
    required this.ok,
    required this.products,
  });

  final bool ok;
  final List<Product> products;

  factory FavoritesResponse.fromJson(String str) =>
      FavoritesResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory FavoritesResponse.fromMap(Map<String, dynamic> json) =>
      FavoritesResponse(
        ok: json["ok"],
        products:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}
