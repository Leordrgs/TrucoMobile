import 'package:truco_mobile/src/model/card_model.dart';

class PlayerModel {
  String? id;
  late String name;
  late List<CardModel> hand;
  int score = 0;
  bool roundOneWin = false;
  bool roundTwoWin = false;
  bool roundThreeWin = false;
  int roundsWinsCounter = 0;

  PlayerModel({required this.name, this.id, required this.hand});

  @override
  String toString() {
    return 'Player: $name, Score: $score, Hand: $hand, Round 1 Win: $roundOneWin, Round 2 Win: $roundTwoWin, Round 3 Win: $roundThreeWin, Rounds Wins: $roundsWinsCounter';
  }
  
  PlayerModel.fromMap(Map<String, dynamic> map) {
    name = map['name'];
    score = map['score'];
    roundOneWin = map['roundOneWin'];
    roundTwoWin = map['roundTwoWin'];
    roundThreeWin = map['roundThreeWin'];
    roundsWinsCounter = map['roundsWinsCounter'];
    hand = (map['hand'] as List).map((item) => CardModel.fromMap(item)).toList();
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

  toMap() {
    return {
      'name': name,
      'score': score,
      'roundOneWin': roundOneWin,
      'roundTwoWin': roundTwoWin,
      'roundThreeWin': roundThreeWin,
      'roundsWinsCounter': roundsWinsCounter,
      'hand': hand.map((card) {
      print('AQUI È O PRINT DO TO MAP CARDS $card');
        return card.toMap();
  }).toList(),
    };
  }
}
