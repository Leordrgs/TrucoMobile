import 'package:flutter/material.dart' hide Table, Card;
import '../model/table_model.dart'; /*as gameTable; // Usando um prefixo para evitar conflitos*/
import '../model/card_model.dart';
import '../service/api_service.dart';

class TrucoController with ChangeNotifier {
  late Table table; // Usando o prefixo que definimos acima
  final ApiService apiService;

  TrucoController({required this.apiService}) {
    initializeGame();
  }

  Future<void> initializeGame() async {
    try {
      final initialGameData =
          await apiService.fetchData('initialGameDataEndpoint');
      // Convertendo os dados da API para um objeto Table
      table = Table.fromJson(initialGameData);
      notifyListeners();
    } catch (e) {
      print('Erro ao inicializar o jogo a partir da API: $e');
      table = Table(); // Inicializa com uma mesa vazia em caso de erro
      notifyListeners();
    }
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