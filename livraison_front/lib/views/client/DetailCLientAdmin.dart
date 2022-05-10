import 'package:flutter/material.dart';
import 'package:livraison_front/constant/app_constants.dart';
import 'package:livraison_front/views/client/EditClient.dart';


import '../../models/client.dart';

import '../../models/livraison.dart';
import '../../services/clientService.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_responsable.dart';
import '../livraison/DetailLivraisonClient.dart';


class DetailClientAdmin extends StatefulWidget {
  DetailClientAdmin(this.client);

  final Client client;

  @override
  _DetailClientState createState() => _DetailClientState();
}

class _DetailClientState extends State<DetailClientAdmin> {
  _DetailClientState();

  final ClientService api = ClientService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ResponsableDrawer(context),
      appBar:  AppBar(
        title: Text("Detail Client"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: (){
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child :Column(
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
                              widget.client.nom.toString(),
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
                              widget.client.prenom.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Client telephone :',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.client.clientTel.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Client Adresse :',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.client.clientAdresse.toString(),
                            )
                          ],
                        ),
                      ),


                    ],
                  ))),
        ),
              Container(
                height: 1000,
                child: FutureBuilder(
                  future: LivraisonService().getListLivraisonByIdClient(widget.client.userId!.id.toString()),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    print('snapshot is : ${snapshot.data}');

                    if ((snapshot.hasData)) {
                      return ListView.builder(
                        itemBuilder: (context, index) {

                            return ListTile(
                              leading: new Image.network(
                                AppConstants.API_URL+"/"+snapshot.data![index]['imageUrl'],
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
                              //    title: Text(snapshot.data![index]['numLivraison'].toString()),
                              //    subtitle: Text(snapshot.data![index]['AdressseDes']),
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
                                    idLivreur: snapshot.data![index]['livreur']['_id'],
                                    imageUrl: snapshot.data![index]['imageUrl'],
                                    sId: snapshot.data![index]['_id']);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailLivraisonClient(livraison)));
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
      ));
  }
}