import 'dart:convert';

class Order {
  Order({
    required this.preparing,
    required this.received,
    required this.ready,
    required this.delivered,
    required this.oderItems,
    required this.subTotal,
    required this.totals,
    required this.numberOfItems,
    // required this.product,
    required this.user,
    required this.createdAt,
    required this.updatedAt,
    required this.id,
  });

  final int preparing;
  final int received;
  final int ready;
  final int delivered;
  final List<OderItem> oderItems;
  final List<int> subTotal;
  final int totals;
  final int numberOfItems;
  // final List<Product> product;
  final User user;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String id;

  factory Order.fromJson(String str) => Order.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        preparing: json["preparing"],
        received: json["received"],
        ready: json["ready"],
        delivered: json["delivered"],
        oderItems: List<OderItem>.from(
            json["oderItems"].map((x) => OderItem.fromMap(x))),
        subTotal: List<int>.from(json["subTotal"].map((x) => x)),
        totals: json["totals"],
        numberOfItems: json["numberOfItems"],
        // product:
        //     List<Product>.from(json["product"].map((x) => Product.fromMap(x))),
        user: User.fromMap(json["user"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        id: json["id"],
      );

  Map<String, dynamic> toMap() => {
        "preparing": preparing,
        "received": received,
        "ready": ready,
        "delivered": delivered,
        "oderItems": List<dynamic>.from(oderItems.map((x) => x.toMap())),
        "subTotal": List<dynamic>.from(subTotal.map((x) => x)),
        "totals": totals,
        "numberOfItems": numberOfItems,
        // "product": List<dynamic>.from(product.map((x) => x.toMap())),
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
    required this.inStock,
    required this.price,
    required this.size,
  });

  final String title;
  final String description;
  final String inStock;
  final String price;
  final String size;

  factory OderItem.fromJson(String str) => OderItem.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory OderItem.fromMap(Map<String, dynamic> json) => OderItem(
        title: json["title"],
        description: json["description"],
        inStock: json["inStock"],
        price: json["price"],
        size: json["size"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "inStock": inStock,
        "price": price,
        "size": size,
      };
}

// class Product {
//   Product({
//     required this.id,
//     required this.title,
//   });

//   final String id;
//   final String title;

//   factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

//   String toJson() => json.encode(toMap());

//   factory Product.fromMap(Map<String, dynamic> json) => Product(
//         id: json["_id"],
//         title: json["title"],
//       );

//   Map<String, dynamic> toMap() => {
//         "_id": id,
//         "title": title,
//       };
// }

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
