import 'dart:io';
import 'dart:convert';
import 'package:async/async.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import '../constant/app_constants.dart';

import '../models/response_model.dart';


class LivreurService {
  static final LivreurService _LivreurService = LivreurService._init();

  factory LivreurService() {
    return _LivreurService;
  }
  LivreurService._init();

  Future<List<dynamic>> getAllLivreur() async {
    final url = Uri.parse(
      AppConstants.API_URL+"/livreur",
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    var listLivreur;

    try {
      if (request.statusCode == 200) {
        print('request.body : ${request.body}');
        var x = json.decode(request.body);
        print('x is : ${x['result']}');
        listLivreur = x['result'];
        print('LivreurList is : $listLivreur');
      } else {
        print(request.statusCode);
        return const [];
      }
    } catch (e) {
      return const [];
    }
    return listLivreur;
  }

  Future<List<dynamic>> getLivreurByIdUSer(userId) async {


    print('userId is : $userId');
    final url = Uri.parse(
      AppConstants.API_URL+"/livreur/user/$userId",
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    var listLivreur;

    try {
      if (request.statusCode == 200) {
        print('request.body : ${request.body}');
        var x = json.decode(request.body);
        print('x is : ${x['result']}');
        listLivreur = x['result'];
        print('livreur is : $listLivreur');
      } else {
        print(request.statusCode);
        return const [];
      }
    } catch (e) {
      return const [];
    }
    return listLivreur;
  }
  /// verification compte **/
  Future<Response> verifCompte(String? sId) async {

    final json =
    {"etatCompte":true};
    var data = jsonEncode(json);
    final url =
    Uri.parse(AppConstants.API_URL +"/livreur/verification/$sId");
    final request =
    await http.put(url, body: data, headers: AppConstants.HEADERS);
    Response response = Response();

    try {
      if (request.statusCode == 200) {
        print("Livreur accepter");
        response = responseFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      return Response();
    }
    return response;
  }
  /** update Livreur **/
  Future<Response> updateLivreur(String? sId,String nom,String prenom,String livAdresse,String livTelephone,) async {
    print("update called");
    final json =
    {"nom":nom,"prenom":prenom,"livAdresse":livAdresse,"livTelephone":livTelephone};
    var data = jsonEncode(json);
    final url =
    Uri.parse(AppConstants.API_URL +"/livreur/$sId");
    final request =
    await http.put(url, body: data, headers: AppConstants.HEADERS);
    Response response = Response();

    try {
      if (request.statusCode == 200) {
        print("Livreur modifier avec succée");
        response = responseFromJson(request.body);
      } else {
        print(request.statusCode);
      }
    } catch (e) {
      return Response();
    }
    return response;
  }
  upload(File imageFile,String? id) async {
    // open a bytestream
    var stream =
    new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(AppConstants.API_URL+"/livreur/image/$id");

    // create multipart request
    var request = new http.MultipartRequest("PUT", uri);

    // multipart that takes file
    var multipartFile = new http.MultipartFile('image', stream, length,
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



}