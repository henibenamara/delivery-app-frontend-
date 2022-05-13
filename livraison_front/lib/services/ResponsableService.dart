import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import '../constant/app_constants.dart';


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
  Future<List<dynamic>> getAdminByIdUSer(userId) async {


    print('userId is : $userId');
    final url = Uri.parse(
      AppConstants.API_URL+"/admin/user/$userId",
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    var admin;

    try {
      if (request.statusCode == 200) {
        print('request.body : ${request.body}');
        var x = json.decode(request.body);
        print('x is : ${x['result']}');
        admin = x['result'];
        print('admin is : $admin');
      } else {
        print(request.statusCode);
        return const [];
      }
    } catch (e) {
      return const [];
    }
    return admin;
  }
  Future<dynamic> getStats() async {



    final url = Uri.parse(
      AppConstants.API_URL+"/stat",
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    var stats;

    try {
      if (request.statusCode == 200) {
        print('request.body : ${request.body}');
        var x = json.decode(request.body);
        print('x is : ${x['data']}');
        stats = x['data'];
        print('Stats is : $stats');
      } else {
        print(request.statusCode);
        return const [];
      }
    } catch (e) {
      return const [];
    }
    return stats;
  }
}