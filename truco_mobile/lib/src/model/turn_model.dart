import 'package:truco_mobile/src/model/player_model.dart';

class TurnModel {
  int turnNumber;
  List<PlayerModel> players;
  int currentPlayerIndex;
  List<int> roundWinners; 

  TurnModel({
    required this.turnNumber,
    required this.players,
  }) : currentPlayerIndex = 0, roundWinners = [];

  void nextTurn() {
    
    currentPlayerIndex = (currentPlayerIndex + 1) % players.length;
  }

  void startNextRound() {
    if (roundWinners.isNotEmpty) {
      currentPlayerIndex = roundWinners.last;
    } else {
      nextTurn();
    }
  }

  void recordRoundWinner(int playerIndex) {
    roundWinners.add(playerIndex);
  }

  PlayerModel getCurrentPlayer() {
    return players[currentPlayerIndex];
  }
}