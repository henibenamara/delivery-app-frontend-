import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:livraison_front/widgets/drawer_responsable.dart';

import '../../widgets/drawer.dart';
import '../../widgets/drawer_client.dart';

class EditDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      drawer: ResponsableDrawer(context),
      body: Container(
        child: Center(
            child:
            Text("Hello edit client", style: TextStyle(fontSize: 20))), // Center
      ), // Container
    );
  }
} // Scaffold
