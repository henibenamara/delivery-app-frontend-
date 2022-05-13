import 'package:flutter/material.dart';
import 'package:livraison_front/services/ResponsableService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../constant/app_constants.dart';
import '../../models/livreur.dart';
import '../../services/clientService.dart';
import '../../widgets/drawer_responsable.dart';
import 'demandeLivreur.dart';

class verifLivreur extends StatefulWidget {
  verifLivreur(this.livreur);
  final Livreur livreur;

  @override
  _DetailLivreurState createState() => _DetailLivreurState();
}

class _DetailLivreurState extends State<verifLivreur> {
  _DetailLivreurState();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: ResponsableDrawer(context),
      appBar: AppBar(
        title: Text("Detail Livreur"),
        centerTitle: true,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Column(children: <Widget>[
        Container(
          padding: EdgeInsets.all(20.0),
          child: Card(
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 500,
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
                              widget.livreur.nom.toString(),
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
                              widget.livreur.prenom.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Cin :',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.livreur.livcin.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Adresse :',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.livreur.livAdresse.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Marque Voiture:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.livreur.livMarqVecu.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: Column(
                          children: <Widget>[
                            Text('Matricule Voiture:',
                                style: TextStyle(
                                    color: Colors.black.withOpacity(0.8))),
                            Text(
                              widget.livreur.livMatVecu.toString(),
                            )
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                Text(
                                  "Photo de Permie",
                                  style: TextStyle(fontSize: 16),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(AppConstants.API_URL +
                                          "/" +
                                          widget.livreur.livpermie.toString()),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.rectangle,
                                  ),
                                )
                              ],
                            ),
                            Spacer(),
                            Column(
                              children: <Widget>[
                                Text("Photo de Carte Gris",
                                    style: TextStyle(fontSize: 16)),
                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 150,
                                  width: 150,
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      image: NetworkImage(AppConstants.API_URL +
                                          "/" +
                                          widget.livreur.livcarteGrise
                                              .toString()),
                                      fit: BoxFit.fill,
                                    ),
                                    shape: BoxShape.rectangle,
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ))),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            OutlineButton(
              padding: EdgeInsets.symmetric(horizontal: 50),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              onPressed: () {
                _showMyDialog();
              },
              child: Text("refuser",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.black)),
            ),
            RaisedButton(
              onPressed: () {
                ClientService api = ClientService();
                api.verifCompte(widget.livreur.userId!.id.toString(), "true");
                showTopSnackBar(
                  context,
                  CustomSnackBar.success(
                    message: "Ce Compte est approver avec succée",
                  ),
                );

                Navigator.pop(context);
              },
              color: Colors.green,
              padding: EdgeInsets.symmetric(horizontal: 50),
              elevation: 2,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Text(
                "Accepter",
                style: TextStyle(
                    fontSize: 14, letterSpacing: 2.2, color: Colors.white),
              ),
            )
          ],
        )
      ]),
    );
  }

  Future<void> _showMyDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Demande Livreur'),
          content: SingleChildScrollView(
            child: Column(
              children: <Widget>[
                Text('voulez vous supprimez cette Demande?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('supprimer'),
              onPressed: () async {
                print('suprimer');
                final ResponsableService api = ResponsableService();
                api.deletelivreur(widget.livreur.id);
                showTopSnackBar(
                  context,
                  CustomSnackBar.info(
                    message: "Demande refusée",
                  ),
                );
                await Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DemandeLivreur()));
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
