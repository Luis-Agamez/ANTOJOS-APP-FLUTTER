// To parse this JSON data, do
//
//     final productResponse = productResponseFromMap(jsonString);

import 'dart:convert';

import 'package:antojos_app/models/product.dart';

class ProductResponse {
  ProductResponse({
    required this.ok,
    required this.products,
  });

  final bool ok;
  final List<Product> products;

  factory ProductResponse.fromJson(String str) =>
      ProductResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory ProductResponse.fromMap(Map<String, dynamic> json) => ProductResponse(
        ok: json["ok"],
        products:
            List<Product>.from(json["products"].map((x) => Product.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "products": List<dynamic>.from(products.map((x) => x.toMap())),
      };
}
