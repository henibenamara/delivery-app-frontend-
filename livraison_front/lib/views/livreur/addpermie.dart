import 'dart:math';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livraison_front/services/clientService.dart';
import 'package:livraison_front/services/livreurService.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../models/client.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer_client.dart';
import 'addCarteGrise.dart';


class addpermie extends StatefulWidget {
  addpermie(this.cin);
  final String cin;

  @override
  _addpermie createState() => _addpermie();
}

class _addpermie extends State<addpermie> {
  _addpermie();
  String? sId;
  String? _dropDownValue1;
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    final LivreurService api = LivreurService();
    final _addFormKey = GlobalKey<FormState>();

    Size size = MediaQuery.of(context).size;
    return Scaffold(

      appBar: AppBar(
        title: Text('permie Photo'),
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
                            width: 300,
                            height: 300,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              image: DecorationImage(
                                  image: FileImage(imageFile!), fit: BoxFit.cover),
                              border: Border.all(width: 8, color: Colors.black),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                          )
                        else
                          Container(
                            width: 300,
                            height: 300,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              border: Border.all(width: 8, color: Colors.black12),
                              borderRadius: BorderRadius.circular(100.0),
                            ),
                            child: const Text(
                              'Image field',
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
                                  onPressed: () =>
                                      getImage(source: ImageSource.camera),
                                  child: const Text('Capture Image',
                                      style: TextStyle(fontSize: 18))),
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            Expanded(
                              child: ElevatedButton(
                                  onPressed: () =>
                                      getImage(source: ImageSource.gallery),
                                  child: const Text('Select Image',
                                      style: TextStyle(fontSize: 18))),
                            )
                          ],
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () async {

                                  if (_addFormKey.currentState!.validate()) {
                                    _addFormKey.currentState?.save();



                                    api.permis(imageFile!,widget.cin.toString());
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.success(
                                        message:
                                        "photo de permie ajouter",
                                      ),
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => addCarteGrise(widget.cin.toString())));
                                  }
                                },
                                child: Text('valider',
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.blue,
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
        maxWidth: 300,
        maxHeight: 300,
        imageQuality: 70 //0 - 100
    );

    if (file?.path != null) {
      setState(() {
        imageFile = File(file!.path);
      });
    }
  }

}
