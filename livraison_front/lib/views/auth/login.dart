import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:livraison_front/constant/app_constants.dart';
import 'package:livraison_front/views/auth/register.dart';
import 'package:livraison_front/widgets/background.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:email_validator/email_validator.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

class LoginScreen extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}
void notif(String msg){
  SnackBar(

  content: Text(msg)
);}

class _SignInState extends State<LoginScreen> {
  void displayDialog(BuildContext context, String title, String text) =>
      showDialog(
        context: context,
        builder: (context) =>
            AlertDialog(
                title: Text(title),
                content: Text(text)
            ),
      );

  final _key = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  late String _email;
  late String _password;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Background(

          child: Form(
            key: _key,
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    alignment: Alignment.centerLeft,
                    padding: EdgeInsets.symmetric(horizontal: 40),
                    child: Text(
                      "Authentification",
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
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Email'),
                      validator: (val) => !EmailValidator.validate(val!, true)
                          ? 'Not a valid email.'
                          : null,
                      onSaved: (val) => _email = val!,
                    ),
                  ),
                  SizedBox(height: size.height * 0.03),
                  Container(
                    alignment: Alignment.center,
                    margin: EdgeInsets.symmetric(horizontal: 40),
                    child: TextFormField(
                      decoration: InputDecoration(labelText: 'Password'),
                      validator: (val) =>
                      val!.length < 4 ? 'Password too short..' : null,
                      onSaved: (val) => _password = val!,
                      obscureText: true,
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: Text(
                      "Forgot your password?",
                      style: TextStyle(fontSize: 12, color: Color(0XFF2661FA)),
                    ),
                  ),
                  SizedBox(height: size.height * 0.05),
                  Container(
                    alignment: Alignment.centerRight,
                    margin: EdgeInsets.symmetric(horizontal: 40, vertical: 10),
                    child: RaisedButton(

                      onPressed: () {
                        final form = _key.currentState;
                        if (form!.validate()) {
                          form.save();


                          fetchAlbum( _email.toLowerCase(), _password);
                        }
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
                          "LOGIN",
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
                      onTap: () => {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => RegisterScreen()))
                      },
                      child: Text(
                        "Don't Have an Account? Sign up",
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
        ),

    );
  }

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }

  @override
  void initState() {

    super.initState();
  }
  void fetchAlbum(String email , String password) async {
    var res = await http.post(

        Uri.parse(AppConstants.API_URL+'/api/auth/login'),

        headers: { "content-type" : "application/json",
          "accept" : "application/json",
          "Access-Control-Allow-Origin": "*", // Required for CORS support to work
          "Access-Control-Allow-Headers": "Origin,Content-Type,X-Amz-Date,Authorization,X-Api-Key,X-Amz-Security-Token,locale",
          "Access-Control-Allow-Methods": "POST, OPTIONS"},


        body: json.encode( {
          "email":email,
          "password":password
        },
        )
    );

    if (res.statusCode == 200) {
      // If the server did return a 200 OK response,
      // then parse the JSON.
      utilisateur u=utilisateur.fromJson(jsonDecode(res.body));


      if(u.user.role =="client"){
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', u.user.id);
        await prefs.setString('emailClient', u.user.email);

        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message:
            "Bienvenue ${u.user.email.split('@')[0]}",
          ),
        );
       Navigator.of(context).pushNamed('/clientHome');
        debugPrint('data from server is : ${u.toString()}');

      }
      if(u.user.role =="livreur") {
        if (u.user.etatCompte == "false") {
          showTopSnackBar(
            context,
            CustomSnackBar.error(
              message:
              "votre compte n'est pas encore verifier",
            ),
          );

          Navigator.pushNamed(context, '/');
        }
        if (u.user.etatCompte == "true") {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('LivreurId', u.user.id);
          await prefs.setString('emailLivreur', u.user.email);
          showTopSnackBar(
            context,
            CustomSnackBar.success(
              message:
              "Bienvenue ${u.user.email.split('@')[0]}",
            ),
          );

          Navigator.pushNamed(context, '/livreur');

          debugPrint('data from server is : ${u.toString()}');
        }
      }
      if(u.user.role =="responsable"){
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('adminId', u.user.id);
        await prefs.setString('adminEmail', u.user.email);
        showTopSnackBar(
          context,
          CustomSnackBar.success(
            message:
            "Bienvenue ${u.user.email.split('@')[0]}",
          ),
        );
        notif("admin login avec succée");
        Navigator.pushNamed(context, '/responsable');
        debugPrint('data from server is : ${u.toString()}');

      }
    } else {
      // If the server did not return a 200 OK response,
      // then throw an exception.
      displayDialog(context, "Invalid Username or password", "please try again");

    }
  }
}

