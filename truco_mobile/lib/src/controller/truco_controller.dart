import 'package:flutter/material.dart' hide Table, Card;
import '../model/table_model.dart';
import '../model/card_model.dart';
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
      table = Table();
      notifyListeners();
    }
  }

  void playCard(CardModel card) {
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