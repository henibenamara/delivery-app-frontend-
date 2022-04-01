import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/livraison.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer.dart';
import '../../widgets/drawer_client.dart';
import '../../widgets/drawer_responsable.dart';

class AddLivraisonWidget extends StatefulWidget {
  AddLivraisonWidget({Key? key}) : super(key: key);

  @override
  _AddLivraisonWidget createState() => _AddLivraisonWidget();
}

class _AddLivraisonWidget extends State<AddLivraisonWidget> {
  _AddLivraisonWidget();

  Random random = new Random();
  final LivraisonService api = LivraisonService();
  final _addFormKey = GlobalKey<FormState>();
  final _numController = TextEditingController();
  final _adressdesController = TextEditingController();
  final _addressexpController = TextEditingController();
  final _dateController = TextEditingController();
  final _typeColisController = TextEditingController();
  final _desColisController = TextEditingController();
  final _poidsColisController = TextEditingController();
  String? _dropDownValue;
  String? _dropDownValue1;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: clientDrawer(context),
      appBar: AppBar(
        title: Text('Add livraison'),
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
                        Container(
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
                                items: ['type 1', 'type 2', 'type3'].map(
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
                                })),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          alignment: Alignment.center,
                          margin: EdgeInsets.symmetric(horizontal: 40),
                          child: TextField(
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
                          child: TextField(
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
                          child: TextField(
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
                          child: TextField(
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
                          child: TextField(
                            keyboardType: TextInputType.number,
                            controller: _poidsColisController,
                            decoration: const InputDecoration(
                              labelText: 'Poid de colis en Kg ',
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                            /**CONTROLLERUR d'etat  **/
                            alignment: Alignment.center,
                            margin: EdgeInsets.symmetric(horizontal: 40),
                            child: DropdownButton<String>(
                                hint: _dropDownValue1 == null
                                    ? Text('Etat livraison')
                                    : Text(
                                        _dropDownValue1!,
                                        style: TextStyle(color: Colors.blue),
                                      ),
                                isExpanded: true,
                                iconSize: 30.0,
                                style: TextStyle(color: Colors.blue),
                                items: [
                                  'non livrée',
                                  'en cours de livraison',
                                  'livraison livrée'
                                ].map(
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
                                      _dropDownValue1 = val!;
                                    },
                                  );
                                })),
                        SizedBox(height: size.height * 0.03),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () async {
                                  final prefs =
                                      await SharedPreferences.getInstance();
                                  final String? userId =
                                      prefs.getString('userId');
                                  print('userId is : $userId');
                                  if (_addFormKey.currentState!.validate()) {
                                    _addFormKey.currentState?.save();
                                    var livraison = Livraison(
                                        numLivraison: random.nextInt(10000),
                                        adressseDes: _adressdesController.text,
                                        adresseExp: _addressexpController.text,
                                        dateDeLivraison: _dateController.text,
                                        typeColis: _dropDownValue,
                                        DesColis: _desColisController.text,
                                        poidsColis: int.parse(
                                            _poidsColisController.text),
                                        etatLivraison:_dropDownValue1,
                                        idClient: userId);
                                    print(
                                        'livraison is :${livraison.toString()}');
                                    api.addNewLivraison(livraison);
                                  }
                                },
                                child: Text('Ajouter',
                                    style: TextStyle(color: Colors.white)),
                                color: Colors.blue,
                              )
                            ],
                          ),
                        ),
                      ],
                    ))),
          ),
        ),
      ),
    );
  }
}
