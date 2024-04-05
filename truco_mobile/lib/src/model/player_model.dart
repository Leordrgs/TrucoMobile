import 'table_model.dart';
import 'card_model.dart'; // Importe o modelo da carta aqui se ainda não o fez

class Player {
  late final String name;
  late List<Card> hand;

  Player({required this.name}) {
    hand = [];
  }

  void receiveCard(Card card) {
    hand.add(card);
  }

  void playCard(Card card, Table table) {
    if (hand.contains(card)) {
      hand.remove(card);
      table.currentRoundCards.add(card);
      table.nextTurn();
    }
  }

  List<Card> showHand() {
    return List.from(
        hand); // Retorna uma cópia da mão para evitar modificação externa
  }

  void notify(String message) {
    print("$name: $message");
  }
}
