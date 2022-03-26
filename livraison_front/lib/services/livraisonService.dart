import 'dart:convert';

import 'package:http/http.dart' as http;
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