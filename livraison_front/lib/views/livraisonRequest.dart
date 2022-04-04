import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer_responsable.dart';

class LivraisonRequest extends StatefulWidget {
  const LivraisonRequest({Key? key}) : super(key: key);

  @override
  _LivraisonRequest createState() => _LivraisonRequest();
}

class _LivraisonRequest extends State<LivraisonRequest> {
  String _id = "";
  final LivraisonService api = LivraisonService();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: appbar,

        drawer: ResponsableDrawer(context),
        body: FutureBuilder(
            future: LivraisonService().getAllTLivraison(),
            builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
              print('snapshot is : ${snapshot.data}');
              if (snapshot.hasData) {
                return Container(
                  child: new ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (BuildContext context, int index) =>
                          buildCard(context, index)),
                );
              } else {
                return Container(
                  child: Center(
                      child: Text("data is null",
                          style: TextStyle(fontSize: 20))), // Center
                );
              }
            }));
  }
  PreferredSize get appbar => PreferredSize(
    preferredSize: Size(double.infinity, 50),
    child: AppBar(
      title: const Text("Livraison disponible"),
      centerTitle: true,
      leading: IconButton(
        onPressed: () {},
        icon: const Icon(Icons.menu_rounded),
      ),
    ),
  );

  Widget buildCard(BuildContext context, int index) {
    return FutureBuilder(
        future: LivraisonService().getAllTLivraison(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          print('snapshot is : ${snapshot.data}');
          if (snapshot.hasData) {
            return Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 4.0),
                        child: Row(children: <Widget>[
                          Text(
                            "Numero :" +
                                snapshot.data![index]['numLivraison']
                                    .toString(),
                            style: new TextStyle(fontSize: 20.0),
                          ),
                          Spacer(),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 4.0, bottom: 80.0),
                        child: Row(children: <Widget>[
                          Text(
                              "${"de : " + snapshot.data![index]['AdresseExp'].toString()} ----> ${snapshot.data![index]['AdressseDes'].toString()}",
                              style: new TextStyle(fontSize: 20.0)),
                          Spacer(),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "${snapshot.data![index]['colisId']['poidsColis']} Kg",
                              style: new TextStyle(fontSize: 20.0),
                            ),
                            Spacer(),
                            RaisedButton.icon(
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  final String? userId =
                                      prefs.getString('LivreurId');
                                  print('livreurId is :$userId');
                                  print(
                                      'sId is : ${snapshot.data![index]['_id']}');
                                  api.updateLivraison(
                                      snapshot.data![index]['_id'], userId!);
                                },
                                icon: Icon(Icons.apartment),
                                label: Text("accepter")),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          } else {
            return Container(
              child: Center(
                  child: Text("data is null",
                      style: TextStyle(fontSize: 20))), // Center
            );
          }
        });
  }
}
