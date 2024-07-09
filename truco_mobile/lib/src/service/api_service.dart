import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  Future<Map<String, dynamic>> createNewDeck(List<String> cards) async {
    var response = await http.get(Uri.parse(
        '$baseUrl/deck/new/shuffle/?deck_count=1&cards=${cards.join(',')}'));
        print('Caminho 15');
    if ([200, 201].contains(response.statusCode)) {
      var result = jsonDecode(response.body);
      print('Caminho 16');
      return result;
    } else {
      print('Caminho 17');
      throw Exception('Falha ao criar novo deck');
    }
  }

  Future<Map<String, dynamic>> drawCards(String deckId, int cardAmount) async {    
    print('Caminho 18');
    var response = await http
        .get(Uri.parse('$baseUrl/deck/$deckId/draw/?count=$cardAmount'));

    if ([200, 201].contains(response.statusCode)) {
      var result = jsonDecode(response.body);
      print('Caminho 19');

      return result;
    } else {
      print('Caminho 20');
      throw Exception('Falha ao desenhar cartas');
    }
  }

  Future<Map<String, dynamic>> shuffleDeck(String deckId) async {
    var response = await http.get(Uri.parse('$baseUrl/deck/$deckId/shuffle/'));
    if ([200, 201].contains(response.statusCode)) {
      var result = jsonDecode(response.body);
      print('Caminho 21');

      return result;
    } else {
      print('Caminho 22');
      throw Exception('Falha ao embaralhar deck');
    }
  }

  Future<Map<String, dynamic>> returnCardsToDeck(String deckId) async {
    print('Caminho 23');
    var response = await http.get(Uri.parse('$baseUrl/deck/$deckId/return/'));
    print('--> RETURN CARDS $baseUrl/deck/$deckId/return');
    if ([200, 201].contains(response.statusCode)) {
      var result = jsonDecode(response.body);
      print('Caminho 24');

      return result;
    } else {
      print('Caminho 25');
      throw Exception('Falha ao retornar as cartas para o deck');
    }
  }
}
