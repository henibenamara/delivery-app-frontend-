import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../models/livraison.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer_livreur.dart';




class LivraisonEnCours extends StatefulWidget {
  const LivraisonEnCours({Key? key}) : super(key: key);

  @override
  _LivraisonEnCours createState() => _LivraisonEnCours();
}

class _LivraisonEnCours extends State<LivraisonEnCours> {
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
          title: Text('Livraison En Cours'),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
            side: BorderSide(color: Colors.blueGrey, width: 1),

          ),
        ),
        drawer: livreurDrawer(context),
        body: FutureBuilder(
            future: LivraisonService().getLivraisonByIdLivreur(),
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
        future: LivraisonService().getLivraisonByIdLivreur(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData){
            if (snapshot.data![index]['etatLivraison'].toString() ==
                "en cours") {
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
                                'numLivraison']
                                    .toString(),
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.black),
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
                                  fontSize: 20.0, color: Colors.black)),
                          const Spacer(),
                          Text("vers",
                              style:  const TextStyle(
                                  fontSize: 20.0, color: Colors.black)),
                          const Spacer(),
                          Text(

                              "${snapshot.data![index]['AdressseDes'].toString()}",
                              style:  const TextStyle(
                                  fontSize: 20.0, color: Colors.black)),
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
                                  fontSize: 20.0, color: Colors.black),
                            ),
                            const Spacer(),
                            RaisedButton(
                              child: Text('Livraison Complet'),
                              color: Colors.green,
                              onPressed: () async {
                                final prefs =
                                await SharedPreferences.getInstance();
                                const String etatLivraison = "Livrée";
                                final String? userId =
                                prefs.getString('LivreurId');

                                showDialog(
                                    context: context,
                                    builder: (BuildContext ctx) {
                                      return AlertDialog(
                                        title: const Text('Please Confirm'),
                                        content: const Text(
                                            'Vous assurez que cette livraison est bien Livrée ?'),
                                        actions: [
                                          // The "Yes" button
                                          TextButton(
                                              onPressed: () async {
                                                api.updateLivraison(
                                                    snapshot.data![index]['_id'],
                                                    userId!,
                                                    etatLivraison);
                                                showTopSnackBar(
                                                  context,
                                                  CustomSnackBar.success(
                                                    message:
                                                    "bonne travail, cette livraison est livrer avec succées",
                                                  ),
                                                );
                                                await Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            LivraisonEnCours()));

                                              },
                                              child: const Text('Oui')),
                                          TextButton(
                                              onPressed: () {
                                                // Close the dialog
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text('non'))
                                        ],
                                        shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(Radius.circular(15.0))),
                                      );
                                    });
                              }),

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                shadowColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30),topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                  side: BorderSide(color: Colors.green, width: 1),
                ),
                color: Colors.white,
                elevation: 30,

              );

            } else {
              return const Center(
                  child:  Text("", style:  TextStyle(fontSize: 1))); // Center

            }}else {
            return const Center(
                child:  Text(" ", style:  TextStyle(fontSize: 1))); // Center

          }
        });
  }
}
