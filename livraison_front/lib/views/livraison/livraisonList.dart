import 'package:flutter/material.dart';

import '../../constant/message_constants.dart';
import '../../models/livraison.dart';
import '../../models/livraison_list.dart';
import '../../services/livraisonService.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_responsable.dart';
import 'DetailLivraisonClient.dart';
import 'DetailLivraisonLivreur.dart';

class LivraisonPage extends StatefulWidget {
  const LivraisonPage({Key? key}) : super(key: key);

  @override
  _LivraisonPageState createState() => _LivraisonPageState();
}

class _LivraisonPageState extends State<LivraisonPage> {
  List<LivraisonList> _livraisonList = [];
  String _id = "";

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

          if ((snapshot.hasData)) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage(snapshot.data![index]['image'])),

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
                                fontSize: 13.0, fontWeight: FontWeight.normal)),
                        new Text(
                            'Adresse: ${snapshot.data![index]['AdressseDes']}',
                            style: new TextStyle(
                                fontSize: 11.0, fontWeight: FontWeight.normal)),
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
                        sId: snapshot.data![index]['_id']);

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                DetailLivraisonClient(livraison)));
                  },
                );
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
    );
  }

  PreferredSize get appbar => PreferredSize(
        preferredSize: Size(double.infinity, 50),
        child: AppBar(
          title: const Text("liste de livraison"),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {},
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
