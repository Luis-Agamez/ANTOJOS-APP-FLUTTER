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

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    required this.name,
    required this.email,
    required this.online,
    required this.uid,
  });

  String name;
  String email;
  bool online;
  String uid;

  factory User.fromJson(Map<String, dynamic> json) => User(
        name: json["name"],
        email: json["email"],
        online: json["online"],
        uid: json["uid"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "email": email,
        "online": online,
        "uid": uid,
      };
}
