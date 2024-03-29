import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/models/offer.dart';
import 'package:livraison_front/services/offerService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../services/livraisonService.dart';
import '../constant/app_constants.dart';
import '../models/livraison.dart';
import '../widgets/drawer_livreur.dart';
import 'livraison/DetailLivraisonLivreur.dart';

class LivraisonRequest extends StatefulWidget {
  LivraisonRequest(this.id);

  final String?  id;

  @override
  _LivraisonRequest createState() => _LivraisonRequest();
}

class _LivraisonRequest extends State<LivraisonRequest> {
  TextEditingController _textFieldController = TextEditingController();


   String codeDialog="00";
  late String valueText;
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
                    child: Text("", style: TextStyle(fontSize: 1))); // Center

              }
            }));
  }

  Widget buildCard(BuildContext context, int index) {
    return FutureBuilder(
        future: LivraisonService().getAllTLivraison(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData) {
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
                          padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                          child:  Container(
                              height: 200,

                              child: Image.network(AppConstants.API_URL+"/"+snapshot.data![index]['imageUrl'].toString()))
                      ),



                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 0.0),
                        child: Row(children: <Widget>[
                          Icon(Icons.add_location_alt_rounded),
                          Text(
                              "${snapshot.data![index]['AdresseExp']
                                  .toString()} ",
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.white)),


                        ]),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Row(children: <Widget>[
                          Icon(Icons.add_road),



                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Row(children: <Widget>[
                          Icon(Icons.add_road),



                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Row(children: <Widget>[
                          Icon(Icons.add_road),



                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Row(children: <Widget>[
                          Icon(Icons.add_road),



                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 0.0, bottom: 0.0),
                        child: Row(children: <Widget>[
                          Icon(Icons.add_road),



                        ]),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(top: 1.0, bottom: 1.0),
                        child: Row(children: <Widget>[
                          Icon(Icons.airplanemode_on_sharp),


                          Text(

                              "${snapshot.data![index]['AdressseDes']
                                  .toString()}",
                              style: const TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                          const Spacer(),
                          FloatingActionButton(
                            onPressed: () async {

                              final prefs =
                              await SharedPreferences.getInstance();

                              final String? userId =
                              prefs.getString('LivreurId');
                              print(snapshot.data![index]['_id']);
                              print(userId);


                              /**------------------**/
                              showDialog(
                                  context: context,
                                  builder: (BuildContext ctx) {
                                    return AlertDialog(
                                      title: const Text('Donner un offre !'),
                                      content: TextField(
                                        onChanged: (value) {
                                          setState(() {
                                            valueText = value;
                                          });
                                        },
                                        controller: _textFieldController,
                                        decoration: InputDecoration(hintText: "Proposer un prix"),
                                      ),
                                      actions: [
                                        // The "Yes" button
                                        TextButton(
                                            onPressed: () async {
                                              Offer offer = new Offer(
                                                  livreur:widget.id.toString(),
                                                  livraison: snapshot.data![index]['_id'].toString(),
                                                  prix: _textFieldController.text
                                              );
                                              OfferService().addNewOffer(
                                                  offer
                                              );

                                              showTopSnackBar(
                                                context,
                                                CustomSnackBar.success(
                                                  message:
                                                  "votre offre est enregistrer",
                                                ),
                                              );
                                              await Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          LivraisonRequest(widget.id)));



                                            },
                                            child: const Text('Confirmer')),
                                        TextButton(
                                            onPressed: () {
                                              // Close the dialog
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text('cancel'))
                                      ],
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(15.0))),
                                    );
                                  });

                            },
                            child: const Icon(Icons.check),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.purple,
                          ),
                          FloatingActionButton(
                            onPressed: () {
                              Livraison livraison;

                              livraison = new Livraison(
                                adresseExp: snapshot.data![index]
                                ['AdresseExp'],
                                adressseDes: snapshot.data![index]
                                ['AdressseDes'],
                                dateDeLivraison: snapshot.data![index]
                                ['DateDeLivraison'],
                                DesColis: snapshot.data![index]['colisId']
                                ['DesColis'],
                                numLivraison: snapshot.data![index]
                                ['numLivraison'],
                                typeColis: snapshot.data![index]['colisId']
                                ['typeColis'],
                                poidsColis: snapshot.data![index]['colisId']
                                ['poidsColis'],
                                etatLivraison: snapshot.data![index]
                                ['etatLivraison'],
                                sId: snapshot.data![index]['_id'],
                                idClient: snapshot.data![index]['client']
                                ['_id'],
                                imageUrl: snapshot.data![index]['imageUrl'],
                                idLivreur: "aucun livreur",
                              );
                              print(snapshot.data![index]['client']['_id']);

                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          DetailLivraisonLivreur(livraison)));
                            },
                            child: const Icon(Icons.info_outline),
                            backgroundColor: Colors.white,
                            foregroundColor: Colors.purple,
                          ),
                        ]),
                      ),

                    ],
                  ),
                ),
                shadowColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topRight: Radius.circular(100),
                      bottomRight: Radius.circular(30),
                      topLeft: Radius.circular(15),
                      bottomLeft: Radius.circular(15)),
                  side: BorderSide(color: Colors.blue, width: 1),
                ),
                color: Colors.lightBlue,
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
}
