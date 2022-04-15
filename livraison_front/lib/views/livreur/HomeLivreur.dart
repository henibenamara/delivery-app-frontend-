
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/models/client.dart';
import 'package:livraison_front/models/livreur.dart';
import 'package:livraison_front/services/livreurService.dart';
import 'package:livraison_front/views/client/EditClient.dart';
import 'package:livraison_front/views/livreur/EditLivreur.dart';

import '../../services/clientService.dart';
import '../../widgets/profile_Widget.dart';

class ProfilePageLiv extends StatefulWidget {
  ProfilePageLiv(this.userId);

  final String?  userId;
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePageLiv> {
  String? get userId => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.green,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.settings,
              color: Colors.green,
            ),
            onPressed: () {

            },
          ),
        ],
      ),
      body: Container(

        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Text(
                "Mon Profile",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
              ),
              SizedBox(
                height: 15,
              ),

              Container(
                height: 1000,
                child: FutureBuilder(
                  future:
                  LivreurService().getLivreurByIdUSer(widget.userId),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    print('snapshot is : ${snapshot.data}');

                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (BuildContext context, int index) =>
                              buildCard(context, index));
                    } else {
                      return const Center(
                          child:  Text("", style: TextStyle(fontSize: 1))); // Center

                    }
                  },
                ),
              ),


            ],
          ),
        ),
      ),
    );
  }
  Widget buildCard(BuildContext context, int index) {
    return FutureBuilder(
        future: LivreurService().getLivreurByIdUSer(widget.userId),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          if (snapshot.hasData){

              return Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[


                      Container(

                        width: 130,
                        height: 130,
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 4,
                                color: Theme
                                    .of(context)
                                    .scaffoldBackgroundColor),
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: 2,
                                  blurRadius: 10,
                                  color: Colors.black.withOpacity(0.1),
                                  offset: Offset(0, 10))
                            ],
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: NetworkImage(snapshot.data![index][
                                'image'],
                                ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 30.0),
                        child: Row(children: <Widget>[
                          Text(
                            "Prenom :   " +
                                snapshot.data![index][
                                'prenom'].toString(), style: const TextStyle(fontSize: 25.0, color: Colors.blueAccent),
                          ),
                          const Spacer(),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 30.0),
                        child: Row(children: <Widget>[
                          Text(
                            "nom :         " + snapshot.data![index]['nom'].toString(), style: const TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                          ),
                          const Spacer(),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 30.0),
                        child: Row(children: <Widget>[
                          Text(
                            "Telephone :" + snapshot.data![index][
                                'livTelephone'].toString(), style: const TextStyle(fontSize: 20.0, color: Colors.blueAccent),
                          ),
                          const Spacer(),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 30.0),
                        child: Row(children: <Widget>[
                          Text(
                              "${"Adresse :" + snapshot.data![index]['livAdresse'].toString()} ",
                              style:  const TextStyle(
                                  fontSize: 20.0, color: Colors.blueAccent)),

                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 30.0),
                        child: Row(children: <Widget>[
                          Text(
                              "${"Matricule Vehicule :" + snapshot.data![index]['livMatVecu'].toString()} ",
                              style:  const TextStyle(
                                  fontSize: 20.0, color: Colors.blueAccent)),

                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 30.0),
                        child: Row(children: <Widget>[
                          Text(
                              "${"Marque :" + snapshot.data![index]['livMarqVecu'].toString()} ",
                              style:  const TextStyle(
                                  fontSize: 20.0, color: Colors.blueAccent)),

                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: <Widget>[

                            Spacer(),
                            RaisedButton(
                              onPressed: () {


                                Livreur liv = new Livreur(
                                  nom: snapshot.data![index]['nom'],
                                  prenom: snapshot.data![index]['prenom'],
                                  livTelephone: snapshot.data![index]['livTelephone'],
                                  livcin: snapshot.data![index]['livcin'],
                                  livAdresse: snapshot.data![index]['livAdresse'],
                                  livMatVecu: snapshot.data![index]['livMatVecu'],
                                  livMarqVecu: snapshot.data![index]['livMarqVecu'],
                                  id: snapshot.data![index]['_id'],
                                  imageUrl:snapshot.data![index]['image'] ,

                                  v: snapshot.data![index]['__v'],


                                );



                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            EditProfileLivreur(liv)));
                              },
                              color: Colors.green,
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Text(
                                "Modififer",
                                style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.white),
                              ),
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                ),
                shadowColor: Colors.lightBlue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30),topLeft: Radius.circular(15),bottomLeft: Radius.circular(15)),
                  side: BorderSide(color: Colors.blue, width: 1),
                ),
                color: Colors.white,
                elevation: 30,

              );

            }else {
            return const Center(
                child:  Text(" ", style:  TextStyle(fontSize: 1))); // Center

          }
        });
  }
}