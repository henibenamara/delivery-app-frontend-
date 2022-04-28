import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/constant/app_constants.dart';
import 'package:livraison_front/services/livreurService.dart';

import '../../models/livraison.dart';


import '../../models/livreur.dart';
import '../../services/clientService.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_responsable.dart';
import '../client/DetailClient.dart';
import '../client/EditClient.dart';
import '../livreur/DetailLivreur.dart';
import 'EditLivraisont.dart';

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

          Container(
              height: 50,

              child : FutureBuilder(

                future: LivreurService()
                    .getLivreurByIdUSer(
                    widget.livraison.idLivreur.toString()),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  print('snapshot12 is: ${snapshot.data}');

                  print('id livreuur is: ${widget.livraison.idLivreur.toString()}');

                  if ((snapshot.hasData)) {
                    return ListView.builder(
                      itemBuilder: (context, index) {
                        return ListTile(
                            title: Text(
                                "nom Livreur :"),

                            trailing: Text(snapshot.data![index]['nom']),
                            leading: CircleAvatar(
                                backgroundImage: NetworkImage(
                                    AppConstants.API_URL+"/"+snapshot.data![index]['image'])),
                            onTap: () {
                              UserId user = new UserId(
                                  id: snapshot.data![index]['userId']['_id'],
                                  email: snapshot.data![index]['userId']
                                  ['email'],
                                  password: snapshot.data![index]['userId']
                                  ['password'],
                                  role: snapshot
                                      .data![index]['userId']['role'],
                                  v: snapshot.data![index]['userId']['__v']);
                             Livreur livreur = new Livreur(
                                nom: snapshot.data![index]['nom'],
                                prenom: snapshot.data![index]['prenom'],
                                livcin: snapshot.data![index]['livcin'],
                                livTelephone: snapshot.data![index]
                                ['livTelephone'],
                                livAdresse: snapshot
                                    .data![index]['livAdresse'],
                                livMatVecu: snapshot
                                    .data![index]['livMatVecu'],
                                livMarqVecu: snapshot.data![index]
                                ['livMarqVecu'],
                                v: snapshot.data![index]['__v'],
                                id: snapshot.data![index]['_id'],
                                userId: user,
                              );
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailLivreur(livreur)));
                            });
                      },
                      itemCount: 1,
                    );
                  } else {
                    return Center(
                      child: Text('data is null'),
                    );
                  }
                },
              )
          ),



        ]));
  }
}
