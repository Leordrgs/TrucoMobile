import 'card_model.dart';

class Deck {
  late List<Card> cards;

  Deck() {
    cards = _generateCards();
    _shuffle();
  }

  List<Card> _generateCards() {
    List<String> ranks = ['4', '5', '6', '7', 'Q', 'J', 'K', 'A', '2', '3'];
    List<String> suits = ['Ouros', 'Espadas', 'Copas', 'Paus'];
    List<Card> generatedCards = [];

    for (var suit in suits) {
      for (var i = 0; i < ranks.length; i++) {
        generatedCards.add(Card(rank: ranks[i], suit: suit, value: i + 1));
      }
    }

    return generatedCards;
  }

  void _shuffle() {
    cards.shuffle();
  }

  List<Card> dealCards(int count) {
    if (count > cards.length) {
      throw Exception('Not enough cards in the deck');
    }

    List<Card> dealtCards = cards.sublist(0, count);
    cards.removeRange(0, count);

    return dealtCards;
  }
}
