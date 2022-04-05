import 'package:flutter/material.dart';


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