import 'package:flutter/material.dart';
import 'package:livraison_front/models/livreur.dart';
import 'package:livraison_front/services/livreurService.dart';
import 'package:livraison_front/views/livreur/uploadphotoLivreur.dart';
import '../livreur.dart';



class EditProfileLivreur extends StatefulWidget {
  EditProfileLivreur(this.livreur);

  final Livreur  livreur;


  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfileLivreur>  {

  bool showPassword = false;
  @override
  Widget build(BuildContext context)  {
    final nomC = TextEditingController(text: widget.livreur.nom.toString());
    final prenomC = TextEditingController(text: widget.livreur.prenom.toString());
    final AdresseC = TextEditingController(text: widget.livreur.livAdresse.toString());
    final numC = TextEditingController(text: widget.livreur.livTelephone.toString());
    return Scaffold(
      appBar: AppBar(
title:Text("Modifier profile",) ,

        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {Navigator.of(context).pop();},
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

              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                widget.livreur.imageUrl.toString(),
                              ))),
                    ),
                    Positioned(
                        bottom: 0,
                        right: 0,
                        child:InkWell (
                            onTap: (){
                              String id = widget.livreur.id.toString();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => uploadphotoLivreur(id)));
                            },
                            child :Container(

                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 4,
                                  color: Theme
                                      .of(context)
                                      .scaffoldBackgroundColor,
                                ),
                                color: Colors.blueAccent,
                              ),
                              child: Icon(
                                Icons.edit,
                                color: Colors.white,
                              ),
                            ))),
                  ],
                ),
              ),


              SizedBox(
                height: 35,
              ),
              buildTextField("nom", widget.livreur.nom, nomC),
              buildTextField("prenom", widget.livreur.prenom, prenomC),
              buildTextField("numero", widget.livreur.livTelephone.toString(), numC),
              buildTextField("Location", widget.livreur.livAdresse,AdresseC ),
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
                    onPressed: () {Navigator.of(context).pop();},
                    child: Text("Annuler",
                        style: TextStyle(
                            fontSize: 14,
                            letterSpacing: 2.2,
                            color: Colors.black)),
                  ),
                  RaisedButton(
                    onPressed: () {
                      String nom = nomC.text;
                      String prenom = prenomC.text;
                      String adresse = AdresseC.text;
                      String numero = numC.text;

                      LivreurService api = LivreurService();
                      api.updateLivreur(
                          widget.livreur.id,
                          nom,
                          prenom,
                          adresse,
                          numero);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => livreur()));
                    },
                    color: Colors.blueAccent,
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    child: Text(
                      "Modifier",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Colors.white),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
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