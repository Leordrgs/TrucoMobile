import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:truco_mobile/src/model/cardmodel.dart';

class ApiService {
  final String baseUrl;
  
  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> createNewDeck(List<String> cards) async {
    var response = await http.get(
      Uri.parse('$baseUrl/deck/new/shuffle/?deck_count=1&cards=${cards.join(',')}')
      );

    if ([200, 201].contains(response.statusCode)) {
      var result = jsonDecode(response.body); 
      print(result);
      return result;
    } else {
      throw Exception('Falha ao criar novo deck');
    }
  }

  Future<Map<String, dynamic>> drawCards(String deckId, int cardAmount) async {
    var response = await http.get(
      Uri.parse('$baseUrl/deck/$deckId/draw/?count=$cardAmount')
      );

    if ([200, 201].contains(response.statusCode)) {

      var result = jsonDecode(response.body);
      print(result);
      return result;
    } else {
      throw Exception('Falha ao desenhar cartas');
    }
  }

}
