import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/models/client.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/app_constants.dart';
import '../services/clientService.dart';
import '../services/livraisonService.dart';
import '../views/client/EditClient.dart';
import '../views/client/HomeClient.dart';
import '../views/client/LivraisonNonLivrée(Offers).dart';
import '../views/client/dashboardClient.dart';
import '../views/client/livraisonConfirmerParLivreur.dart';
SharedPreferences? sharedPrefs;
String? email;
String? userIdC;

Widget clientDrawer(BuildContext context) {


  return Drawer(

      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(

            bottomRight: Radius.circular(80)),
      ),
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[

          SizedBox(
            height: 180,
            child: FutureBuilder(
                future: _getPrefs(),
                builder: (context, snapshot) {
                  return FutureBuilder(
                      future: ClientService().getClientByIdUSer(userIdC),
                      builder: (context,
                          AsyncSnapshot<List<dynamic>> snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data?.length,
                              itemBuilder: (BuildContext context, int index) {
                                String url =AppConstants.API_URL+"/"+ snapshot.data![index]['image'];
                                String? nom = snapshot.data![index]['nom'];
                                String? email = snapshot
                                    .data![index]['userId']['email'];
                                print(email);
                                return UserAccountsDrawerHeader(

                                    accountName: Text(nom!),
                                    accountEmail: Text(email!),
                                    currentAccountPicture:
                                    CircleAvatar(
                                      backgroundImage: NetworkImage(
                                           url.toString()),

                                    ));
                              }


                          );
                        } else {
                          return const Center(
                              child: Text("", style: TextStyle(
                                  fontSize: 1))); // Center

                        }
                      });
                }

            ),
          ),




          ListTile(
            leading: Icon(Icons.home), title: Text("Home"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) =>
                      (DashboardClient())));
            },
          ),

          Container(
            child: ListTile(
                leading: Icon(Icons.person_outline),
                title: Text('Mon profil'),
                onTap: () async {
                  final prefs =await SharedPreferences.getInstance();
                  final String? userId =prefs.getString('userId');
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              (ProfilePage(userId))));

                }),
          ),
          ListTile(
              leading: Icon(Icons.add),
              title: Text('Ajouter livraison'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/Addlivraison");

              }),
          ListTile(
              leading: Icon(Icons.list_alt),
              title: Text('Mes demandes'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/DemandeClient");

              }),
          ListTile(
              leading: Icon(Icons.library_add_check),
              title: Text('Les Offers'),
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => LivraisonOffers()));

              }),



          ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Mes livraisons'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/LivraisonClient");

              }),
          ListTile(
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
   email =sharedPrefs?.getString('emailClient');
    userIdC =sharedPrefs?.getString('userId');


}


  

