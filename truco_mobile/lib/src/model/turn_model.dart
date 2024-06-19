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

/*import 'package:flutter_truco/models/player_model.dart';

class TurnModel {
  final List<PlayerModel> players;
  int index;
  PlayerModel currentPlayer;
  int actionCount;

  TurnModel({
    required this.players,
    required this.currentPlayer,
    this.index = 0,
    this.actionCount = 0, required int turnNumber,
  });

  void nextTurn() {
    index += 1 % players.length;
    currentPlayer = players[index];
    actionCount = 0;
  }

  PlayerModel get nextPlayer {
    return players[(index + 1) % players.length];
  }

  PlayerModel get otherPlayer {
    return players.firstWhere((p) => p != currentPlayer);
  }
}*/