import 'dart:math';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
  _EditLivraison();

  String? _dropDownValue1;
  File? imageFile;
  @override
  Widget build(BuildContext context) {
    final LivraisonService api = LivraisonService();
    final _addFormKey = GlobalKey<FormState>();
    final _numController =
        TextEditingController(text: widget.livraison.numLivraison.toString());
    final _adressdesController =
        TextEditingController(text: widget.livraison.adressseDes.toString());
    final _addressexpController =
        TextEditingController(text: widget.livraison.adresseExp.toString());
    final _dateController = TextEditingController(
        text: widget.livraison.dateDeLivraison.toString());
    final _typeColisController =
        TextEditingController(text: widget.livraison.typeColis.toString());
    final _desColisController =
        TextEditingController(text: widget.livraison.DesColis.toString());
    final _poidsColisController =
        TextEditingController(text: widget.livraison.poidsColis.toString());
    String? _dropDownValue;
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: clientDrawer(context),
      appBar: AppBar(
        title: Text('modifier livraison'),
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
                    /** Container(
                          /**CONTROLLERUR DE LA TYPE **/
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            child: DropdownButton<String>(

                                hint: _dropDownValue == null
                                    ? Text('Type colis')
                                    : Text(
                                  _dropDownValue!,
                                  style: TextStyle(color: Colors.blue),
                                ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: Colors.blue),
                                items: ['fragile', 'solide', 'liquide'].map(
                                      (val) {
                                    return DropdownMenuItem<String>(
                                      value: val,
                                      child: Text(val),
                                    );
                                  },
                                ).toList(),
                                onChanged: (val) {
                                  setState(
                                        () {
                                      _dropDownValue = val!;
                                    },
                                  );
                                })),*/
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        readOnly: true,
                        controller: _numController,
                        decoration: const InputDecoration(
                          labelText: 'numero :',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: _adressdesController,
                        decoration: const InputDecoration(
                          labelText: 'Adresse destinataire',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: _addressexpController,
                        decoration: const InputDecoration(
                          labelText: 'Address expeditaire',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: _dateController,
                        decoration: const InputDecoration(
                          labelText: 'Date de livraison',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        controller: _desColisController,
                        decoration: const InputDecoration(
                          labelText: 'Description colis ',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      alignment: Alignment.center,
                      margin: EdgeInsets.symmetric(horizontal: 40),
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        controller: _poidsColisController,
                        decoration: const InputDecoration(
                          labelText: 'Poid de colis en Kg ',
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    SizedBox(height: size.height * 0.03),
                    Container(
                      margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                      child: Column(
                        children: <Widget>[
                          RaisedButton(
                            splashColor: Colors.red,
                            onPressed: () async {
                              if (_addFormKey.currentState!.validate()) {
                                _addFormKey.currentState?.save();

                                String adressseDes = _adressdesController.text;
                                String adresseExp = _addressexpController.text;
                                String dateDeLivraison = _dateController.text;

                                String? sId = widget.livraison.sId;
                                String DesColis = _desColisController.text;
                                int poidsColis =
                                    int.parse(_poidsColisController.text);

                                api.updateLivraisonALl(
                                    sId,
                                    adressseDes,
                                    adresseExp,
                                    dateDeLivraison,
                                    DesColis,
                                    poidsColis);

                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => DemandeClient()));
                              }
                            },
                            child: Text('modifier',
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
}
