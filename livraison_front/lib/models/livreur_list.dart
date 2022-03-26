import 'dart:convert';
List<LivreurList> LivreurListFromJson(String str) => List<LivreurList>.from(json.decode(str).map((x) => LivreurList.fromJson(x)));

String LivreurListToJson(List<LivreurList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LivreurList {


  LivreurList({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.userId,
    required this.livTelephone,
    required this.livAdresse,
    required this.livMatVecu,
    required this.livMarqVecu,
    required this.v,

  });
  late final String id;
  late final String nom;
  late final String prenom;
  late final String userId;
  late final String livTelephone;
  late final String livAdresse;
  late final String livMatVecu;
  late final String livMarqVecu;


  late final String v;



  LivreurList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nom = json['prenom'];
    prenom = json['prenom'];
    userId = json['userId'];
    livTelephone = json['livTelephone'];
    livAdresse = json['livAdresse'];
    livMatVecu = json['livMatVecu'];
    livMarqVecu = json['livMarqVecu'];
    v = json['v'];


  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nom'] = nom;
    _data['prenom'] = prenom;
    _data['userId'] = userId;
    _data['livTelephone'] = livTelephone;
    _data['livAdresse'] = livAdresse;
    _data['livMatVecu'] = livMatVecu;
    _data['livMarqVecu'] = livMarqVecu;
    _data['v'] = v;
    return _data;
  }
}