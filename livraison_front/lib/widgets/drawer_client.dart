import 'package:flutter/material.dart';


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
          ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Historique'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/LivraisonClient");

              }),
          ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Add livraison'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/Addlivraison");

              }),
          ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text(''),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/Addlivraison");

              }),

        ],
      ));
}