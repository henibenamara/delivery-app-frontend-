import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../views/livreur/HomeLivreur.dart';
Widget livreurDrawer(BuildContext context) {

  return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Theme.of(context).canvasColor,
            child: DrawerHeader(
              child: Text(
                'Livreur',
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
              leading: Icon(Icons.monetization_on),
              title: Text('Historique'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/LivraisonLivreur");

              }),
          ListTile(
              leading: Icon(Icons.add),
              title: Text('liste livraison'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/livreurReq");

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