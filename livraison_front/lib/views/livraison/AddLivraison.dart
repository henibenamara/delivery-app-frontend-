import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:front_livraison/models/livraison.dart';
import 'package:front_livraison/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../services/livraisonService.dart';
import '../../widgets/drawer.dart';

class AddLivraisonWidget extends StatefulWidget {



  AddLivraisonWidget({Key? key}) : super(key: key);

  @override
  _AddLivraisonWidget createState() => _AddLivraisonWidget();
}

class _AddLivraisonWidget extends State<AddLivraisonWidget> {
  _AddLivraisonWidget();

  final LivraisonService api = LivraisonService();
  final _addFormKey = GlobalKey<FormState>();
  final _numController = TextEditingController();
  final _adressdesController = TextEditingController();
  final _addressexpController = TextEditingController();
  final _dateController = TextEditingController();
  final _typeColisController = TextEditingController();
  final _desColisController = TextEditingController();
  final _poidsColisController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: createDrawer(context),
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
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _numController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  hintText: 'numero ',
                                ),
                                validator: (value) {
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _adressdesController,
                                decoration: const InputDecoration(
                                  hintText: 'adresse des',
                                ),
                                validator: (value) {
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _addressexpController,
                                decoration: const InputDecoration(
                                  hintText: 'Address expe',
                                ),
                                validator: (value) {
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _dateController,
                                decoration: const InputDecoration(
                                  hintText: 'date de livraison',
                                ),
                                validator: (value) {
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _typeColisController,
                                decoration: const InputDecoration(
                                  hintText: 'Type colis ',
                                ),
                                validator: (value) {
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _desColisController,
                                decoration: const InputDecoration(
                                  hintText: 'Description colis ',
                                ),
                                validator: (value) {
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              TextFormField(
                                controller: _poidsColisController,
                                decoration: const InputDecoration(
                                  hintText: 'poids colis ',
                                ),
                                validator: (value) {
                                  return null;
                                },
                                onChanged: (value) {},
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 10),
                          child: Column(
                            children: <Widget>[
                              RaisedButton(
                                splashColor: Colors.red,
                                onPressed: () async{
                                  final prefs = await SharedPreferences.getInstance();
                                  final String? userId = prefs.getString('userId');
                                  print('userId is : $userId');
                                  if (_addFormKey.currentState!.validate()) {
                                    _addFormKey.currentState?.save();
                                    api.addNewLivraison(
                                        Livraison(
                                        numLivraison:
                                            int.parse(_numController.text),
                                        adressseDes: _adressdesController.text,
                                        adresseExp: _addressexpController.text,
                                        dateDeLivraison: _dateController.text,
                                        typeColis: _typeColisController.text,
                                        DesColis :_desColisController.text,
                                        poidsColis:int.parse(_poidsColisController.text),idClient: userId
                                    ));

                                    Navigator.pop(context);
                                  }
                                },
                                child: Text('Save',
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
