import 'package:flutter/material.dart';
import 'package:front_livraison/views/auth/login.dart';
import 'package:front_livraison/views/client.dart';
import 'package:front_livraison/views/client/clientList.dart';
import 'package:front_livraison/views/livraison/AddLivraison.dart';
import 'package:front_livraison/views/livraison/DetailLivraison.dart';
import 'package:front_livraison/views/livraison/livraisonList.dart';
import 'package:front_livraison/views/livreur.dart';
import 'package:front_livraison/views/livreur/livreurList.dart';
import 'package:front_livraison/views/resp.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => LoginScreen(),
          //'/client': (context) => client(),
          '/livreur': (context) => livreur(),
          '/livraison': (context) => LivraisonPage(),
          '/Addlivraison': (context) => AddLivraisonWidget(),
           '/responsable' : (context) => responsable(),
          '/client' : (context) => ClientPage(),
          '/livreur' : (context) => LivreurPage(),



        },
      ),
    );
  }
}
