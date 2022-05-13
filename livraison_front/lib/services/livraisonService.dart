import 'dart:convert';
import 'package:path/path.dart';
import 'package:async/async.dart';
import 'dart:io';
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
  Future<Response> updateLivraison(String sId,String idLivreur,String etatLivraison,String prix) async {

    final json =
        {"sId" : sId,"livreur": idLivreur ,"etatLivraison":etatLivraison,"prix":prix};
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
  Future<List<dynamic>> getListLivraisonByIdClient(String userId) async {


    print('Client Id is  : $userId');
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
  Future<List<dynamic>> getListLivraisonByIdLivreur(String userId) async {


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
  //Delete livraison
  Future<http.Response> deletelivraison(String id) async {
    final http.Response response = await http.delete(
      Uri.parse(AppConstants.API_URL+'/livraison/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }
  //get livraison by num

  Future<List<dynamic>> getListLivraisonByNum(String num) async {


    print('liv num is  : $num');
    final url = Uri.parse(
      AppConstants.API_URL+"/livraison/num/$num",
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


  upload(File imageFile,int? num) async {
    // open a bytestream
    var stream =
    new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(AppConstants.API_URL+"/livraison/image/$num");

    // create multipart request
    var request = new http.MultipartRequest("PUT", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('imageUrl', stream, length,
        filename: basename(imageFile.path));

    // add file to multipart
    request.files.add(multipartFile);

    // send
    var response = await request.send();
    print(response.statusCode);

    // listen for response
    response.stream.transform(utf8.decoder).listen((value) {
      print(value);
    });
  }

  Future<Response> verficationliv(String sId,String verification) async {

    final json =
    {"sId" : sId,"verification":verification};
    var data = jsonEncode(json);
    final url =
    Uri.parse(AppConstants.API_URL +" /livraison/verification/$sId");
    final request =
    await http.put(url, body: data, headers: AppConstants.HEADERS);
    Response response = Response();

    try {
      if (request.statusCode == 200) {

        response = responseFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      return Response();
    }
    return response;
  }
  Future<dynamic> getStatsLivreur(String userId) async {


    print('livreur Id is  : $userId');
    final url = Uri.parse(
      AppConstants.API_URL+"/livraison/sum/$userId",
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
        print('x is : ${x['data']}');
        listLivraison = x['data'];
        print('Stats is : $listLivraison');
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