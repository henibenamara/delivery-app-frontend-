import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/livraisonService.dart';
import '../models/livraison.dart';
import '../widgets/drawer_livreur.dart';
import 'livraison/DetailLivraiosnAdmin.dart';
import 'livraison/DetailLivraison.dart';

class LivraisonRequest extends StatefulWidget {
  const LivraisonRequest({Key? key}) : super(key: key);

  @override
  _LivraisonRequest createState() => _LivraisonRequest();
}

class _LivraisonRequest extends State<LivraisonRequest> {
  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(title: Text(title), content: Text(text)),
      );

  final LivraisonService api = LivraisonService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.lightBlue,
          title: Text('Livraison Disponible'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.blueGrey, width: 1),

          ),
        ),
        drawer: livreurDrawer(context),
        body: FutureBuilder(
            future: LivraisonService().getAllTLivraison(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildCard(context, index));
              } else {
                return const Center(
                    child:  Text("", style: TextStyle(fontSize: 1))); // Center

              }
            }));
  }



  Widget buildCard(BuildContext context, int index) {
    return FutureBuilder(
        future: LivraisonService().getAllTLivraison(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData){
          if (snapshot.data![index]['etatLivraison'].toString() ==
              "non livrée") {
            return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                        child: Row(children: <Widget>[
                          Text(
                            "Numero :" +
                                snapshot.data![index][
                                        'numLivraison'] //(snapshot.data![index]['etatLivraison'].toString()=="en cours")
                                    .toString(),
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          ),
                          const Spacer(),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 30.0),
                        child: Row(children: <Widget>[
                          Text(
                              "${"De " + snapshot.data![index]['AdresseExp'].toString()} ",
                              style:  const TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          const Spacer(),
                          Text("vers",
                              style:  const TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          const Spacer(),
                          Text(

                                  "${snapshot.data![index]['AdressseDes'].toString()}",
                              style:  const TextStyle(
                                  fontSize: 20.0, color: Colors.white)),
                          const Spacer(),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "${snapshot.data![index]['colisId']['poidsColis']} Kg",
                              style: const TextStyle(
                                  fontSize: 20.0, color: Colors.white),
                            ),
                            const Spacer(),
                            FloatingActionButton(
                              onPressed: () async {
                                final prefs =
                                    await SharedPreferences.getInstance();
                                const String etatLivraison = "en cours";
                                final String? userId =
                                    prefs.getString('LivreurId');
                                api.updateLivraison(
                                    snapshot.data![index]['_id'],
                                    userId!,
                                    etatLivraison);
                              },
                              child: const Icon(Icons.check),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.purple,
                            ),
                            FloatingActionButton(
                              onPressed: () {
                                Livraison livraison;

                                  livraison = new Livraison(
                                    adresseExp: snapshot.data![index]['AdresseExp'],
                                    adressseDes: snapshot.data![index]['AdressseDes'],
                                    dateDeLivraison: snapshot.data![index]
                                    ['DateDeLivraison'],
                                    DesColis: snapshot
                                        .data![index]['colisId']['DesColis'],
                                    numLivraison: snapshot.data![index]['numLivraison'],
                                    typeColis: snapshot.data![index]['colisId']
                                    ['typeColis'],
                                    poidsColis: snapshot.data![index]['colisId']
                                    ['poidsColis'],
                                    etatLivraison: snapshot.data![index]['etatLivraison'],
                                    sId: snapshot.data![index]['_id'],
                                    idClient: snapshot.data![index]['client']['_id'],
                                    idLivreur: "aucun livreur",
                                  );



                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailLivraison(livraison)));
                              },
                              child: const Icon(Icons.info_outline),
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
                  borderRadius: BorderRadius.only(topRight: Radius.circular(100), bottomRight: Radius.circular(30),topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                  side: BorderSide(color: Colors.blue, width: 1),
                ),
                color: Colors.lightBlue,
                elevation: 30,

              );

          } else {
            return const Center(
                  child:  Text(" ", style:  TextStyle(fontSize: 1))); // Center

          }}else {
    return const Center(
    child:  Text(" ", style:  TextStyle(fontSize: 1))); // Center

    }
        });
  }
}
