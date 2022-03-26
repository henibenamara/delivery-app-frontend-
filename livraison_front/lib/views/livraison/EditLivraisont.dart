import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';

class EditDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: createDrawer(context),
      body: Container(
        child: Center(
            child:
            Text("Hello edit list livraisson", style: TextStyle(fontSize: 20))), // Center
      ), // Container
    );
  }
} // Scaffold
