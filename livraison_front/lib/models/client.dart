// To parse this JSON data, do
//
//     final Client = ClientFromJson(jsonString);

import 'dart:convert';

Client ClientFromJson(String str) => Client.fromJson(json.decode(str));

String ClientToJson(Client data) => json.encode(data.toJson());

class Client {
  Client({
    required this.id,
    required this.nom,
    required this.prenom,
     this.userId,
    required this.clientTel,
    required this.clientAdresse,

    required this.v,
    this.imageUrl
  });

  String id;
  String nom;
  String prenom;
  UserId? userId;
  int clientTel;
  String clientAdresse;
  int v;
  String? imageUrl;

  factory Client.fromJson(Map<String, dynamic> json) => Client(
    id: json["_id"],
    nom: json["nom"],
    prenom: json["prenom"],
    userId: UserId.fromJson(json["userId"]),
    clientTel: json["clientTel"],
    clientAdresse: json["clientAdresse"],
    v: json["__v"],
    imageUrl :json['image'],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nom": nom,
    "prenom": prenom,
    "userId": userId?.toJson(),
    "clientTel": clientTel,
    "clientAdresse": clientAdresse,
    "__v": v,
    "image" : imageUrl
  };
}

class UserId {
  UserId({
    required this.id,
    required this.email,
    required this.password,
    required this.role,
    required this.v,
  });

  String id;
  String email;
  String password;
  String role;
  int v;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
    id: json["_id"],
    email: json["email"],
    password: json["password"],
    role: json["role"],
    v: json["__v"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "email": email,
    "password": password,
    "role": role,
    "__v": v,
  };
}
