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
              leading: Icon(Icons.person_outline),
              title: Text('livreur'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/livreur");
              }),
          ListTile(
              leading: Icon(Icons.person),
              title: Text('list client'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/client");
              }),

          ListTile(
              leading: Icon(Icons.add_shopping_cart),
              title: Text('livraison'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/livraison");
              }),


        ],
      ));
}