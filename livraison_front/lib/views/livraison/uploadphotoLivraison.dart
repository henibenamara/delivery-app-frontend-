import 'dart:math';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../models/livraison.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer_client.dart';
import 'DemandeLivraisonCLient.dart';

class uploadphotoLiv extends StatefulWidget {
  uploadphotoLiv(this.livraison);
  final Livraison livraison;

  @override
  _uploadphotoLiv createState() => _uploadphotoLiv();
}

class _uploadphotoLiv extends State<uploadphotoLiv> {
  _uploadphotoLiv();
  String? sId;
  String? _dropDownValue1;
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    final LivraisonService api = LivraisonService();
    final _addFormKey = GlobalKey<FormState>();

    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: clientDrawer(context),
      appBar: AppBar(
        title: Text('upload photo'),
      ),
      body: Form(
        key: _addFormKey,
        child: SingleChildScrollView(
          child: Container(
              padding: EdgeInsets.all(20.0),
              child: Card(
                  child: Container(
                padding: EdgeInsets.all(10.0),
                width: 440,
                child: Column(
                  children: <Widget>[

                    if (imageFile != null)
                      Container(
                        width: 400,
                        height: 400,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          image: DecorationImage(
                              image: FileImage(imageFile!), fit: BoxFit.cover),
                          border: Border.all(width: 8, color: Colors.black),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                      )
                    else
                      Container(
                        width: 400,
                        height: 400,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.grey,
                          border: Border.all(width: 8, color: Colors.black12),
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: const Text(
                          'Image de Colis',
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                primary: Colors.purple,
                                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                              ),
                              onPressed: () =>
                                  getImage(source: ImageSource.camera),
                              child: const Text('camera',
                                  style: TextStyle(fontSize: 18))),
                        ),
                        const SizedBox(
                          width: 20,
                        ),

                        Expanded(
                          child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                  primary: Colors.white,
                                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                                  ),
                              onPressed: () =>
                                  getImage(source: ImageSource.gallery),
                              child: const Text('gallerie',
                                  style: TextStyle(fontSize: 18,color: Colors.purple))),
                        )
                      ],
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            color: Colors.purpleAccent,
                            padding: EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(Radius.circular(16.0))),
                            splashColor: Colors.red,
                            onPressed: () async {

                              if (_addFormKey.currentState!.validate()) {
                                _addFormKey.currentState?.save();



                                api.upload(imageFile!,widget.livraison.numLivraison);
                                showTopSnackBar(
                                  context,
                                  CustomSnackBar.success(
                                    message:
                                    "Photo ajouter avec succès",
                                  ),
                                );
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            DemandeClient()));
                              }
                            },
                            child: Text('valider',
                                style: TextStyle(color: Colors.white,fontSize: 20)),

                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ))),
        ),
      ),
    );
  }

  void getImage({required ImageSource source}) async {
    final file = await ImagePicker().pickImage(
        source: source,
        maxWidth: 640,
        maxHeight: 480,
        imageQuality: 70 //0 - 100
        );

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }

}
