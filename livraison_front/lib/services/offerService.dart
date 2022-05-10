
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../constant/app_constants.dart';
import '../models/offer.dart';
import '../models/response_model.dart';

class OfferService {
  static final OfferService _offerService = OfferService._init();

  factory OfferService() {
    return _offerService;
  }

  OfferService._init();

  //add new offer
  Future<Response> addNewOffer(Offer offer) async {
    final url = Uri.parse(
      AppConstants.API_URL + "/offer",
    );
    final request = await http.post(
      url,
      body: jsonEncode(offer.toJson()),
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

  //get all
  Future<List<dynamic>> getAllTOffer() async {
    final url = Uri.parse(
      AppConstants.API_URL+"/offer",
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    var listLivraison;

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

  //offers by livraison
  Future<List<dynamic>> getListOfferBylivraisonId(String livraisonId) async {


    print('livraison Id is  : $livraisonId');
    final url = Uri.parse(
      AppConstants.API_URL+"/offer/livraison/$livraisonId",
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    var listoffer;

    try {
      if (request.statusCode == 200) {
        print('request.body : ${request.body}');
        var x = json.decode(request.body);
        print('x is : ${x['result']}');
        listoffer = x['result'];
        print('offer list is : $listoffer');
      } else {
        print(request.statusCode);
        return const [];
      }
    } catch (e) {
      return const [];
    }
    return listoffer;
  }

  //offers by livreur
  Future<List<dynamic>> getListOfferBylivreurId(String livreurId) async {


    print('livraison Id is  : $livreurId');
    final url = Uri.parse(
      AppConstants.API_URL+"/offer/livreur/$livreurId",
    );
    final request = await http.get(
      url,
      headers: AppConstants.HEADERS,
    );
    var listoffer;

    try {
      if (request.statusCode == 200) {
        print('request.body : ${request.body}');
        var x = json.decode(request.body);
        print('x is : ${x['result']}');
        listoffer = x['result'];
        print('offer list is : $listoffer');
      } else {
        print(request.statusCode);
        return const [];
      }
    } catch (e) {
      return const [];
    }
    return listoffer;
  }

}