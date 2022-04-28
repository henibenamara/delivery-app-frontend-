import 'package:flutter/material.dart';
import 'package:livraison_front/constant/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../constant/message_constants.dart';
import '../../models/livraison.dart';
import '../../models/livraison_list.dart';
import '../../services/livraisonService.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/drawer_livreur.dart';
import 'DetailLivraisonLivreur.dart';

class LivraisonLivreur extends StatefulWidget {
  const LivraisonLivreur({Key? key}) : super(key: key);

  @override
  _LivraisonLivreurState createState() => _LivraisonLivreurState();
}

class _LivraisonLivreurState extends State<LivraisonLivreur> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.lightBlue,
        title: Text('Historique personel'),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
          side: BorderSide(color: Colors.blueGrey, width: 1),
        ),
      ),
      drawer: livreurDrawer(context),
      body: FutureBuilder(
        future: LivraisonService().getLivraisonByIdLivreur(),
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
                        sId: snapshot.data![index]['_id'],
                    imageUrl:snapshot.data![index]['imageUrl'] );
                    print(snapshot.data![index]['imageUrl'].toString());

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
              child: Text('No livraison'),
            );
          }
        },
      ),
    );
  }


}
