import 'package:flutter/material.dart';
import 'package:livraison_front/views/auth/login.dart';
import 'package:livraison_front/views/camera.dart';
import 'package:livraison_front/views/client.dart';
import 'package:livraison_front/views/client/EditClient.dart';
import 'package:livraison_front/views/client/clientList.dart';
import 'package:livraison_front/views/livraison/AddLivraison.dart';
import 'package:livraison_front/views/livraison/DemandeLivraisonCLient.dart';
import 'package:livraison_front/views/livraison/LivraisonEncours.dart';
import 'package:livraison_front/views/livraison/LivraisonListAdmin.dart';
import 'package:livraison_front/views/livraison/LivraisonListByClient.dart';
import 'package:livraison_front/views/livraison/LivraisonListBylivreur.dart';
import 'package:livraison_front/views/livraison/livraisonList.dart';
import 'package:livraison_front/views/livraisonRequest.dart';
import 'package:livraison_front/views/livreur.dart';
import 'package:livraison_front/views/livreur/livreurList.dart';
import 'package:livraison_front/views/onBoarding.dart';
import 'package:livraison_front/views/resp.dart';
import 'package:livraison_front/views/responsable/demandeLivraison.dart';
import 'package:livraison_front/views/responsable/demandeLivreur.dart';

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
        initialRoute: '/OnBoardingPage',
        routes: {
          '/OnBoardingPage':(context)=>OnBoardingPage(),
          '/': (context) => LoginScreen(),
          '/livreur': (context) => livreur(),
          '/DemandeLivraison': (context) => DemandeLivraison(),
          '/livraison': (context) => const LivraisonPage(),
          '/Addlivraison': (context) => AddLivraisonWidget(),
          '/responsable': (context) => responsable(),
          '/client': (context) => const ClientPage(),
          '/livreurReq': (context) => LivraisonRequest(),
          '/clientHome': (context) => client(),
          '/LivraisonClient': (context) => LivraisonClient(),
          '/LivreurPage': (context) => LivreurPage(),
          '/LivraisonLivreur': (context) => LivraisonLivreur(),
          '/LivraisonAdmin': (context) => LivraisonAdmin(),
          '/DemandeClient': (context) => DemandeClient(),
          '/livraisonEncours': (context) => LivraisonEnCours(),
          '/DemandeLivreur':(context)=> DemandeLivreur()
        },
      ),
    );
  }
}
