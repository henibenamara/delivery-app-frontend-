import 'package:flutter/material.dart';
import 'package:livraison_front/services/livreurService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/app_constants.dart';
import '../views/livraisonRequest.dart';
import '../views/livreur/HomeLivreur.dart';
import '../views/responsable/dashboardLivreur.dart';
SharedPreferences? sharedPrefs;
String? email;
String? userIdl;
Widget livreurDrawer(BuildContext context) {

  return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            height: 600,
            child: FutureBuilder(
                future: _getPrefs(),
                builder: (context, snapshot) {
                  return  FutureBuilder(
                      future: LivreurService().getLivreurByIdUSer(userIdl),
                      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index)   {

                                String url = AppConstants.API_URL+"/"+ snapshot.data![index]['image'];
                                String? nom = snapshot.data![index]['nom'];
                                String? email = snapshot.data![index]['userId']['email'];
                                String? prenom = snapshot.data![index]['prenom'];
                                print(email);



                                return  Container(
                                  child: Column(
                                      children: <Widget>[
                                        UserAccountsDrawerHeader(
                                            accountName: Text("${nom} ${prenom}"),
                                            accountEmail: Text(email!),
                                            currentAccountPicture:
                                            CircleAvatar(
                                              backgroundImage: NetworkImage(url.toString()),

                                        )),
                                        Container(
                                          child: ListTile(
                                              leading: Icon(Icons.person_outline),
                                              title: Text('Mon profil'),
                                              onTap: () async {
                                                final prefs = await SharedPreferences.getInstance();
                                                final String? userId = prefs.getString('LivreurId');
                                                print('userId is : $userId');
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                        (ProfilePageLiv(userId))));

                                              }),
                                        ),
                                        ListTile(
                                            leading: Icon(Icons.list),
                                            title: Text('Dashboard'),
                                            onTap: () async {
                                              final prefs = await SharedPreferences.getInstance();
                                              final String? userId = prefs.getString('LivreurId');
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        DashboardLivreur(userId,snapshot.data![index]['image'],snapshot.data![index]['nom'],snapshot.data![index]['userId']['email'])));

                                            }),
                                        ListTile(
                                            leading: Icon(Icons.list),
                                            title: Text('Les Demandes'),
                                            onTap: () {Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        LivraisonRequest(snapshot.data![index]['_id'])));

                                            }),

                                        ListTile(
                                            leading: Icon(Icons.list),
                                            title: Text('Livraison A livrée (confirmer)'),
                                            onTap: () {
                                              Navigator.pushReplacementNamed(context, "/LivraisonConfirme");

                                            }),
                                        ListTile(
                                            leading: Icon(Icons.autorenew_outlined),
                                            title: Text('Livraison en cours'),
                                            onTap: () {
                                              Navigator.pushReplacementNamed(context, "/livraisonEncours");

                                            }),
                                        ListTile(
                                            leading: Icon(Icons.library_add_check),
                                            title: Text('Historique'),
                                            onTap: () {
                                              Navigator.pushReplacementNamed(context, "/LivraisonLivreur");

                                            }),
                                        ListTile(
                                            leading: Icon(Icons.logout),
                                            title: Text('Déconnexion '),
                                            onTap: () {

                                              Navigator.pushReplacementNamed(context, "/");

                                            }),


                                      ]),
                                );

                              }


                          );
                        } else {
                          return const Center(
                              child:  Text("", style: TextStyle(fontSize: 1))); // Center
                        }
                      });
                }
            ),
          ),
        ],
      ));
}
Future<void> _getPrefs() async{
  sharedPrefs = await SharedPreferences.getInstance();
  email =sharedPrefs?.getString('emailLivreur');
  userIdl =sharedPrefs?.getString('LivreurId');

}
