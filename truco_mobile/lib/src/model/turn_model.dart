import 'package:truco_mobile/src/model/player_model.dart';

class TurnModel {
  int turnNumber;
  List<PlayerModel> players;
  int currentPlayerIndex; // Índice do jogador atual

  TurnModel({
    required this.turnNumber,
    required this.players,
  }) : currentPlayerIndex = 0; // Começa com o primeiro jogador

  void nextTurn() {
    // Avança para o próximo jogador
    currentPlayerIndex = (currentPlayerIndex + 1) % players.length;
  }

  void rotateDeck() {
    // Roda o baralho para o próximo jogador (mão)
    nextTurn();
  }

  PlayerModel getCurrentPlayer() {
    return players[currentPlayerIndex];
  }
}