import 'package:flutter/material.dart';
import 'package:livraison_front/views/client/EditClient.dart';


import '../../models/client.dart';

import '../../models/livreur.dart';
import '../../services/LivreurService.dart';
import '../../services/clientService.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_responsable.dart';


class DetailLivreur extends StatefulWidget {
  DetailLivreur(this.livreur);

  final Livreur livreur;

  @override
  _DetailLivreurState createState() => _DetailLivreurState();
}

class _DetailLivreurState extends State<DetailLivreur> {
  _DetailLivreurState();

  final LivreurService api = LivreurService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ResponsableDrawer(context),
      appBar: AppBar(
        title: Text('Detail Livreur'),
      ),
      body: SingleChildScrollView(
        child: Container(
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
      ),
    );
  }
}