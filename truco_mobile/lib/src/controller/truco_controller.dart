import 'package:flutter/material.dart' hide Table, Card;
import 'package:truco_mobile/src/config/general_config.dart';
import 'package:truco_mobile/src/model/Card/cardmodel.dart';
import 'package:truco_mobile/src/model/Player/player_model.dart';
import '../model/Table/table_model.dart';
import '../model/Card/card_model.dart';
import '../service/api_service.dart';

class TrucoController with ChangeNotifier {
  late Table table;
  final ApiService apiService;

  TrucoController({required this.apiService}) {
    initializeGame();
  }

  Future<void> initializeGame() async {
    try {
      final initialGameData =
      await apiService.fetchData('initialGameDataEndpoint');
      table = Table.fromJson(initialGameData);
      notifyListeners();
    } catch (e) {
      print('Erro ao inicializar o jogo a partir da API: $e');
      table = Table([Player(name: 'Player 1'), Player(name: 'Player 2'), Player(name: 'Player 3'), Player(name: 'Player 4')]);
      notifyListeners();
    }
  }


  Future<List<CardModel>> fetchCards() async {
    ApiService apiService = ApiService(baseUrl: DECK_API);

    Map<String, dynamic> newDeck = await apiService.createNewDeck();

    String deckId = newDeck['deck_id'];
    var response = await apiService.drawCards(deckId, 12);
    List<CardModel> cards = (response['cards'] as List)
        .map((cardMap) => CardModel.fromMap(cardMap))
        .toList();
    return cards;
  }

  void playCard(Card card) {
    table.playCard(card);
  }

  void requestTruco() {
    table.requestTruco();
  }

  void respondToTruco(bool accept) {
    table.respondToTruco(accept);
  }

  void startNewRound() {
    table.startNewRound();
  }

  void resetGame() {
    table.resetGame();
  }

  void showScore() {
    table.showScore();
  }

  bool checkVictory() {
    return table.checkVictory();
  }
}