import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer.dart';

class livreur extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('livreur'),
      ),
      drawer: createDrawer(context),
      body: Container(
        child: Center(
            child:
            Text("Hello livreur", style: TextStyle(fontSize: 20))), // Center
      ), // Container
    );
  }
} // Scaffold