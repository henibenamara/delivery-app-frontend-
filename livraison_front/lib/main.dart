import 'package:flutter/material.dart';
import 'package:livraison_front/views/auth/login.dart';
import 'package:livraison_front/views/camera.dart';
import 'package:livraison_front/views/client.dart';
import 'package:livraison_front/views/client/clientList.dart';
import 'package:livraison_front/views/livraison/AddLivraison.dart';
import 'package:livraison_front/views/livraison/livraisonList.dart';
import 'package:livraison_front/views/livraisonRequest.dart';
import 'package:livraison_front/views/livreur.dart';
import 'package:livraison_front/views/resp.dart';


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
          '/': (context) => takephoto(),

          //'/client': (context) => client(),
          '/livreur': (context) => livreur(),
          '/livraison': (context) => const LivraisonPage(),
          '/Addlivraison': (context) => AddLivraisonWidget(),
           '/responsable' : (context) => responsable(),
          '/client' : (context) => const ClientPage(),
          '/livreur' : (context) => LivraisonRequest(),
          '/clientHome' : (context) => client(),


        },
      ),
    );
  }
}
