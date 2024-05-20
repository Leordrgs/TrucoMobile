import 'table_model.dart';
import 'card_model.dart';

class Player {
  late final String name;
  late List<CardModel> hand;

  Player({required this.name}) {
    hand = [];
  }

  void receiveCard(CardModel card) {
    hand.add(card);
  }

  void removeCard(CardModel card) {
    hand.remove(card);
  }

  void playCard(CardModel card, Table table) {
    if (hand.contains(card)) {
      hand.remove(card);
      table.currentRoundCards.add(card);
      table.nextTurn();
    }
  }

  int compareCardWithManilha(CardModel card, CardModel? manilha) {
    if (manilha == null) {
      return 0;
    }

    // Primeiro, comparamos os naipes
    final suitComparison = card.suit.compareTo(manilha.suit);
    if (suitComparison != 0) {
      // Se os naipes forem diferentes, retornamos o resultado da comparação dos naipes
      return suitComparison;
    }

    // Se os naipes forem iguais, comparamos os valores das cartas
    return card.value.compareTo(manilha.value);
  }

  List<CardModel> showHand() {
    return List.from(hand);
  }

  void notify(String message) {
    print("$name: $message");
  }

  Player.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        hand = (json['hand'] as List).map((e) => CardModel.fromJson(e)).toList();

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'hand': hand.map((card) => card.toJson()).toList(),
    };
  }

  void reset() {
    hand.clear();
  }
}
