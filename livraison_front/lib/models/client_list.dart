import 'dart:convert';
List<ClientList> ClientListFromJson(String str) => List<ClientList>.from(json.decode(str).map((x) => ClientList.fromJson(x)));

String ClientListToJson(List<ClientList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ClientList {


  ClientList({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.userId,
    required this.clientTel,
    required this.clientAdresse,
    required this.v,

  });
  late final String id;
  late final String nom;
  late final String prenom;
  late final String userId;
  late final String clientTel;
  late final String clientAdresse;
  late final String v;



  ClientList.fromJson(Map<String, dynamic> json){
    id = json['id'];
    nom = json['prenom'];
    prenom = json['prenom'];
    userId = json['userId'];
    clientTel = json['clientTel'];
    clientAdresse = json['clientAdresse'];
    v = json['v'];


  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['nom'] = nom;
    _data['prenom'] = prenom;
    _data['userId'] = userId;
    _data['clientTel'] = clientTel;
    _data['clientAdresse'] = clientAdresse;
    _data['v'] = v;
    return _data;
  }
}