// class User {
//   final String name;
//   final String uid;

//   User({required this.name, required this.uid});

//   User copyWith({String? name, String? uid}) =>
//       User(name: name ?? this.name, uid: uid ?? this.uid);
// }

// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

class User {
  User({
    required this.name,
    this.lastName,
    required this.email,
    this.address,
    this.phoneNumber,
    required this.uid,
  });

  final String name;
  final String? lastName;
  final String email;
  final String? address;
  final String? phoneNumber;
  final String uid;

  factory User.fromJson(String str) => User.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory User.fromMap(Map<String, dynamic> json) => User(
        name: json["name"],
        lastName: json["lastName"],
        email: json["email"],
        address: json["address"],
        phoneNumber: json["phoneNumber"],
        uid: json["uid"],
      );

  Map<String, dynamic> toMap() => {
        "name": name,
        "lastName": lastName,
        "email": email,
        "address": address,
        "phoneNumber": phoneNumber,
        "uid": uid,
      };
}
