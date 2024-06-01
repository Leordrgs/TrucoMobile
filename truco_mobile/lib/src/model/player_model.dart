import 'package:truco_mobile/src/model/card_model.dart';
import 'package:truco_mobile/src/model/cardmodel.dart';

class PlayerModel {
  late String name;
  late List<CardModel> hand;
  int score = 0;
  List<bool> roundWins = [false, false, false];

  PlayerModel({required this.name}) {
    hand = [];
  }

  @override
  String toString() {
    return 'Player: $name, Score: $score, Hand: $hand';
  }


  void winRound(int roundNumber) {
    roundWins[roundNumber] = true;
  }

  void loseRound(int roundNumber) {
    roundWins[roundNumber] = false;
  }

  void resetRoundWins() {
    roundWins = [false, false, false];
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

  // void playCard(Card card, Table table) {
  //   if (hand.contains(card)) {
  //     removeCard(card);
  //     table.addCardToRound(card);
  //   }
  // }

  List<CardModel> getHand() {
    return hand;
  }

  void resetHand() {
    hand.clear();
  }

  // int compareCardWithManilha(CardModel card, CardModel? manilha) {
  //   if (manilha == null) {
  //     return 0;
  //   }

  //   // Primeiro, comparamos os naipes
  //   final suitComparison = card.suit.compareTo(manilha.suit);
  //   if (suitComparison != 0) {
  //     // Se os naipes forem diferentes, retornamos o resultado da comparação dos naipes
  //     return suitComparison;
  //   }

  //   // Se os naipes forem iguais, comparamos os valores das cartas
  //   return card.value.compareTo(manilha.value);
  // }

  // List<CardModel> showHand() {
  //   return List.from(hand);
  // }

  // void notify(String message) {
  //   print("$name: $message");
  // }

  // PlayerModel.fromJson(Map<String, dynamic> json)
  //     : name = json['name'],
  //       hand = (json['hand'] as List).map((e) => Card.fromJson(e)).toList();

  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'hand': hand.map((card) => card.toJson()).toList(),
  //   };
  // }

}
