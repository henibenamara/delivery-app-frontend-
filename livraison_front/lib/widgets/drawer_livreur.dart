import 'package:flutter/material.dart';
import 'package:livraison_front/services/livreurService.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../views/livreur/HomeLivreur.dart';
SharedPreferences? sharedPrefs;
String? email;
String? userIdl;
Widget livreurDrawer(BuildContext context) {

  return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          SizedBox(

            height: 180,
            child: FutureBuilder(
                future: _getPrefs(),
                builder: (context, snapshot) {
                  return  FutureBuilder(
                      future: LivreurService().getLivreurByIdUSer(userIdl),
                      builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {

                                String url = snapshot.data![index]['image'];
                                String? nom = snapshot.data![index]['nom'];
                                String? email = snapshot.data![index]['userId']['email'];
                                print(email);
                                return  UserAccountsDrawerHeader(

                                    accountName: Text(nom!),
                                    accountEmail: Text(email!),
                                    currentAccountPicture:
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(url.toString()),

                                    ));

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
              title: Text('Les Demandes'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/livreurReq");

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

              }),ListTile(
              leading: Icon(Icons.logout),
              title: Text('Déconnexion '),
              onTap: () {

                Navigator.pushReplacementNamed(context, "/");

              }),

        ],
      ));
}
Future<void> _getPrefs() async{
  sharedPrefs = await SharedPreferences.getInstance();
  email =sharedPrefs?.getString('emailLivreur');
  userIdl =sharedPrefs?.getString('LivreurId');

}
