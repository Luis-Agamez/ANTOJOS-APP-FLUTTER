// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromMap(jsonString);

import 'dart:convert';

import 'package:antojos_app/models/order.dart';

class OrderResponse {
  OrderResponse({
    required this.ok,
    required this.orders,
  });

  final bool ok;
  final List<Order> orders;

  factory OrderResponse.fromJson(String str) =>
      OrderResponse.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OrderResponse.fromMap(Map<String, dynamic> json) => OrderResponse(
        ok: json["ok"],
        orders: List<Order>.from(json["orders"].map((x) => Order.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "ok": ok,
        "orders": List<dynamic>.from(orders.map((x) => x.toMap())),
      };
}
