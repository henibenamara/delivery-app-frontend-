import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/services/livreurService.dart';

import '../../constant/app_constants.dart';
import '../../models/livraison.dart';
import '../../models/livreur.dart' as liv;
import '../../models/client.dart' as cli;
import '../../services/clientService.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_responsable.dart';
import '../client/DetailClient.dart';
import '../livreur/DetailLivreur.dart';
import 'EditLivraisont.dart';

class DetailLivraisonAdmin extends StatefulWidget {
  DetailLivraisonAdmin(this.livraison);

  final Livraison livraison;

  @override
  _DetailLivraisonAdminState createState() => _DetailLivraisonAdminState();
}

class _DetailLivraisonAdminState extends State<DetailLivraisonAdmin> {
  _DetailLivraisonAdminState();

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
                  ]))),

          Container(
            height: 50,
            child: FutureBuilder(
              future:
                  ClientService().getClientByIdUSer(widget.livraison.idClient),
              builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                print('snapshot is : ${snapshot.data}');

                if ((snapshot.hasData)) {
                  return ListView.builder(
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text("nom de Client :"),
                        //subtitle: Text(snapshot.data![index]['prenom']),
                        trailing: Text(snapshot.data![index]['nom'].toString()),
                        leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                                AppConstants.API_URL+"/"+ snapshot.data![index]['image'])),
                        onTap: () {
                          cli.UserId user = new cli.UserId(
                              id: snapshot.data![index]['userId']['_id'],
                              email: snapshot.data![index]['userId']['email'],
                              password: snapshot.data![index]['userId']
                                  ['password'],
                              role: snapshot.data![index]['userId']['role'],
                              v: snapshot.data![index]['userId']['__v']);
                          cli.Client client = new cli.Client(
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

          if(widget.livraison.idLivreur.toString()!="non")

            Container(
height: 50,

            child : FutureBuilder(

                  future: LivreurService()
                      .getLivreurByIdUSer(
                      widget.livraison.idLivreur.toString()),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    print('snapshot12 is: ${snapshot.data}');

                    if ((snapshot.hasData)) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          return ListTile(
                              title: Text(
                                  "nom Livreur :"),
                              //snapshot.data![index]['nom'].toString()
                              //subtitle: Text(snapshot.data![index]['nom']),
                              trailing: Text(snapshot.data![index]['nom']),
                              leading: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      AppConstants.API_URL+"/"+ snapshot.data![index]['image'])),
                              onTap: () {
                                liv.UserId user = new liv.UserId(
                                    id: snapshot.data![index]['userId']['_id'],
                                    email: snapshot.data![index]['userId']
                                    ['email'],
                                    password: snapshot.data![index]['userId']
                                    ['password'],
                                    role: snapshot
                                        .data![index]['userId']['role'],
                                    v: snapshot.data![index]['userId']['__v']);
                                liv.Livreur livreur = new liv.Livreur(
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
