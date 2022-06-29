// To parse this JSON data, do
//
//     final orderResponse = orderResponseFromMap(jsonString);

import 'dart:convert';

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

class Order {
  Order({
    required this.oderItems,
    required this.subTotal,
    required this.totals,
    required this.amount,
    required this.preparing,
    required this.received,
    required this.ready,
    required this.delivered,
    required this.numberOfItems,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  final List<OderItem> oderItems;
  final List<int> subTotal;
  final int totals;
  final List<int> amount;
  final bool preparing;
  final bool received;
  final bool ready;
  final bool delivered;
  final int numberOfItems;
  final User user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        oderItems: List<OderItem>.from(
            json["oderItems"].map((x) => OderItem.fromMap(x))),
        subTotal: List<int>.from(json["subTotal"].map((x) => x)),
        totals: json["totals"],
        amount: List<int>.from(json["amount"].map((x) => x)),
        preparing: json["preparing"],
        received: json["received"],
        ready: json["ready"],
        delivered: json["delivered"],
        numberOfItems: json["numberOfItems"],
        user: User.fromMap(json["user"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "oderItems": List<dynamic>.from(oderItems.map((x) => x.toMap())),
        "subTotal": List<dynamic>.from(subTotal.map((x) => x)),
        "totals": totals,
        "amount": List<dynamic>.from(amount.map((x) => x)),
        "preparing": preparing,
        "received": received,
        "ready": ready,
        "delivered": delivered,
        "numberOfItems": numberOfItems,
        "user": user.toMap(),
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "id": id,
      };
}

class OderItem {
  OderItem({
    required this.title,
    required this.description,
    required this.img,
    required this.inStock,
    required this.price,
    required this.size,
  });

  final String title;
  final String description;
  final String img;
  final String inStock;
  final String price;
  final String size;

  factory OderItem.fromJson(String str) => OderItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OderItem.fromMap(Map<String, dynamic> json) => OderItem(
        title: json["title"],
        description: json["description"],
        img: json["img"],
        inStock: json["inStock"],
        price: json["price"],
        size: json["size"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "img": img,
        "inStock": inStock,
        "price": price,
        "size": size,
      };
}

class User {
  User({
    required this.id,
    required this.name,
  });

  final String id;
  final String name;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        id: json["_id"],
        name: json["name"],
      );

  Map<String, dynamic> toMap() => {
        "_id": id,
        "name": name,
      };
}
