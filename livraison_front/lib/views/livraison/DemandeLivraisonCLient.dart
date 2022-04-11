import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../constant/message_constants.dart';
import '../../models/livraison.dart';
import '../../models/livraison_list.dart';
import '../../services/livraisonService.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_client.dart';
import '../../widgets/drawer_responsable.dart';
import 'DetailLivraiosnAdmin.dart';
import 'DetailLivraisonClient.dart';
import 'DetailLivraisonLivreur.dart';

class DemandeClient extends StatefulWidget {
  const DemandeClient({Key? key}) : super(key: key);

  @override
  _DemandeClientState createState() => _DemandeClientState();
}

class _DemandeClientState extends State<DemandeClient> {
  List<dynamic> _livraisonList = [];
  String _id = "";

  String? etat;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text('List Livraison'),
        ),
        drawer: clientDrawer(context),
        body: Column(
            children: <Widget>[

              Expanded(
                  child: FutureBuilder(
                      future: LivraisonService().getAllTLivraison(),
                      builder: (context,
                          AsyncSnapshot<List<dynamic>> snapshot) {


                        if ((snapshot.hasData)) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) =>
                                  buildCard(context, index));
                        } else {
                          return const Center(
                              child: Text(
                                  "", style: TextStyle(fontSize: 1))); // Center

                        }
                      }))
            ]));
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
                            "Colis : " +
                                snapshot.data![index]['colisId']['DesColis'] //(snapshot.data![index]['etatLivraison'].toString()=="en cours")
                                    .toString(),
                            style: const TextStyle(
                                fontSize: 22.0, color: Colors.white),
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
                                  fontSize: 18.0, color: Colors.white)),

                          Text("    vers    ",
                              style:  const TextStyle(
                                  fontSize: 18.0, color: Colors.white)),

                          Text(

                              "${snapshot.data![index]['AdressseDes'].toString()}",
                              style:  const TextStyle(
                                  fontSize: 18.0, color: Colors.white)),
                          const Spacer(),
                        ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 2.0, bottom: 2.0),
                        child: Row(
                          children: <Widget>[
                            Text(
                              "numero :${snapshot.data![index]['numLivraison']}",
                              style: const TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),
                            const Spacer(),
                            Text(
                              "Poid :${snapshot.data![index]['colisId']['poidsColis']} Kg   ",
                              style: const TextStyle(
                                  fontSize: 15.0, color: Colors.white),
                            ),


                            FloatingActionButton(
                              heroTag: "aa",
                              onPressed: () {
                                Livraison livraisonA;

                                livraisonA = new Livraison(
                                  adresseExp: snapshot.data![index]['AdresseExp'],
                                  adressseDes: snapshot.data![index]['AdressseDes'],
                                  dateDeLivraison: snapshot.data![index]['DateDeLivraison'],
                                  DesColis: snapshot.data![index]['colisId']['DesColis'],
                                  numLivraison: snapshot.data![index]['numLivraison'],
                                  typeColis: snapshot.data![index]['colisId']['typeColis'],
                                  poidsColis: snapshot.data![index]['colisId']['poidsColis'],
                                  etatLivraison: snapshot.data![index]['etatLivraison'],
                                  sId: snapshot.data![index]['_id'],
                                  idClient: snapshot.data![index]['client']['_id'],

                                  idLivreur: "aucun livreur",
                                );


                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DetailLivraisonClient(livraisonA)));
                              },
                              child: const Icon(Icons.info_outline),
                              backgroundColor: Colors.white,
                              foregroundColor: Colors.purple,
                            ),
                            FloatingActionButton(
                              heroTag: "btn2",
                              onPressed: () {

                              },
                              child: const Icon(Icons.delete),
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
                  borderRadius: BorderRadius.only(topRight: Radius.circular(30), bottomRight: Radius.circular(30),topLeft: Radius.circular(30),bottomLeft: Radius.circular(30)),
                  side: BorderSide(color: Colors.blue, width: 1),
                ),
                color: Colors.purpleAccent,
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

