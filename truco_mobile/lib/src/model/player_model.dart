import 'package:truco_mobile/src/model/cardmodel.dart';

class PlayerModel {
  late String name;
  late List<CardModel> hand;
  int score = 0;
  bool roundOneWin = false;
  bool roundTwoWin = false;
  bool roundThreeWin = false;

  PlayerModel({required this.name}) {
    hand = [];
  }

  @override
  String toString() {
    return 'Player: $name, Score: $score, Hand: $hand';
  }

  void winRound(int roundNumber) {
    switch (roundNumber) {
      case 0:
        roundOneWin = true;
        break;
      case 1:
        roundTwoWin = true;
        break;
      case 2:
        roundThreeWin = true;
        break;
    }
  }

  void loseRound(int roundNumber) {
    switch (roundNumber) {
      case 0:
        roundOneWin = false;
        break;
      case 1:
        roundTwoWin = false;
        break;
      case 2:
        roundThreeWin = false;
        break;
    }
  }

  void resetRoundWins() {
    roundOneWin = false;
    roundTwoWin = false;
    roundThreeWin = false;
  }

  void addPoints(int points) {
    score += points;
  }

  void receiveCard(CardModel card) {
    hand.add(card);
  }

  void removeCard(CardModel card) {
    hand.remove(card);
  }

  List<CardModel> getHand() {
    return hand;
  }

  void resetHand() {
    hand.clear();
  }
}
