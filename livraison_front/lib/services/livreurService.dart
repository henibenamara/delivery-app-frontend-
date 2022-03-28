
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../constant/app_constants.dart';
import '../models/client_list.dart';
import '../models/livreur_list.dart';


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
    List<LivreurList> livreurList = [];
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
}