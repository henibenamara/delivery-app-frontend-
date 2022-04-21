import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/views/livraison/DetailLivraisonClient_edit.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/message_constants.dart';
import '../../models/livraison.dart';
import '../../models/livraison_list.dart';
import '../../services/livraisonService.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_client.dart';
import '../../widgets/drawer_responsable.dart';
import 'DetailLivraiosnAdmin.dart';
import 'DetailLivraisonClient.dart';
import 'DetailLivraisonLivreur.dart';

class DemandeClient extends StatefulWidget {
  const DemandeClient({Key? key}) : super(key: key);

  @override
  _DemandeClientState createState() => _DemandeClientState();
}

class _DemandeClientState extends State<DemandeClient> {
  List<dynamic> _livraisonList = [];
  String _id = "";

  String? etat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('List Livraison'),
        ),
        drawer: clientDrawer(context),
        body: Column(
            children: <Widget>[

              Expanded(
                  child: FutureBuilder(
                      future: LivraisonService().getLivraisonByIdClient(),
                      builder: (context,
                          AsyncSnapshot<List<dynamic>> snapshot) {
                        if ((snapshot.hasData)) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  buildCard(context, index));
                        } else {
                          return const Center(
                              child: Text(
                                  "", style: TextStyle(fontSize: 1))); // Center

                        }
                      }))
            ]));
  }
  Future<String?> getidClient() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    print('userId is : $userId');
    return userId;
  }

  Widget buildCard(BuildContext context, int index) {
    return FutureBuilder(
        future: LivraisonService().getLivraisonByIdClient(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
            if ((snapshot.data![index]['etatLivraison'].toString() ==
                "non livrée")) {
              _id=snapshot.data![index]['_id'];
              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                        child: Row(children: <Widget>[
                          Text(
                            "Colis : " +
                                snapshot
                                    .data![index]['colisId']['DesColis'] //(snapshot.data![index]['etatLivraison'].toString()=="en cours")
                                    .toString(),
                            style: const TextStyle(
                                fontSize: 22.0, color: Colors.white),
                          ),
                          const Spacer(),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 30.0),
                        child: Row(children: <Widget>[
                          Text(
                              "${"De " + snapshot.data![index]['AdresseExp']
                                  .toString()} ",
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.white)),

                          Text("    vers    ",
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.white)),

                          Text(

                              "${snapshot.data![index]['AdressseDes']
                                  .toString()}",
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                          const Spacer(),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "numero :${snapshot
                                  .data![index]['numLivraison']}",
                              style: const TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                            const Spacer(),
                            Text(
                              "Poid :${snapshot
                                  .data![index]['colisId']['poidsColis']} Kg   ",
                              style: const TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),


                            FloatingActionButton(
                              heroTag: "aa",
                              onPressed: () {
                                Livraison livraisonA;

                                livraisonA = new Livraison(
                                  adresseExp: snapshot
                                      .data![index]['AdresseExp'],
                                  adressseDes: snapshot
                                      .data![index]['AdressseDes'],
                                  dateDeLivraison: snapshot
                                      .data![index]['DateDeLivraison'],
                                  DesColis: snapshot
                                      .data![index]['colisId']['DesColis'],
                                  numLivraison: snapshot
                                      .data![index]['numLivraison'],
                                  typeColis: snapshot
                                      .data![index]['colisId']['typeColis'],
                                  poidsColis: snapshot
                                      .data![index]['colisId']['poidsColis'],
                                  etatLivraison: snapshot
                                      .data![index]['etatLivraison'],
                                  sId: snapshot.data![index]['_id'],
                                  idClient: snapshot
                                      .data![index]['client']['_id'],

                                  idLivreur: "aucun livreur",
                                );


                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailLivraisonClientEdit(livraisonA)));
                              },
                              child: const Icon(Icons.info_outline),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.purple,
                            ),
                            FloatingActionButton(
                              heroTag: "btn2",
                              onPressed: () {
                                _showMyDialog();
                              },
                              child: const Icon(Icons.delete),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.purple,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                shadowColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(30),
                      bottomLeft: Radius.circular(30)),
                  side: BorderSide(color: Colors.blue, width: 1),
                ),
                color: Colors.purpleAccent,
                elevation: 30,

              );
            } else {
              return const Center(
                  child: Text(" ", style: TextStyle(fontSize: 1))); // Center

            }
          } else {
            return const Center(
                child: Text(" ", style: TextStyle(fontSize: 1))); // Center

          }
        });
  }


  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('supprimer livraison'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[

                Text('voulez vous supprimez cette livraison?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('supprimer'),
              onPressed: () {
                print('Confirmed');
                final LivraisonService api = LivraisonService();
                api.deletelivraison(
                   _id);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}