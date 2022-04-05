import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer.dart';
import '../widgets/drawer_livreur.dart';

class livreur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('livreur'),
      ),
      drawer: livreurDrawer(context),
      body: Container(
        child: Center(
            child:
            Text("Hello livreur", style: TextStyle(fontSize: 20))), // Center
      ), // Container
    );
  }
} // Scaffold