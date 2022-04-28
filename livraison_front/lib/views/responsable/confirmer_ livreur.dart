import 'package:flutter/material.dart';
import 'package:livraison_front/views/client/EditClient.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';


import '../../models/client.dart';

import '../../models/livraison.dart';
import '../../models/livreur.dart';
import '../../services/LivreurService.dart';
import '../../services/clientService.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_responsable.dart';
import '../livraison/DetailLivraisonLivreur.dart';
import '../livreur.dart';
import '../resp.dart';


class verifLivreur extends StatefulWidget {
  verifLivreur(this.livreur);

  final Livreur livreur;

  @override
  _DetailLivreurState createState() => _DetailLivreurState();
}

class _DetailLivreurState extends State<verifLivreur> {
  _DetailLivreurState();

  final LivreurService api = LivreurService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ResponsableDrawer(context),
      appBar: AppBar(
        title: Text("Detail Livreur"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(20.0),
              child: Card(
                  child: Container(
                      padding: EdgeInsets.all(10.0),
                      width: 440,
                      child: Column(
                        children: <Widget>[
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Text('Nom :',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.8))),
                                Text(
                                  widget.livreur.nom.toString(),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Text('Prenom :',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.8))),
                                Text(
                                  widget.livreur.prenom.toString(),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Text('Cin :',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.8))),
                                Text(
                                  widget.livreur.livcin.toString(),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Text('Adresse :',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.8))),
                                Text(
                                  widget.livreur.livAdresse.toString(),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Text('Marque Voiture:',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.8))),
                                Text(
                                  widget.livreur.livMarqVecu.toString(),
                                )
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                            child: Column(
                              children: <Widget>[
                                Text('Matricule Voiture:',
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.8))),
                                Text(
                                  widget.livreur.livMatVecu.toString(),
                                )
                              ],
                            ),
                          ),




                        ],
                      ))),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OutlineButton(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  onPressed: () {},
                  child: Text("refuser",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.black)),
                ),
                RaisedButton(
                  onPressed: () {



                    ClientService api = ClientService();
                    api.verifCompte(
                        widget.livreur.id,
                      "true"

                       );
                    showTopSnackBar(
                      context,
                      CustomSnackBar.success(
                        message:
                        "Ce Compte est approver avec succée",
                      ),
                    );

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => responsable()));
                  },
                  color: Colors.green,
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Text(
                    "Accepter",
                    style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white),
                  ),
                )
              ],
            )


          ]),
    );
  }
}