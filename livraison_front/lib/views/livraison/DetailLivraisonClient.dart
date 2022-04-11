import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/services/livreurService.dart';

import '../../models/livraison.dart';

import '../../models/client.dart';
import '../../services/clientService.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_responsable.dart';
import '../client/DetailClient.dart';
import '../client/EditClient.dart';

class DetailLivraisonClient extends StatefulWidget {
  DetailLivraisonClient(this.livraison);

  final Livraison livraison;

  @override
  _DetailLivraisonClientState createState() => _DetailLivraisonClientState();
}

class _DetailLivraisonClientState extends State<DetailLivraisonClient> {
  _DetailLivraisonClientState();

  final LivraisonService api = LivraisonService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: ResponsableDrawer(context),
        appBar: AppBar(
          title: Text("Detail livraison"),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Column(children: <Widget>[
          Card(
            child: Container(
                padding: EdgeInsets.all(10.0),
                width: 600,
                child: Column(children: <Widget>[
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Numéro livraison:',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(
                          widget.livraison.numLivraison.toString(),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Adresse Expéditeur:',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(
                          widget.livraison.adresseExp.toString(),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Adresse Destinataire :',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(
                          widget.livraison.adressseDes.toString(),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Date De Livraison :',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(
                          widget.livraison.dateDeLivraison.toString(),
                        )
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Description :',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(widget.livraison.DesColis.toString())
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Poids :',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(widget.livraison.poidsColis.toString() + " Kg")
                      ],
                    ),
                  ),
                ])),
            shadowColor: Colors.blueAccent,
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            color: Colors.white,
            elevation: 30,
          ),
          RaisedButton( child: Text('modifier livraison'),
            onPressed: (){

            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                    EditDataWidget()));;

    }),



        ]));
  }
}
