import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../widgets/drawer_client.dart';

class client extends StatelessWidget {


  client( {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Client'),
      ),
      drawer: clientDrawer(context),
      body: Container(
        child: Center(
            child:
            Text("Hello client ", style: TextStyle(fontSize: 20))), // Center
      ), // Container
    );
  }
} // Scaffold