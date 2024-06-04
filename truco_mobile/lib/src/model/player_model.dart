import 'package:truco_mobile/src/model/cardmodel.dart';

class PlayerModel {
  late String name;
  late List<CardModel> hand;
  int score = 0;
  bool roundOneWin = false;
  bool roundTwoWin = false;
  bool roundThreeWin = false;
  int roundsWinsCounter = 0;

  PlayerModel({required this.name}) {
    hand = [];
  }

  @override
  String toString() {
    return 'Player: $name, Score: $score, Hand: $hand, Round 1 Win: $roundOneWin, Round 2 Win: $roundTwoWin, Round 3 Win: $roundThreeWin, Rounds Wins: $roundsWinsCounter';
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

  bool hasWonTwoRounds() {
    if (roundOneWin) roundsWinsCounter++;
    if (roundTwoWin) roundsWinsCounter++;
    if (roundThreeWin) roundsWinsCounter++;
    return roundsWinsCounter >= 2;
  }

  void winGameAndResetRounds() {
    score++;
    resetRoundWins();
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
