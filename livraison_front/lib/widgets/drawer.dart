import 'package:flutter/material.dart';

Widget createDrawer(BuildContext context) {

  return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          Container(
            color: Theme.of(context).canvasColor,
            child: DrawerHeader(
              child: Text(
                'Navigation Drawer',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          ),
          ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('livreur'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/livreur");
              }),
          ListTile(
              leading: Icon(Icons.pie_chart),
              title: Text('responsable'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/responsable");
              }),
          ListTile(
              leading: Icon(Icons.category),
              title: Text('client'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/client");
              }),
          ListTile(
              leading: Icon(Icons.category),
              title: Text('livraison'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/livraison");
              }),
          ListTile(
              leading: Icon(Icons.monetization_on),
              title: Text('Add livraison'),
              onTap: () {
                Navigator.pushReplacementNamed(context, "/Addlivraison");
              }),
        ],
      ));
}