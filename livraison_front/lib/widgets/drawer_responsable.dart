import 'package:flutter/material.dart';


Widget ResponsableDrawer(BuildContext context) {

  return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Theme.of(context).canvasColor,
            child: DrawerHeader(
              child: Text(
                'Responsable Drawer',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
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


        ],
      ));
}