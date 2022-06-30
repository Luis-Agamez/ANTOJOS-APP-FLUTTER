import 'dart:convert';

class Product {
  Product({
    required this.title,
    required this.description,
    required this.images,
    required this.inStock,
    required this.price,
    required this.mid,
    required this.size,
    required this.slug,
    required this.tags,
    required this.idFavorite,
    required this.id,
  });

  final String title;
  final String description;
  final String images;
  final String inStock;
  final int price;
  final bool mid;
  final List<String> size;
  final String slug;
  final List<String> tags;
  final String idFavorite;
  final String id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        title: json["title"],
        description: json["description"],
        images: json["images"],
        inStock: json["inStock"].toString(),
        price: json["price"],
        mid: json["mid"],
        size: List<String>.from(json["size"].map((x) => x)),
        slug: json["slug"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        idFavorite: json['favorite'],
        id: json["_id"],
      );

  Map<String, dynamic> toMap() => {
        "title": title,
        "description": description,
        "images": images,
        "inStock": inStock,
        "price": price,
        "size": List<dynamic>.from(size.map((x) => x)),
        "slug": slug,
        "tags": List<dynamic>.from(tags.map((x) => x)),
        "idFavorite": idFavorite,
        "id": id,
        "mid": mid
      };
}
