import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import '../constant/app_constants.dart';
import '../models/client_list.dart';
import '../models/response_model.dart';
import 'package:path/path.dart';

class ResponsableService {
  static final ResponsableService _ResponsableService = ResponsableService
      ._init();

  factory ResponsableService() {
    return _ResponsableService;
  }

  ResponsableService._init();
//Delete livreur
  Future<http.Response> deletelivreur(String id) async {
    final http.Response response = await http.delete(
      Uri.parse(AppConstants.API_URL+'/livreur/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );

    return response;
  }

}