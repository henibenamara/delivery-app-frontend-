

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:front_livraison/constant/app_constants.dart';

import 'package:http/http.dart' as http;

import '../../widgets/background.dart';
import 'login.dart';

enum Role { client, livreur }

class RegisterScreen extends StatefulWidget {
  signup createState() => signup();
}

class signup extends State<RegisterScreen> {

  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
                title: Text(title),
                content: Text(text),


            ),

      );
  String? _dropDownValue;

  TextEditingController nom = TextEditingController();
  TextEditingController prenom = TextEditingController();
  TextEditingController Telephone = TextEditingController();
  TextEditingController Adresse = TextEditingController();
  TextEditingController Email = TextEditingController();
  TextEditingController Mdp = TextEditingController();
  TextEditingController Cin = TextEditingController();
  TextEditingController Marque = TextEditingController();
  TextEditingController Matricule = TextEditingController();

  String? selectedItem = "Walmart";
  Role? _role;
  bool _livreurFieldVisible = false;

  void handleSelection(Role? value) {
    setState(() {
      _role = value;
      _livreurFieldVisible = value == Role.livreur;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery
        .of(context)
        .size;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Background(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Container(
                alignment: Alignment.centerLeft,
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Text(
                  "REGISTER",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF2661FA),
                      fontSize: 36),
                  textAlign: TextAlign.left,
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: nom,
                  decoration: InputDecoration(labelText: "nom"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: prenom,
                  decoration: InputDecoration(labelText: "prenom"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: Telephone,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(labelText: "Telephone"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: Adresse,
                  decoration: InputDecoration(labelText: "Adresse "),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: Email,
                  decoration: InputDecoration(labelText: "Email"),
                ),
              ),
              SizedBox(height: size.height * 0.03),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: TextField(
                  controller: Mdp,
                  decoration: InputDecoration(labelText: "Mot de passe"),
                  obscureText: true,
                ),
              ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: RadioListTile(
                  title: const Text('client'),
                  value: Role.client,
                  groupValue: _role,
                  onChanged: handleSelection,
                ),
              ),
              Container(
                alignment: Alignment.center,
                margin: EdgeInsets.symmetric(horizontal: 40),
                child: RadioListTile(
                  title: const Text('livreur'),
                  value: Role.livreur,
                  groupValue: _role,
                  onChanged: handleSelection,
                ),
              ),
              if (_livreurFieldVisible)
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: Cin,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: "Cin"),
                  ),
                ),
              if (_livreurFieldVisible) SizedBox(height: size.height * 0.05),
              if (_livreurFieldVisible)
                Container(
                  /**CONTROLLERUR DE LA MARQUE **/
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: DropdownButton<String>(
                        hint: _dropDownValue == null
                            ? Text('Marque')
                            : Text(
                          _dropDownValue!,
                          style: TextStyle(color: Colors.blue),
                        ),
                        isExpanded: true,
                        iconSize: 30.0,
                        style: TextStyle(color: Colors.blue),
                        items: ['citroen', 'volkswagen', 'peugeot'].map(
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
              if (_livreurFieldVisible) SizedBox(height: size.height * 0.05),
              if (_livreurFieldVisible)
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(horizontal: 40),
                  child: TextField(
                    controller: Matricule,
                    decoration: InputDecoration(labelText: "Matricule"),
                  ),
                ),
              SizedBox(height: size.height * 0.05),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: RaisedButton(
                  onPressed: () {
                    if (_role!.toString() == "Role.client") {
                      userRegister(
                          nom.text,
                          prenom.text,
                          Telephone.text,
                          Adresse.text,
                          Email.text,
                          Mdp.text,
                          Cin.text,
                          _role!.toString(),
                          "",
                          "");
                    } else {
                      userRegister(
                          nom.text,
                          prenom.text,
                          Telephone.text,
                          Adresse.text,
                          Email.text,
                          Mdp.text,
                          Cin.text,
                          _role!.toString(),
                          Matricule.text,
                          _dropDownValue!);
                    }
                    /** Navigator.pushNamed(context, '/LoginScreen');**/

                    /** print(
                        '--------------------- $name, $firstName , $tel , $adresse , $email , $mdp , $cin,$role,$mat,$marque');
                        userRegister(
                        nom.text,
                        prenom.text,
                        Telephone.text,
                        Adresse.text,
                        Email.text,
                        Mdp.text,
                        Cin.text,
                        _role!.toString(),
                        Matricule.text,
                        _dropDownValue!);**/
                  },
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(80.0)),
                  textColor: Colors.white,
                  padding: const EdgeInsets.all(0),
                  child: Container(
                    alignment: Alignment.center,
                    height: 50.0,
                    width: size.width * 0.5,
                    decoration: new BoxDecoration(
                        borderRadius: BorderRadius.circular(80.0),
                        gradient: new LinearGradient(colors: [
                          Color.fromARGB(255, 255, 136, 34),
                          Color.fromARGB(255, 255, 177, 41)
                        ])),
                    padding: const EdgeInsets.all(0),
                    child: Text(
                      "SIGN UP",
                      textAlign: TextAlign.center,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
              Container(
                alignment: Alignment.centerRight,
                margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                child: GestureDetector(
                  onTap: () =>
                  {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => LoginScreen()))
                  },
                  child: Text(
                    "Already Have an Account? Sign in",
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF2661FA)),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  Future<void> userRegister(String nom,
      String prenom,
      String Telephone,
      String Adresse,
      String Email,
      String Mdp,
      String Cin,
      String role,
      String Matricule,
      String marque) async {
    var url = "";

    var data;
    if (role == "Role.client") {
      url = "client";
      data = {
        "nom": nom,
        "prenom": prenom,
        "clientTel": Telephone,
        "clientAdresse": Adresse,
        "email": Email,
        "password": Mdp
      };
    } else {
      url = "livreur";
      data = {
        "nom": nom,
        "prenom": prenom,
        "livTelephone": Telephone,
        "livAdresse": Adresse,
        "email": Email,
        "password": Mdp,
        "livcin": Cin,
        "livMarqVecu": _dropDownValue!,
        "livMatVecu": Matricule,
      };
    }
    print("$url");
    var res = await http.post(
      Uri.parse(AppConstants.API_URL+'/api/auth/register/$url'),
      headers: {
        "content-type": "application/json",
        "accept": "application/json",
        "Access-Control-Allow-Origin": "*",
        // Required for CORS support to work
        "Access-Control-Allow-Headers":
        "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
        "Access-Control-Allow-Methods": "POST, OPTIONS"
      },
      body: json.encode(data),
    );
    print(data);
    print(res.body);
    print(res.headers);
    if (res.statusCode == 201) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      print("ok");
      debugPrint('register success');
      displayDialog(context, "felicitation",
          "votre compte est creer avec succes");

      Navigator.of(context).pushNamed('/');
    } else {
      print("error");
      // If the server did not return a 200 OK response,
      // then throw an exception.
      throw Exception('Failed to load album');
    }
  }
}