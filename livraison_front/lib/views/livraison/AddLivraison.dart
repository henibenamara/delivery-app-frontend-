import 'dart:math';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:livraison_front/views/livraison/uploadphotoLivraison.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../models/livraison.dart';
import '../../services/livraisonService.dart';
import '../../widgets/drawer_client.dart';
import 'package:date_field/date_field.dart';

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

  final _adressdesController = TextEditingController();
  final _addressexpController = TextEditingController();
  final _dateController = TextEditingController();
  TextEditingController dateinput = TextEditingController();

  final _desColisController = TextEditingController();
  final _poidsColisController = TextEditingController();
  String? _dropDownValue;

  File? imageFile;
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

                        SizedBox(height: size.height * 0.03),
                        Container(

                          child: Center(
                            child: TextField(
                              controller: _adressdesController,
                              decoration: const InputDecoration(
                                labelText: 'Adresse destinataire',
                                icon: Icon(Icons.airplanemode_on_sharp),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                          child: Center(

                            child: TextField(
                              controller: _addressexpController,
                              decoration: const InputDecoration(
                                labelText: 'Address expeditaire',
                                icon: Icon(Icons.add_location_alt),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(
                            child:Center(
                                child:TextField(
                                  controller: dateinput,
                                  decoration: InputDecoration(
                                      icon: Icon(Icons.calendar_today),
                                      labelText: "date de livraison"
                                  ),
                                  readOnly: true,
                                  onTap: () async {
                                    DateTime? pickedDate = await showDatePicker(
                                        context: context, initialDate: DateTime.now(),
                                        firstDate: DateTime(2000),
                                        lastDate: DateTime(2101)
                                    );

                                    if(pickedDate != null ){
                                      print(pickedDate);
                                      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
                                      print(formattedDate);

                                      setState(() {
                                        dateinput.text = formattedDate;
                                      });
                                    }else{
                                      print("Date is not selected");
                                    }
                                  },
                                )
                            ),

                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(

                          child: Center(
                            child: TextField(
                              controller: _desColisController,
                              decoration: const InputDecoration(
                                icon: Icon(Icons.description_rounded),
                                labelText: 'Description colis ',
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Center(
                          child: Container(

                            child: TextField(
                              keyboardType: TextInputType.number,
                              controller: _poidsColisController,
                              decoration: const InputDecoration(
                                labelText: 'Poid de colis en Kg ',
                                icon: Icon(Icons.work_outlined),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: size.height * 0.03),
                        Container(

                          /**CONTROLLERUR DE LA TYPE **/

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
                                })),
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
                                      dateDeLivraison: dateinput.text,
                                      typeColis: _dropDownValue,
                                      DesColis: _desColisController.text,
                                      poidsColis:
                                          int.parse(_poidsColisController.text),
                                      etatLivraison: 'non livrée',
                                      idClient: userId.toString(),
                                      imageUrl:  "t.png"

                                    );
                                    print(
                                        'livraison is :${livraison.toString()}');
                                    api.addNewLivraison(livraison);
                                    showTopSnackBar(
                                      context,
                                      CustomSnackBar.success(
                                        message:
                                        "Votre Livraison est creer avec succee",
                                      ),
                                    );
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => uploadphotoLiv(livraison)));
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
