import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../constant/app_constants.dart';
import '../models/livraison.dart';
import '../models/livraison_list.dart';
import '../models/response_model.dart';

class LivraisonService {
  static final LivraisonService _livraisonService = LivraisonService._init();

  factory LivraisonService() {
    return _livraisonService;
  }

  LivraisonService._init();
  //add new livraison
  Future<Response> addNewLivraison(Livraison livraison) async {
    final url = Uri.parse(
      AppConstants.API_URL + "/livraison",
    );
    final request = await http.post(
      url,
      body: jsonEncode(livraison.toJson()),
      headers: AppConstants.HEADERS,
    );
    Response response = Response();
    try {
      if (request.statusCode == 201) {
        print('request.body : ${request.body}');
        print(request.headers);

        response = responseFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      return Response();
    }
    return response;
  }
//List  Livraison
  Future<List<dynamic>> getAllTLivraison() async {
    final url = Uri.parse(
      AppConstants.API_URL+"/livraison",
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    var listLivraison;
    List<LivraisonList> livraisonList = [];
    try {
      if (request.statusCode == 200) {
        print('request.body : ${request.body}');
        var x = json.decode(request.body);

        listLivraison = x['result'];

      } else {
        print(request.statusCode);
        return const [];
      }
    } catch (e) {
      return const [];
    }
    return listLivraison;
  }
  //update livraison
  Future<Response> updateLivraison(String sId,String idLivreur,String etatLivraison) async {

    final json =
        {"sId" : sId,"livreur": idLivreur ,"etatLivraison":etatLivraison};
    var data = jsonEncode(json);
    final url =
    Uri.parse(AppConstants.API_URL +" /livraison/$sId");
    final request =
    await http.put(url, body: data, headers: AppConstants.HEADERS);
    Response response = Response();

    try {
      if (request.statusCode == 200) {
        print("etat livraison : $etatLivraison");
        response = responseFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      return Response();
    }
    return response;
  }
  //update livraison
  Future<Response> updateLivraisonALl(String? sId,String adressseDes,String adresseExp,String dateDeLivraison,String DesColis,int poidsColis) async {
    print("update called");
    final json =
    {"_id" : sId,"AdressseDes":adressseDes,"AdresseExp":adresseExp,"DateDeLivraison":dateDeLivraison,"DesColis":DesColis,"poidsColis":poidsColis};
    var data = jsonEncode(json);
    final url =
    Uri.parse(AppConstants.API_URL +" /livraison/$sId");
    final request =
    await http.put(url, body: data, headers: AppConstants.HEADERS);
    Response response = Response();
print("DesColis :$DesColis");
    try {
      if (request.statusCode == 200) {
        print("succes");
        response = responseFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      return Response();
    }
    return response;
  }
  //GET LIST LIVRAISON BY ID CLIENT
  Future<List<dynamic>> getLivraisonByIdClient() async {
      final prefs =
      await SharedPreferences.getInstance();
      final String? userId =
      prefs.getString('userId');
      print('userId is : $userId');
    final url = Uri.parse(
      AppConstants.API_URL+"/livraison/client/$userId",
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    var listLivraison;
    List<LivraisonList> livraisonList = [];
    try {
      if (request.statusCode == 200) {
        print('request.body : ${request.body}');
        var x = json.decode(request.body);
        print('x is : ${x['result']}');
        listLivraison = x['result'];
        print('livraisonList is : $listLivraison');
      } else {
        print(request.statusCode);
        return const [];
      }
    } catch (e) {
      return const [];
    }
    return listLivraison;
  }
  //GET LIST LIVRAISON BY ID livreur
  Future<List<dynamic>> getLivraisonByIdLivreur() async {
    final prefs =
    await SharedPreferences.getInstance();
    final String? userId =
    prefs.getString('LivreurId');
    print('livreurId is :$userId');
    print('livreur Id is  : $userId');
    final url = Uri.parse(
      AppConstants.API_URL+"/livraison/livreur/$userId",
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    var listLivraison;
    List<LivraisonList> livraisonList = [];
    try {
      if (request.statusCode == 200) {
        print('request.body : ${request.body}');
        var x = json.decode(request.body);
        print('x is : ${x['result']}');
        listLivraison = x['result'];
        print('livraisonList is : $listLivraison');
      } else {
        print(request.statusCode);
        return const [];
      }
    } catch (e) {
      return const [];
    }
    return listLivraison;
  }
}