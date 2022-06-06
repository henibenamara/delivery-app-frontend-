import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/constant/app_constants.dart';
import 'package:livraison_front/services/livreurService.dart';
import 'package:livraison_front/services/offerService.dart';
import 'package:livraison_front/views/client.dart';
import 'package:livraison_front/widgets/drawer_client.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../models/livraison.dart';

import '../../models/livreur.dart';
import '../../services/clientService.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_responsable.dart';
import '../client/DetailClient.dart';
import '../client/EditClient.dart';
import '../livreur/DetailLivreur.dart';
import 'LivraisonNonLivrée(Offers).dart';
import 'detailsLivraisonConfirmer.dart';

class OffreLivraisonClient extends StatefulWidget {
  OffreLivraisonClient(this.livraison);

  final Livraison livraison;

  @override
  _OffreLivraisonClientState createState() => _OffreLivraisonClientState();
}

class _OffreLivraisonClientState extends State<OffreLivraisonClient> {
  _OffreLivraisonClientState();

  final LivraisonService api = LivraisonService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: clientDrawer(context),
        appBar: AppBar(
          title: Text("Les Offres"),
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
            Column(
              children: [
                Container(
                    height: 700,
                    child: FutureBuilder(
                      future: OfferService().getListOfferBylivraisonId(
                          widget.livraison.sId.toString()),
                      builder:
                          (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if ((snapshot.hasData)) {
                          return ListView.builder(
                            itemBuilder: (context, index) {
                              return Card(
                                child: Column(
                                  children: [
                                    Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(16.0),
                                        child: Column(
                                          children: <Widget>[
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 4.0),
                                              child: Row(children: <Widget>[
                                                Text(
                                                  "Offre :" +
                                                      (index + 1).toString(),
                                                  style: const TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.white),
                                                ),
                                                const Spacer(),
                                              ]),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 4.0, bottom: 10.0),
                                              child: Container(
                                                  height: 60,
                                                  child: FutureBuilder(
                                                    future: LivreurService()
                                                        .getLivreurByIdUSer(
                                                            snapshot
                                                                .data![index]
                                                                    ['livreur']
                                                                    ['userId']
                                                                .toString()),
                                                    builder: (context,
                                                        AsyncSnapshot<
                                                                List<dynamic>>
                                                            snapshot) {
                                                      if ((snapshot.hasData)) {
                                                        return ListView.builder(
                                                          itemBuilder:
                                                              (context, index) {
                                                            return ListTile(
                                                                title: Text(
                                                                  "nom Livreur :",
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                trailing: Text(
                                                                  snapshot.data![
                                                                          index]
                                                                      ['nom'],
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          20),
                                                                ),
                                                                leading: CircleAvatar(
                                                                    backgroundImage: NetworkImage(AppConstants
                                                                            .API_URL +
                                                                        "/" +
                                                                        snapshot.data![index]
                                                                            [
                                                                            'image'])),
                                                                onTap: () {
                                                                  UserId user = new UserId(
                                                                      id: snapshot.data![index]
                                                                              ['userId'][
                                                                          '_id'],
                                                                      email: snapshot.data![index]
                                                                              ['userId'][
                                                                          'email'],
                                                                      password:
                                                                          snapshot.data![index]['userId'][
                                                                              'password'],
                                                                      role: snapshot.data![index]
                                                                              ['userId']
                                                                          ['role'],
                                                                      v: snapshot.data![index]['userId']['__v']);
                                                                  Livreur
                                                                      livreur =
                                                                      new Livreur(
                                                                    nom: snapshot
                                                                            .data![index]
                                                                        ['nom'],
                                                                    prenom: snapshot
                                                                            .data![index]
                                                                        [
                                                                        'prenom'],
                                                                    livcin: snapshot
                                                                            .data![index]
                                                                        [
                                                                        'livcin'],
                                                                    livTelephone:
                                                                        snapshot.data![index]
                                                                            [
                                                                            'livTelephone'],
                                                                    livAdresse:
                                                                        snapshot.data![index]
                                                                            [
                                                                            'livAdresse'],
                                                                    livMatVecu:
                                                                        snapshot.data![index]
                                                                            [
                                                                            'livMatVecu'],
                                                                    livMarqVecu:
                                                                        snapshot.data![index]
                                                                            [
                                                                            'livMarqVecu'],
                                                                    v: snapshot.data![
                                                                            index]
                                                                        ['__v'],
                                                                    id: snapshot
                                                                            .data![index]
                                                                        ['_id'],
                                                                    userId:
                                                                        user,
                                                                  );
                                                                  Navigator.push(
                                                                      context,
                                                                      MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              DetailLivreur(livreur)));
                                                                });
                                                          },
                                                          itemCount: 1,
                                                        );
                                                      } else {
                                                        return const Center(
                                                          child:
                                                              CircularProgressIndicator(),
                                                        );
                                                      }
                                                    },
                                                  )),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 8.0, bottom: 4.0),
                                              child: Row(children: <Widget>[
                                                Text(
                                                  "Prix :" + snapshot.data![index]['prix'].toString() + " DT",
                                                  style: const TextStyle(
                                                      fontSize: 20.0,
                                                      color: Colors.white),
                                                ),
                                                const Spacer(),
                                                FloatingActionButton(
                                                  onPressed: () async {
                                                    String? prix = snapshot.data![index]['prix'].toString();
                                                    String? etatLivraison = "en cours";
                                                    String? idliv = snapshot.data![index]['livreur']['userId'].toString();
                                                    print("id livreeeeeeu : $idliv");
                                                    String? idLivraison = widget.livraison.sId.toString();

                                                    showDialog(
                                                        context: context,
                                                        builder:
                                                            (BuildContext ctx) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                                'Confirmer votre choix !'),
                                                            content: Text(
                                                                "Prix : $prix dt"),
                                                            actions: [
                                                              // The "Yes" button
                                                              TextButton(
                                                                  onPressed:
                                                                      () async {
                                                                    LivraisonService().updateLivraison(
                                                                        idLivraison.toString(),
                                                                        idliv,
                                                                        etatLivraison.toString(),
                                                                        prix.toString());
                                                                    showTopSnackBar(
                                                                      context,
                                                                      CustomSnackBar
                                                                          .success(
                                                                        message:
                                                                            "vous avez choisir cette offre avec succès",
                                                                      ),
                                                                    );
                                                                    Livraison livraison = new Livraison(
                                                                        adresseExp: widget
                                                                            .livraison
                                                                            .adresseExp,
                                                                        adressseDes: widget
                                                                            .livraison
                                                                            .adressseDes,
                                                                        dateDeLivraison: widget
                                                                            .livraison
                                                                            .dateDeLivraison,
                                                                        DesColis: widget
                                                                            .livraison
                                                                            .DesColis,
                                                                        numLivraison: widget
                                                                            .livraison
                                                                            .numLivraison,
                                                                        typeColis: widget
                                                                            .livraison
                                                                            .typeColis,
                                                                        poidsColis: widget
                                                                            .livraison
                                                                            .poidsColis,
                                                                        etatLivraison: widget
                                                                            .livraison
                                                                            .etatLivraison,
                                                                        sId: widget
                                                                            .livraison
                                                                            .sId,
                                                                        idLivreur:
                                                                            idliv,
                                                                        prix:
                                                                            prix,
                                                                        imageUrl: widget
                                                                            .livraison
                                                                            .imageUrl);
                                                                    await Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                            builder: (context) =>
                                                                                DetailLivraisonConfirmer(livraison)));
                                                                  },
                                                                  child: const Text(
                                                                      'Confirmer')),
                                                              TextButton(
                                                                  onPressed:
                                                                      () {
                                                                    // Close the dialog
                                                                    Navigator.of(
                                                                            context)
                                                                        .pop();
                                                                  },
                                                                  child: const Text(
                                                                      'cancel'))
                                                            ],
                                                            shape: RoundedRectangleBorder(
                                                                borderRadius: BorderRadius
                                                                    .all(Radius
                                                                        .circular(
                                                                            15.0))),
                                                          );
                                                        });
                                                  },
                                                  child:
                                                      const Icon(Icons.check),
                                                  backgroundColor: Colors.white,
                                                  foregroundColor:
                                                      Colors.purple,
                                                ),
                                              ]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      shadowColor: Colors.lightBlue,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(45),
                                            bottomRight: Radius.circular(45),
                                            topLeft: Radius.circular(45),
                                            bottomLeft: Radius.circular(45)),
                                        side: BorderSide(
                                            color: Colors.blue, width: 1),
                                      ),
                                      color: Colors.lightBlue,
                                      elevation: 30,
                                    )
                                  ],
                                ),
                              );
                            },
                            itemCount: snapshot.data?.length,
                          );
                        } else {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                      },
                    )),
              ],
            ),
          ]),
        ));
  }
}
