import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/services/livreurService.dart';

import '../../constant/app_constants.dart';
import '../../models/livraison.dart';

import '../../models/client.dart' as c;
import '../../models/livreur.dart' as l;
import '../../services/clientService.dart';
import '../../services/livraisonService.dart';

import '../../widgets/drawer_responsable.dart';
import '../client/DetailClient.dart';
import '../livreur/DetailLivreur.dart';

class AccepterLivraison extends StatefulWidget {
  AccepterLivraison(this.livraison);

  final Livraison livraison;

  @override
  _AccepterLivraisonState createState() => _AccepterLivraisonState();
}

class _AccepterLivraisonState extends State<AccepterLivraison> {
  _AccepterLivraisonState();

  final LivraisonService api = LivraisonService();
  String dropdownvalue = 'aaaa';
  int? id ;
  int i=0;
  bool subvalue =false;
  List <String> livlist= [];
  var items = ['aaa','bbb','cccc'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: ResponsableDrawer(context),
        appBar: AppBar(
          title: Text("accept livraison "),
          centerTitle: true,
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: SingleChildScrollView(

          child: Center(
            child: Column(children: <Widget>[
              Card(
                child: Container(
                    padding: EdgeInsets.all(10.0),
                    child: Column(children: <Widget>[
                      Container(
                        height: 200.0,
                        width: 200.0,
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
                        height: 50,
                        child: FutureBuilder(
                          future:
                          ClientService().getClientByIdUSer(widget.livraison.idClient),
                          builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                            if ((snapshot.hasData)) {
                              return ListView.builder(
                                itemBuilder: (context, index) {
                                  return ListTile(
                                    title: Text("nom de Client :"),
                                    //subtitle: Text(snapshot.data![index]['prenom']),
                                    trailing: Text(snapshot.data![index]['nom'].toString()),
                                    leading: CircleAvatar(
                                      backgroundImage: NetworkImage(
                                          AppConstants.API_URL+"/"+snapshot.data![index]['image']
                                      ),
                                    ),
                                    onTap: () {
                                      c.UserId user = new c.UserId(
                                          id: snapshot.data![index]['userId']['_id'],
                                          email: snapshot.data![index]['userId']['email'],
                                          password: snapshot.data![index]['userId']
                                          ['password'],
                                          role: snapshot.data![index]['userId']['role'],
                                          v: snapshot.data![index]['userId']['__v']);
                                      c.Client client = new c.Client(
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
                      /**---------------------**/


                    ])),
                shadowColor: Colors.blueAccent,
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                color: Colors.white,

              ),
              Card(
                child: Container(

                  child: Column(children: <Widget>[
                    Text("choisir un livreur",style: TextStyle(fontSize: 20)),
                    Container(
                  height: 100,
                  child: FutureBuilder(
                    future: LivreurService().getAllLivreur(),
                    builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                      print('snapshot is : ${snapshot.data}');

                      if ((snapshot.hasData)) {
                        return
                          Column(
                              children: [
                                Container(
                                  height: 10,
                                  child: ListView.builder(
                          itemBuilder: (context, index) {
                            l.Livreur livreur = new l.Livreur(
                                  nom: snapshot.data![index]['nom'],
                                  prenom: snapshot.data![index]['prenom'],
                                  livcin: snapshot.data![index]['livcin'],
                                  livTelephone: snapshot
                                      .data![index]['livTelephone'],
                                  livAdresse: snapshot.data![index]['livAdresse'],
                                  livMatVecu: snapshot.data![index]['livMatVecu'],
                                  livMarqVecu: snapshot
                                      .data![index]['livMarqVecu'],
                                  imageUrl: AppConstants.API_URL + "/" +
                                      snapshot.data![index]['image'],
                                  v: snapshot.data![index]['__v'],
                                  id: snapshot.data![index]['_id']);
                            livlist.add(livreur.nom);


                            return Text("", style: TextStyle(fontSize: 1),);
                          },
                          itemCount: snapshot.data?.length,
                        ),
                                ),
                                DropdownButton<String>(
                                  items: livlist.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(value),
                                    );
                                  }).toList(),
                                  onChanged: (_) {},
                                )
                              ]);

                      } else {
                        return Center(
                          child: Text('data is null'),
                        );
                      }

                    }),
                ),
                    Column(
                      children: [
                        DropdownButton<String>(
                          items: livlist.map((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (_) {},
                        )







                      ],
                    ),
                    RaisedButton(
                      onPressed: () {

                      },
                      color: Colors.green,
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      elevation: 2,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      child: Text(
                        "SAVE",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.white),
                      ),
                    )


                  ]
              ),



                ),
              )]),
          ),

        ));
  }

}
/**ListTile(
    title: Text(snapshot.data![index]['nom'].toString()),
    subtitle: Text(snapshot.data![index]['prenom']),
    trailing: Icon(Icons.star),
    leading: CircleAvatar(backgroundImage: NetworkImage(AppConstants.API_URL+"/"+snapshot.data![index]['image']))
    , onTap: () {
    l.UserId user = new l.UserId(id: snapshot
    .data![index]['userId']['_id'],
    email: snapshot.data![index]['userId']['email'],
    password: snapshot.data![index]['userId']['password'],
    role: snapshot.data![index]['userId']['role'],
    v: snapshot.data![index]['userId']['__v']);
    l.Livreur livreur = new l.Livreur(
    nom: snapshot.data![index]['nom'],
    prenom: snapshot.data![index]['prenom'],
    livcin: snapshot.data![index]['livcin'],
    livTelephone: snapshot.data![index]['livTelephone'],
    livAdresse: snapshot.data![index]['livAdresse'],
    livMatVecu: snapshot.data![index]['livMatVecu'],
    livMarqVecu: snapshot.data![index]['livMarqVecu'],
    imageUrl:AppConstants.API_URL+"/"+snapshot.data![index]['image'] ,
    v: snapshot.data![index]['__v'],
    id: snapshot.data![index]['_id'],
    userId: user,


    );
    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
    DetailLivreur(livreur)));
    });*/
