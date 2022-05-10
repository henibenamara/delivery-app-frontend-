class Offer {

  String? sId;
  int? iV;
  String? livreur;
  String? livraison;

  String? prix;


  Offer(
      {
        this.sId,
        this.iV,

        this.livreur,
        this.livraison,
        this.prix
      });

  Offer.fromJson(Map<String, dynamic> json) {

    sId = json['_id'];
    iV = json['__v'];
    prix = json['prix'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['livreur'] = this.livreur;
    data['livraison'] = this.livraison;

    data['__v'] = this.iV;
    data['prix'] = this.prix;


    return data;
  }

  @override
  String toString() {
    return 'Offer{  sId: $sId, iV: $iV, livreur: $livreur, livraison: $livraison}';
  }
}