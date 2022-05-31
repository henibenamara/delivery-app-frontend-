
import 'package:barcode_widget/barcode_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:livraison_front/services/livraisonService.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import 'LivraisonEncours.dart';

class ScanScreen extends StatefulWidget {
  ScanScreen(this.id,this.numLivraison,this.idLivreur,this.etat,this.prix);
  final String?  numLivraison;
  final String?  id;
  final String?  idLivreur;
  final String?  etat;
  final String?  prix;
  @override
  _ScanScreenState createState() => _ScanScreenState();
}

class _ScanScreenState extends State<ScanScreen> {
  var qrstr = "le code qr !";
  var height,width;

  @override
  Widget build(BuildContext context) {

    height = MediaQuery
        .of(context)
        .size
        .height;
    width = MediaQuery
        .of(context)
        .size
        .width;
    return Scaffold(
        appBar: AppBar(
          title: Text('verfication Livraison'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             Column(
               children: [
                 Text("Scanner le code QR",style: TextStyle(color: Colors.black,fontSize: 25),),
                 Text("(dans la facture du client!)",style: TextStyle(color: Colors.red,fontSize: 15),),

               ],
             ),

              ElevatedButton(onPressed: scanQr, child:
              Text(('Scanner le qr code '))),
              SizedBox(height: width,)
            ],
          ),
        )
    );
  }


  Future <void>scanQr()async{
    try{
      FlutterBarcodeScanner.scanBarcode('#2A99CF', 'cancel', true, ScanMode.QR).then((value){
        if (value.toString() == widget.numLivraison.toString()) {
          LivraisonService().updateLivraison(
              widget.id.toString(),
              widget.idLivreur.toString(),
              widget.etat.toString(),
              widget.prix.toString());
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message:
              "bonne travail, cette livraison est livrer avec succées",
            ),
          );
           Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      LivraisonEnCours()));


        } else {
          showTopSnackBar(
              context,
          CustomSnackBar.error(
            message:
            "Code qr est n'est pas valide! ",
          ));
        }
      });
    }catch(e){
      setState(() {
        qrstr='unable to read this';
      });
    }
  }
}