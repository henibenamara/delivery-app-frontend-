import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../widgets/drawer.dart';
import '../../widgets/drawer_client.dart';

class EditDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: clientDrawer(context),
      body: Container(
        child: Center(
            child:
            Text("Hello edit list livraisson", style: TextStyle(fontSize: 20))), // Center
      ), // Container
    );
  }
} // Scaffold
