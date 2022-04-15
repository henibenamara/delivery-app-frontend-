import 'dart:convert';

Livreur livreurFromJson(String str) => Livreur.fromJson(json.decode(str));

String livreurToJson(Livreur data) => json.encode(data.toJson());

class Livreur {
  Livreur({
    required this.id,
    required this.nom,
    required this.prenom,
     this.userId,
    required this.livcin,
    required this.livTelephone,
    required this.livAdresse,
    required this.livMatVecu,
    required this.livMarqVecu,
    required this.v,
    this.imageUrl,
  });

  String id;
  String nom;
  String prenom;
  UserId? userId;
  int livcin;
  int livTelephone;
  String livAdresse;
  String livMatVecu;
  String livMarqVecu;
  int v;
  String? imageUrl;

  factory Livreur.fromJson(Map<String, dynamic> json) => Livreur(
    id: json["_id"],
    nom: json["nom"],
    prenom: json["prenom"],
    userId: UserId.fromJson(json["userId"]),
    livcin: json["livcin"],
    livTelephone: json["livTelephone"],
    livAdresse: json["livAdresse"],
    livMatVecu: json["livMatVecu"],
    livMarqVecu: json["livMarqVecu"],
    v: json["__v"],
    imageUrl :json['image'],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "nom": nom,
    "prenom": prenom,
    "userId": userId?.toJson(),
    "livcin": livcin,
    "livTelephone": livTelephone,
    "livAdresse": livAdresse,
    "livMatVecu": livMatVecu,
    "livMarqVecu": livMarqVecu,
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
