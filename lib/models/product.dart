import 'dart:convert';

class Product {
  Product({
    required this.title,
    required this.description,
    this.images,
    required this.inStock,
    required this.price,
    required this.size,
    required this.slug,
    required this.tags,
    required this.id,
  });

  final String title;
  final String description;
  final String? images;
  final int inStock;
  final int price;
  final List<String> size;
  final String slug;
  final List<String> tags;
  final String id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        title: json["title"],
        description: json["description"],
        images: json["images"],
        inStock: json["inStock"],
        price: json["price"],
        size: List<String>.from(json["size"].map((x) => x)),
        slug: json["slug"],
        tags: List<String>.from(json["tags"].map((x) => x)),
        id: json["id"],
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
        "id": id,
      };
}
