import 'dart:convert';
List<LivraisonList> LivraisonListFromJson(String str) => List<LivraisonList>.from(json.decode(str).map((x) => LivraisonList.fromJson(x)));

String LivraisonListToJson(List<LivraisonList> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LivraisonList {
  LivraisonList({
    required this.numLivraison,
    required this.adressseDes,
    required this.adresseExp,
    required this.dateDeLivraison,
    required this.typeColis,
    required this.DesColis,
    required this.poidsColis,
    required this.etatLivraison,

    required this.sId,

  });
  late final String numLivraison;
  late final String adressseDes;
  late final String adresseExp;
  late final String dateDeLivraison;
  late final String typeColis;
  late final String DesColis;
  late final String poidsColis;
  late final String etatLivraison;
  late final String sId;


  LivraisonList.fromJson(Map<String, dynamic> json){
    numLivraison = json['numLivraison'];
    adressseDes = json['adressseDes'];
    adresseExp = json['adresseExp'];
    dateDeLivraison = json['dateDeLivraison'];
    typeColis = json['typeColis'];
    DesColis = json['DesColis'];
    poidsColis = json['poidsColis'];
    etatLivraison = json['etatLivraison'];
    sId = json['_id'];

  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['numLivraison'] = numLivraison;
    _data['adressseDes'] = adressseDes;
    _data['adresseExp'] = adresseExp;
    _data['dateDeLivraison'] = dateDeLivraison;
    _data['typeColis'] = typeColis;
    _data['DesColis'] = DesColis;
    _data['poidsColis'] = poidsColis;
    _data['etatLivraison'] = etatLivraison;

    _data['_id'] = sId;

    return _data;
  }
}