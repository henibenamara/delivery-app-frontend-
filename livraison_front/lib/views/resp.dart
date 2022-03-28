import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../widgets/drawer.dart';
import '../widgets/drawer_responsable.dart';

class responsable extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('responsable'),
      ),
      drawer: ResponsableDrawer(context),
      body: Container(
        child: Center(
            child:
            Text("Hello responsable", style: TextStyle(fontSize: 20))), // Center
      ), // Container
    );
  }
} // Scaffold