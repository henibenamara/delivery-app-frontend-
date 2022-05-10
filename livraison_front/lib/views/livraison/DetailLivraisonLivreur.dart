import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/services/livreurService.dart';

import '../../constant/app_constants.dart';
import '../../models/livraison.dart';

import '../../models/client.dart';
import '../../services/clientService.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_livreur.dart';
import '../../widgets/drawer_responsable.dart';
import '../client/DetailClient.dart';

class DetailLivraisonLivreur extends StatefulWidget {
  DetailLivraisonLivreur(this.livraison);

  final Livraison livraison;

  @override
  _DetailLivraisonLivreurState createState() => _DetailLivraisonLivreurState();
}

class _DetailLivraisonLivreurState extends State<DetailLivraisonLivreur> {
  _DetailLivraisonLivreurState();

  final LivraisonService api = LivraisonService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: livreurDrawer(context),
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
                    height: 250.0,
                    width: 250.0,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image:NetworkImage(
                            AppConstants.API_URL+"/"+widget.livraison.imageUrl.toString()
                        ),
                        fit: BoxFit.fill,
                      ),
                      shape: BoxShape.rectangle,
                    ),
                  ),
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
                  Container(
                    margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                    child: Column(
                      children: <Widget>[
                        Text('Poids :',
                            style: TextStyle(
                                color: Colors.black.withOpacity(0.8))),
                        Text(widget.livraison.prix.toString() + " DT")
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
            child: FutureBuilder(
              future:
                  ClientService().getClientByIdUSer(widget.livraison.idClient),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                if ((snapshot.hasData)) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("nom de Client :"),
                        //subtitle: Text(snapshot.data![index]['prenom']),
                        trailing: Text(snapshot.data![index]['nom'].toString()),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                AppConstants.API_URL+"/"+snapshot.data![index]['image']
                            ),
                        ),
                        onTap: () {
                          UserId user = new UserId(
                              id: snapshot.data![index]['userId']['_id'],
                              email: snapshot.data![index]['userId']['email'],
                              password: snapshot.data![index]['userId']
                                  ['password'],
                              role: snapshot.data![index]['userId']['role'],
                              v: snapshot.data![index]['userId']['__v']);
                          Client client = new Client(
                            nom: snapshot.data![index]['nom'],
                            prenom: snapshot.data![index]['prenom'],
                            clientTel: snapshot.data![index]['clientTel'],
                            clientAdresse: snapshot.data![index]
                                ['clientAdresse'],
                            v: snapshot.data![index]['__v'],
                            id: snapshot.data![index]['_id'],
                            userId: user,
                          );
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DetailClient(client)));
                        },
                      );
                    },
                    itemCount: snapshot.data?.length,
                  );
                } else {
                  return Center(
                    child: Text(''),
                  );
                }
              },
            ),
          ),
        ]));
  }
}
