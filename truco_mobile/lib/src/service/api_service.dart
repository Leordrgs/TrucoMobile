import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/model/Card/cardmodel.dart';

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<dynamic> fetchData(String endpoint) async {
    final response = await http.get(Uri.parse('$baseUrl/$endpoint'));

    if (response.statusCode == 200) {
      // Se você espera um JSON, pode decodificá-lo aqui
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao carregar dados da API');
    }
  }

  Future<Map<String, dynamic>> createNewDeck() async {
    var cards =
        'AD,AS,AH,AC,2D,2S,2H,2C,3D,3S,3H,3C,4D,4S,4H,4C,5D,5S,5H,5C,6D,6S,6H,6C,7D,7S,7H,7C,QD,QS,QH,QC,JD,JS,JH,JC,KD,KS,KH,KC';
    var response = await http
        .get(Uri.parse('$baseUrl/deck/new/shuffle/?deck_count=1&cards=$cards'));
    print('$baseUrl/deck/new/shuffle/?deck_count=1?cards=$cards');
    if ([200, 201].contains(response.statusCode)) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao criar novo deck');
    }
  }

  Future<Map<String, dynamic>> drawCards(String deckId, int cardAmount) async {
    var response = await http
        .get(Uri.parse('$baseUrl/deck/$deckId/draw/?count=$cardAmount'));

    if ([200, 201].contains(response.statusCode)) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao desenhar cartas');
    }
  }

  Future<Map<String, dynamic>> drawThreeCards(String deckId) async {
    return await drawCards(deckId, 3);
  }

  Future<Map<String, dynamic>> shuffleDeck(String deckId) async {
    var response = await http.get(Uri.parse('$baseUrl/deck/$deckId/shuffle/'));

    if ([200, 201].contains(response.statusCode)) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Falha ao embaralhar o deck');
    }
  }

}
