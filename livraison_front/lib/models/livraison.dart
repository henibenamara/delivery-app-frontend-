class Livraison {
  int? numLivraison;
  String? adressseDes;
  String? adresseExp;
  String? dateDeLivraison;
  String? typeColis;
  String? DesColis;
  int? poidsColis;
  String? etatLivraison;
  String? sId;
  int? iV;
  String? idClient;
  String? idLivreur;

  Livraison(
      {this.numLivraison,
        this.adressseDes,
        this.adresseExp,
        this.dateDeLivraison,
        this.typeColis,
        this.DesColis,
        this.poidsColis,
        this.sId,
        this.iV,
        this.etatLivraison,
        this.idClient,
      this.idLivreur});

  Livraison.fromJson(Map<String, dynamic> json) {
    numLivraison = json['numLivraison'];
    adressseDes = json['AdressseDes'];
    adresseExp = json['AdresseExp'];
    dateDeLivraison = json['DateDeLivraison'];
    typeColis = json['typeColis'];
    DesColis = json['DesColis'];
    poidsColis = json['poidsColis'];
    etatLivraison=json['etatLivraison'];
    sId = json['_id'];
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['numLivraison'] = this.numLivraison;
    data['AdressseDes'] = this.adressseDes;
    data['AdresseExp'] = this.adresseExp;
    data['DateDeLivraison'] = this.dateDeLivraison;
    data['typeColis'] = this.typeColis;
    data['DesColis'] = this.DesColis;
    data['poidsColis'] = this.poidsColis;
    data['etatLivraison']=this.etatLivraison;
    data['client'] = this.idClient;
    data['livreur'] = this.idLivreur;
    data['__v'] = this.iV;
    return data;
  }

  @override
  String toString() {
    return 'Livraison{numLivraison: $numLivraison, adressseDes: $adressseDes, adresseExp: $adresseExp, dateDeLivraison: $dateDeLivraison, typeColis: $typeColis, DesColis: $DesColis, poidsColis: $poidsColis, etatLivraison: $etatLivraison, sId: $sId, iV: $iV, idClient: $idClient, idLivreur: $idLivreur}';
  }
}