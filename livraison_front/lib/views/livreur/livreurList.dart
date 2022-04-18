import 'package:flutter/material.dart';
import 'package:livraison_front/models/livreur.dart';


import '../../constant/message_constants.dart';
import '../../models/livreur.dart';
import '../../models/livreur_list.dart';
import '../../services/livreurService.dart';
import '../../widgets/custom_card.dart';
import '../../widgets/drawer.dart';

import '../../widgets/drawer_livreur.dart';
import '../../widgets/drawer_responsable.dart';
import 'DetailLivreur.dart';

class LivreurPage extends StatefulWidget {
  const LivreurPage({Key? key}) : super(key: key);

  @override
  _LivreurPageState createState() => _LivreurPageState();
}

class _LivreurPageState extends State<LivreurPage> {
  List<LivreurList> _LivreurList = [];
  String _id = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: appbar,
      drawer: ResponsableDrawer(context),
      body: FutureBuilder(
        future: LivreurService().getAllLivreur(),
        builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
          print('snapshot is : ${snapshot.data}');

          if ((snapshot.hasData)) {
            return ListView.builder(
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index]['nom'].toString()),
                  subtitle: Text(snapshot.data![index]['prenom']),
                    trailing: Icon(Icons.star),
                    leading: CircleAvatar(backgroundImage: NetworkImage(snapshot.data![index]['image']))
                   , onTap: () {
                  UserId user = new UserId(id: snapshot
                      .data![index]['userId']['_id'],
                      email: snapshot.data![index]['userId']['email'],
                      password: snapshot.data![index]['userId']['password'],
                      role: snapshot.data![index]['userId']['role'],
                      v: snapshot.data![index]['userId']['__v']);
                  Livreur livreur = new Livreur(
                    nom: snapshot.data![index]['nom'],
                    prenom: snapshot.data![index]['prenom'],
                    livcin: snapshot.data![index]['livcin'],
                    livTelephone: snapshot.data![index]['livTelephone'],
                    livAdresse: snapshot.data![index]['livAdresse'],
                    livMatVecu: snapshot.data![index]['livMatVecu'],
                    livMarqVecu: snapshot.data![index]['livMarqVecu'],
                    imageUrl:snapshot.data![index]['image'] ,
                    v: snapshot.data![index]['__v'],
                    id: snapshot.data![index]['_id'],
                    userId: user,


                  );
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              DetailLivreur(livreur)));
                });

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
          title: const Text("liste de Livreur"),
          centerTitle: true,
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
                _LivreurList.length > 0
                    ? Expanded(
                        child: ListView.builder(
                          itemBuilder: (context, index) {
                            return showCard(
                              index,
                              _LivreurList[index].id,
                              _LivreurList[index].nom,
                              _LivreurList[index].prenom,
                              _LivreurList[index].userId,
                              _LivreurList[index].livcin,
                              _LivreurList[index].livTelephone,
                              _LivreurList[index].livAdresse,
                                _LivreurList[index].livMatVecu,
                                _LivreurList[index].livMarqVecu,


                            );
                          },
                          itemCount: _LivreurList.length,
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
    String id,
    String nom,
    String prenom,
    String userId,
    String livcin,
   String livTelephone,
      String livAdresse,
    String livMatVecu,
      String livMarqVecu,
  ) =>
      GestureDetector(
        onTap: () {
          _LivreurList[index].id;
          _LivreurList[index].nom;
          _LivreurList[index].prenom;
          _LivreurList[index].userId;
          _LivreurList[index].livcin;
          _LivreurList[index].livTelephone;
          _LivreurList[index].livAdresse;
          _LivreurList[index].livMatVecu;
          _LivreurList[index].livMarqVecu;

        },
        child: CustomCard(
          index: index + 1,
          name: nom,
          description: prenom,
          function: () async {
            _id = id;
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

class ErrorOccurred extends StatelessWidget {
  const ErrorOccurred({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: const Text(MessageConstants.ERROR_OCCURED),

    );
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
