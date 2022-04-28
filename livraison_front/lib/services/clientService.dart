
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:async/async.dart';
import '../constant/app_constants.dart';
import '../models/client_list.dart';
import '../models/response_model.dart';
import 'package:path/path.dart';

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
  Future<List<dynamic>> getClientByIdUSer(userId) async {


    print('userId is : $userId');
    final url = Uri.parse(
      AppConstants.API_URL+"/client/user/$userId",
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    var listClient;

    try {
      if (request.statusCode == 200) {
        print('request.body : ${request.body}');
        var x = json.decode(request.body);
        print('x is : ${x['result']}');
        listClient = x['result'];
        print('client is : $listClient');
      } else {
        print(request.statusCode);
        return const [];
      }
    } catch (e) {
      return const [];
    }
    return listClient;
  }
  /** update client **/
  Future<Response> updateClient(String? sId,String nom,String prenom,String adresse,String numero) async {
    print("update called");
    final json =
    {"nom":nom,"prenom":prenom,"clientAdresse":adresse,"clientTel":numero};
    var data = jsonEncode(json);
    final url =
    Uri.parse(AppConstants.API_URL +"/client/$sId");
    final request =
    await http.put(url, body: data, headers: AppConstants.HEADERS);
    Response response = Response();

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
  upload(File imageFile,String? id) async {
    // open a bytestream
    var stream =
    new http.ByteStream(DelegatingStream.typed(imageFile.openRead()));
    // get file length
    var length = await imageFile.length();

    // string to uri
    var uri = Uri.parse(AppConstants.API_URL+"/client/image/$id");

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

  /// verification compte **/
  Future<Response> verifCompte(String? sId,String etat) async {

    final json =
    {"etatCompte":etat};
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
}