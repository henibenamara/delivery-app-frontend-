// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

import 'dart:ffi';

utilisateur welcomeFromJson(String str) => utilisateur.fromJson(json.decode(str));

String welcomeToJson(utilisateur data) => json.encode(data.toJson());

class utilisateur {
  utilisateur({
    required this.token,
    required this.user,
  });

  String token;
  User user;

  factory utilisateur.fromJson(Map<String, dynamic> json) => utilisateur(
    token: json["token"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "token": token,
    "user": user.toJson(),
  };

  @override
  String toString() {
    return 'utilisateur{token: $token, user: $user}';
  }
}

class User {
  User({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
     this.etatCompte,
    required this.v,
  });

  String id;
  String email;
  String password;
  String role;
  String? etatCompte  ;
  int v;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["_id"],
    email: json["email"],
    password: json["password"],
    role: json["role"],
    etatCompte: json["etatCompte"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "password": password,
    "role": role,
    "etatCompte":etatCompte,
    "__v": v,
  };

  @override
  String toString() {
    return 'User{id: $id, email: $email, password: $password, role: $role,etatCompte: $etatCompte, v: $v}';
  }
}
