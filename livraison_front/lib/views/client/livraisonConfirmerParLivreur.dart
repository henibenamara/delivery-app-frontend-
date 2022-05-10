import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/app_constants.dart';
import '../../constant/message_constants.dart';
import '../../models/livraison.dart';
import '../../models/livraison_list.dart';
import '../../services/livraisonService.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/drawer_client.dart';
import '../livraison/DetailLivraisonClient.dart';
import 'detailsLivraisonConfirmer.dart';


class LivraisonConfirmerParLivreur extends StatefulWidget {
  const LivraisonConfirmerParLivreur({Key? key}) : super(key: key);

  @override
  _LivraisonConfirmerParLivreurState createState() => _LivraisonConfirmerParLivreurState();
}

class _LivraisonConfirmerParLivreurState extends State<LivraisonConfirmerParLivreur> {
  List<LivraisonList> _livraisonList = [];
  String _id = "";
  String? etat ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appbar,
        drawer: clientDrawer(context),
        body: Column(
            children: <Widget>[

              Expanded(
                child: FutureBuilder(
                  future: LivraisonService().getLivraisonByIdClient(),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    print('snapshot is : ${snapshot.data}');

                    if ((snapshot.hasData)) {
                      return ListView.builder(
                        itemBuilder: (context, index) {
                          if ((snapshot.data![index]['etatLivraison'].toString() ==
                              "en cours")&& (snapshot.data![index]['verification'].toString() ==
                              "true")) {
                            return ListTile(
                              leading: Image.network(AppConstants.API_URL+"/"+snapshot.data![index]['imageUrl'],fit:  BoxFit.cover,

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
                                  sId: snapshot.data![index]['_id'],
                                  idLivreur: snapshot.data![index]['livreur']['_id'],
                                  imageUrl: snapshot.data![index]['imageUrl'],

                                );

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DetailLivraisonConfirmer(livraison)));
                              },
                            );
                          }else {
                            return Center(
                              child: Text('',
                                style: TextStyle(fontSize: 1),
                              ),
                            );
                          }
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
            ]));
  }

  PreferredSize get appbar => PreferredSize(
    preferredSize: Size(double.infinity, 50),
    child: AppBar(
      title: const Text("Livraison Confirmer"),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu_rounded),
      ),
    ),
  );


  Future<String?> getidClient() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userId = prefs.getString('userId');
    print('userId is : $userId');
    return userId;
  }
}


