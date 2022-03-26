
import 'dart:convert';
import 'package:front_livraison/models/client_list.dart';
import 'package:http/http.dart' as http;

import '../constant/app_constants.dart';
import '../models/client_list.dart';


class ClientService {
  static final ClientService _ClientService = ClientService._init();

  factory ClientService() {
    return _ClientService;
  }
  ClientService._init();

  Future<List<dynamic>> getAllClient() async {
    final url = Uri.parse(
      AppConstants.API_URL+"/client",
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    var listClient;
    List<ClientList> clientList = [];
    try {
      if (request.statusCode == 200) {
        print('request.body : ${request.body}');
        var x = json.decode(request.body);
        print('x is : ${x['result']}');
        listClient = x['result'];
        print('ClientList is : $listClient');
      } else {
        print(request.statusCode);
        return const [];
      }
    } catch (e) {
      return const [];
    }
    return listClient;
  }
}