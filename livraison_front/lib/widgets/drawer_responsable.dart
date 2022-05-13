import 'package:flutter/material.dart';
import 'package:livraison_front/services/ResponsableService.dart';
import 'package:livraison_front/views/responsable/dashboardAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../constant/app_constants.dart';
SharedPreferences? sharedPrefs;
String? email;
String? id;

Widget ResponsableDrawer(BuildContext context) {
  return Drawer(
      child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[

      Container(
        height: 600,
        child: FutureBuilder(
            future: _getPrefs(),
            builder: (context, snapshot) {
              return FutureBuilder(
                  future: ResponsableService().getAdminByIdUSer(id),
                  builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                    if (snapshot.hasData) {
                      return ListView.builder(
                          itemCount: snapshot.data?.length,
                          itemBuilder: (BuildContext context, int index) {
                            String url = AppConstants.API_URL +
                                "/" +
                                snapshot.data![index]['image'];
                            String? nom = snapshot.data![index]['nom'];
                            String? prenom = snapshot.data![index]['prenom'];
                            String? email =
                                snapshot.data![index]['userId']['email'];
                            print(email);

                            return Container(
                              child: Column(children: <Widget>[
                                UserAccountsDrawerHeader(
                                    accountName: Text("${nom}  ${prenom}"),
                                    accountEmail: Text(email!),
                                    currentAccountPicture: CircleAvatar(
                                      backgroundImage:
                                          NetworkImage(url.toString()),
                                    )),
                                ListTile(
                                    leading: Icon(Icons.list),
                                    title: Text('Dashboard'),
                                    onTap: ()  {

                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DashboardAdmin(snapshot.data![index]['image'],snapshot.data![index]['nom'],snapshot.data![index]['userId']['email'])));

                                    }),
                                ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text('Les demandes de livreur'),
                                    onTap: () {
                                      Navigator.pushReplacementNamed(context, "/DemandeLivreur");
                                    }),

                                ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text('list livreur'),
                                    onTap: () {
                                      Navigator.pushReplacementNamed(context, "/LivreurPage");
                                    }),
                                ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text('list Livraison'),
                                    onTap: () {
                                      Navigator.pushReplacementNamed(context, '/LivraisonAdmin');
                                    }),
                                ListTile(
                                    leading: Icon(Icons.person),
                                    title: Text('list client'),
                                    onTap: () {
                                      Navigator.pushReplacementNamed(context, "/client");
                                    }),
                                ListTile(
                                    leading: Icon(Icons.logout),
                                    title: Text('Déconnexion'),
                                    onTap: () {
                                      Navigator.pushReplacementNamed(context, "/");
                                    }),
                              ]),
                            );
                          });
                    } else {
                      return const Center(
                          child: Text("",
                              style: TextStyle(fontSize: 1))); // Center
                    }
                  });
            }),
      ),


    ],
  ));
}

Future<void> _getPrefs() async{
  sharedPrefs = await SharedPreferences.getInstance();
  email =sharedPrefs?.getString('adminEmail');
  id =sharedPrefs?.getString('adminId');

}