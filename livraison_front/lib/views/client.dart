import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_livraison/models/user.dart';

import '../widgets/drawer.dart';

class client extends StatelessWidget {


  client( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client'),
      ),
      drawer: createDrawer(context),
      body: Container(
        child: Center(
            child:
            Text("Hello client ", style: TextStyle(fontSize: 20))), // Center
      ), // Container
    );
  }
} // Scaffold