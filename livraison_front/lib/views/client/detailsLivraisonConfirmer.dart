import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/api/invoice.dart';
import 'package:livraison_front/api/pdf_api.dart';
import 'package:livraison_front/api/pdf_invoice_api.dart';
import 'package:livraison_front/constant/app_constants.dart';
import 'package:livraison_front/services/livreurService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/client.dart' as cli;
import '../../models/livraison.dart';
import '../../models/livreur.dart' as liv;
import '../../services/livraisonService.dart';
import '../../widgets/drawer_client.dart';
import '../../widgets/drawer_responsable.dart';
import '../livreur/DetailLivreur.dart';

class DetailLivraisonConfirmer extends StatefulWidget {
  DetailLivraisonConfirmer(this.livraison);

  final Livraison livraison;

  @override
  _DetailLivraisonConfirmerState createState() =>
      _DetailLivraisonConfirmerState();
}

class _DetailLivraisonConfirmerState extends State<DetailLivraisonConfirmer> {
  _DetailLivraisonConfirmerState();

  final LivraisonService api = LivraisonService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: clientDrawer(context),
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
        body: SingleChildScrollView(
          child: Column(children: <Widget>[
            Card(
              child: Container(
                  padding: EdgeInsets.all(10.0),
                  width: 600,
                  height: 770,
                  child: Column(children: <Widget>[
                    Container(
                      height: 200.0,
                      width: 200.0,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage(AppConstants.API_URL +
                              "/" +
                              widget.livraison.imageUrl.toString()),
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
                          Text('Prix :',
                              style: TextStyle(
                                  color: Colors.black.withOpacity(0.8))),
                          Text(widget.livraison.prix.toString() + " dt")
                        ],
                      ),
                    ),
                    Container(
                      height: 200,
                        margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                        child: FutureBuilder(
                          future: LivreurService()
                              .getLivreurByIdUSer(widget.livraison.idLivreur.toString()),
                          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                            print('snapshot12 is: ${snapshot.data}');

                            print(
                                'id livreuur is: ${widget.livraison.idLivreur.toString()}');

                            if ((snapshot.hasData)) {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      SizedBox(
                                        height: 10,
                                      ),
                                      ListTile(
                                          title: Text("nom Livreur :"),
                                          trailing: Text(snapshot.data![index]['nom']),
                                          leading: CircleAvatar(
                                              backgroundImage: NetworkImage(
                                                  AppConstants.API_URL +
                                                      "/" +
                                                      snapshot.data![index]['image'])),
                                          onTap: () {
                                            liv.UserId user = new liv.UserId(
                                                id: snapshot.data![index]['userId']['_id'],
                                                email: snapshot.data![index]['userId']
                                                ['email'],
                                                password: snapshot.data![index]['userId']
                                                ['password'],
                                                role: snapshot.data![index]['userId']['role'],
                                                v: snapshot.data![index]['userId']['__v']);
                                            liv.Livreur livreur = new liv.Livreur(
                                              nom: snapshot.data![index]['nom'],
                                              prenom: snapshot.data![index]['prenom'],
                                              livcin: snapshot.data![index]['livcin'],
                                              livTelephone: snapshot.data![index]
                                              ['livTelephone'],
                                              livAdresse: snapshot.data![index]['livAdresse'],
                                              livMatVecu: snapshot.data![index]['livMatVecu'],
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
                                          }),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Text("Choisir la methode de payement :",
                                          textAlign: TextAlign.center, style: TextStyle(fontSize: 20)),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                        children: [

                                          OutlineButton(
                                            padding: EdgeInsets.symmetric(horizontal: 45),
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20)),
                                            onPressed: () {},
                                            child: Text("a la livraison",
                                                style: TextStyle(
                                                    fontSize: 14, letterSpacing: 2.2, color: Colors.black)),
                                          ),
                                          RaisedButton(
                                            onPressed: () async {
                                              final prefs = await SharedPreferences.getInstance();
                                              final String? nomClient = prefs.getString('nomClient');
                                              final String? prenomClient = prefs.getString("prenomClient");
                                              final String? numClient = prefs.getString("numClient");
                                              final String? adresseClient = prefs.getString("adresseClient");
                                              final date = widget.livraison.dateDeLivraison.toString();
                                              final dueDate = widget.livraison.dateDeLivraison.toString();

                                              final invoice = Invoice(
                                                supplier: liv.Livreur(
                                                  nom: snapshot.data![index]['nom'],
                                                  prenom: snapshot.data![index]['prenom'],
                                                  livcin: snapshot.data![index]['livcin'],
                                                  livTelephone: snapshot.data![index]
                                                  ['livTelephone'],
                                                  livAdresse: snapshot.data![index]['livAdresse'],
                                                  livMatVecu: snapshot.data![index]['livMatVecu'],
                                                  livMarqVecu: snapshot.data![index]
                                                  ['livMarqVecu'],
                                                  v: snapshot.data![index]['__v'],
                                                  id: snapshot.data![index]['_id'],),
                                                customer: cli.Client(
                                                    v: 0,
                                                    prenom: prenomClient.toString(),
                                                    nom: nomClient.toString(),
                                                    id: "",
                                                    clientAdresse: adresseClient.toString(),
                                                    clientTel:int.parse(numClient.toString())),
                                                info: InvoiceInfo(
                                                  date: date,
                                                  dueDate: dueDate,
                                                  description: 'My description...',
                                                  number: widget.livraison.numLivraison.toString(),
                                                ),
                                                items: [
                                                  InvoiceItem(
                                                    description: widget.livraison.DesColis.toString(),
                                                    date: widget.livraison.dateDeLivraison.toString(),
                                                    prix: widget.livraison.prix.toString()+" DT",
                                                    type: widget.livraison.typeColis.toString()

                                                  ),
                                                ],
                                              );

                                              final pdfFile = await PdfInvoiceApi.generate(invoice);

                                              PdfApi.openFile(pdfFile);
                                            },
                                            color: Colors.lightBlueAccent,
                                            padding: EdgeInsets.symmetric(horizontal: 45),
                                            elevation: 2,
                                            shape: RoundedRectangleBorder(
                                                borderRadius: BorderRadius.circular(20)),
                                            child: Text(
                                              "en ligne",
                                              style: TextStyle(
                                                  fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  );
                                },
                                itemCount: 1,
                              );
                            } else {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                          },
                        )),
                  ])),
              shadowColor: Colors.blueAccent,
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
              color: Colors.white,
              elevation: 30,
            ),


          ]),
        ));
  }
}
