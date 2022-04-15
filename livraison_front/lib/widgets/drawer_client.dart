import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../services/clientService.dart';
import '../views/client/EditClient.dart';
import '../views/client/HomeClient.dart';


Widget clientDrawer(BuildContext context) {

  return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[

          Container(

            color: Theme.of(context).canvasColor,
            child: DrawerHeader(
              child: Text(
                'Client',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
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