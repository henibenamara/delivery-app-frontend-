import 'package:flutter/material.dart';
import 'package:livraison_front/views/client/EditClient.dart';


import '../../models/client.dart';

import '../../models/livraison.dart';
import '../../models/livreur.dart';
import '../../services/LivreurService.dart';
import '../../services/clientService.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_responsable.dart';
import '../livraison/DetailLivraisonLivreur.dart';


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
              Expanded(

                child: FutureBuilder(
                  future: LivraisonService().getListLivraisonByIdLivreur(widget.livreur.userId!.id.toString()),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    print('snapshot is : ${snapshot.data}');

                    if ((snapshot.hasData)) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                            leading: new Image.asset(
                              "assets/images/col.jpg",
                              fit: BoxFit.cover,
                              width: 100.0,
                            ),

                            title: new Text(
                              "De  " +
                                  snapshot.data![index]['AdresseExp'] +
                                  " vers  " +
                                  snapshot.data![index]['AdressseDes'],
                              style: new TextStyle(
                                  fontSize: 14.0, fontWeight: FontWeight.bold),
                            ),
                            subtitle: new Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  new Text(
                                      "Num:" +
                                          snapshot.data![index]['numLivraison']
                                              .toString(),
                                      style: new TextStyle(
                                          fontSize: 14.0, fontWeight: FontWeight.normal)),
                                  new Text(
                                      'Description: ${snapshot.data![index]['colisId']['DesColis']}',
                                      style: new TextStyle(
                                          fontSize: 14.0, fontWeight: FontWeight.normal)),
                                ]),

                            onTap: () {
                              Livraison livraison = new Livraison(
                                  adresseExp: snapshot.data![index]['AdresseExp'],
                                  adressseDes: snapshot.data![index]['AdressseDes'],
                                  dateDeLivraison: snapshot.data![index]
                                  ['DateDeLivraison'],
                                  DesColis: snapshot.data![index]['colisId']['DesColis'],
                                  numLivraison: snapshot.data![index]['numLivraison'],
                                  typeColis: snapshot.data![index]['colisId']
                                  ['typeColis'],
                                  poidsColis: snapshot.data![index]['colisId']
                                  ['poidsColis'],
                                  etatLivraison: snapshot.data![index]['etatLivraison'],
                                  sId: snapshot.data![index]['_id']);
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailLivraisonLivreur(livraison)));
                            },
                          );
                        },
                        itemCount: snapshot.data?.length,
                      );
                    } else {
                      return Center(
                        child: Text('data is null'),
                      );
                    }
                  },
                ),
              ),


      ]),
      );
  }
}