/**    return ListTile(
    leading: Image.network(
    "https://c0.lestechnophiles.com/www.numerama.com/wp-content/uploads/2021/05/colis-amazon-carton-boite.jpg?resize=1024,576"
    ),

    title: new Text(
    "De :" + snapshot.data![index]['AdresseExp'],
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
    fontSize: 13.0,
    fontWeight: FontWeight.normal)),
    new Text(
    'Adresse: ${snapshot
    .data![index]['AdressseDes']}',
    style: new TextStyle(
    fontSize: 11.0,
    fontWeight: FontWeight.normal)),
    ]),
    //    title: Text(snapshot.data![index]['numLivraison'].toString()),
    //    subtitle: Text(snapshot.data![index]['AdressseDes']),
    onTap: () {
    Livraison livraison;

    if (snapshot.data![index]['livreur'] == null) {
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
    idClient: snapshot.data![index]['client']['email'],
    idLivreur: "aucun livreur",
    );
    print("test1");
    } else {
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
    idLivreur: snapshot.data![index]['livreur']['_id'],
    );

    }

    Navigator.push(
    context,
    MaterialPageRoute(
    builder: (context) =>
    DetailLivraisonClient(livraison)));
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
    )]));
    }

    PreferredSize get appbar => PreferredSize(
    preferredSize: Size(double.infinity, 50),
    child: AppBar(
    title: const Text("liste de livraison"),
    centerTitle: true,
    leading: IconButton(
    onPressed: () {
    Scaffold.of(context).openDrawer();
    },
    icon: const Icon(Icons.menu_rounded),
    ),
    ),
    );

    Widget get showData => Column(
    children: <Widget>[
    newTaskPanel,
    crudPanel,
    ],
    );

    Widget get newTaskPanel => TaskPanel(
    widget: Expanded(
    child: Padding(
    padding: const EdgeInsets.all(12),
    child: Column(
    children: <Widget>[
    const SizedBox(height: 10),
    _livraisonList.length > 0
    ? Expanded(
    child: ListView.builder(
    itemBuilder: (context, index) {
    return showCard(
    index,
    _livraisonList[index].numLivraison,
    _livraisonList[index].adressseDes,
    _livraisonList[index].adresseExp,
    _livraisonList[index].dateDeLivraison,
    _livraisonList[index].typeColis,
    _livraisonList[index].DesColis,
    _livraisonList[index].poidsColis,
    );
    },
    itemCount: _livraisonList.length,
    ),
    )
    : const NoSavedData(),
    ],
    ),
    ),
    ),
    );

    Widget get crudPanel => Padding(
    padding: const EdgeInsets.only(bottom: 15),
    );

    Widget showCard(
    int index,
    String numLivraison,
    String adressseDes,
    String adresseExp,
    String dateDeLivraison,
    String sId,
    String desColis,
    String poidsColis,
    ) =>
    GestureDetector(
    onTap: () {
    _livraisonList[index].numLivraison;
    _livraisonList[index].adressseDes;
    _livraisonList[index].adresseExp;
    _livraisonList[index].dateDeLivraison;
    _livraisonList[index].typeColis;
    _livraisonList[index].DesColis;
    _livraisonList[index].poidsColis;
    _livraisonList[index].sId;
    },
    child: CustomCard(
    index: index + 1,
    name: numLivraison,
    description: adressseDes,
    function: () async {
    _id = sId;
    },
    ),
    );
    }

    class TaskPanel extends StatelessWidget {
    final Widget? widget;

    const TaskPanel({Key? key, this.widget}) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return widget ?? const SizedBox.shrink();
    }

    }


    class NoSavedData extends StatelessWidget {
    const NoSavedData({Key? key}) : super(key: key);

    @override
    Widget build(BuildContext context) {
    return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
    const Icon(
    Icons.airline_seat_individual_suite,
    size: 55,
    ),
    const SizedBox(height: 15),
    Text(
    MessageConstants.NO_SAVED_DATA,
    style: const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 24,
    color: Colors.red,
    ),
    ),
    ],
    );
    }

    }
 */
