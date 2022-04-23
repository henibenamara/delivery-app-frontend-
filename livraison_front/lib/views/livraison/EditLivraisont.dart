import 'dart:math';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../models/livraison.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer_client.dart';
import 'DemandeLivraisonCLient.dart';

class EditLivraison extends StatefulWidget {
  EditLivraison(this.livraison);
  final Livraison livraison;

  @override
  _EditLivraison createState() => _EditLivraison();
}

class _EditLivraison extends State<EditLivraison> {
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    final LivraisonService api = LivraisonService();

    final _adressdesController =
        TextEditingController(text: widget.livraison.adressseDes.toString());
    final _addressexpController =
        TextEditingController(text: widget.livraison.adresseExp.toString());
    final _dateController = TextEditingController(
        text: widget.livraison.dateDeLivraison.toString());
    final _desColisController =
        TextEditingController(text: widget.livraison.DesColis.toString());
    final _poidsColisController =
        TextEditingController(text: widget.livraison.poidsColis.toString());

    return Scaffold(
        drawer: clientDrawer(context),
        appBar: AppBar(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.green,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        body: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: GestureDetector(
              onTap: () {
                FocusScope.of(context).unfocus();
              },
              child: ListView(
                children: [
                  Text(
                    "modifier Livraison",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                  ),
                  buildTextField(
                      "Adresse destinataire",
                      widget.livraison.adressseDes.toString(),
                      _adressdesController),
                  buildTextField(
                      "Address expeditaire",
                      widget.livraison.adresseExp.toString(),
                      _addressexpController),
                  buildTextField(
                      "Date de livraison",
                      widget.livraison.dateDeLivraison.toString(),
                      _dateController),
                  buildTextField(
                      "Description colis",
                      widget.livraison.DesColis.toString(),
                      _desColisController),
                  buildTextField(
                      "Poid de colis",
                      widget.livraison.poidsColis.toString(),
                      _poidsColisController),
                  SizedBox(
                    height: 35,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      OutlineButton(
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        onPressed: () {},
                        child: Text("CANCEL",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.black)),
                      ),
                      RaisedButton(
                        onPressed: () async {
                          String adressseDes = _adressdesController.text;
                          String adresseExp = _addressexpController.text;
                          String dateDeLivraison = _dateController.text;

                          String? sId = widget.livraison.sId;
                          String DesColis = _desColisController.text;
                          int poidsColis =
                              int.parse(_poidsColisController.text);

                          api.updateLivraisonALl(sId, adressseDes, adresseExp,
                              dateDeLivraison, DesColis, poidsColis);

                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DemandeClient()));
                        },
                        color: Colors.green,
                        padding: EdgeInsets.symmetric(horizontal: 50),
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(
                          "SAVE",
                          style: TextStyle(
                              fontSize: 14,
                              letterSpacing: 2.2,
                              color: Colors.white),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            )));
  }

  Widget buildTextField(
      String labelText, String placeholder, TextEditingController controlleur) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        controller: controlleur,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }
}
