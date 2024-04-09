import 'dart:math';
import 'card_model.dart';

class Deck {
  late List<Card> cards;
  List<Card> discardedCards = [];

  Deck() {
    cards = _generateCards();
    _shuffle();
  }

  List<Card> _generateCards() {
    List<String> ranks = ['4', '5', '6', '7', 'Q', 'J', 'K', 'A', '2', '3'];
    List<String> suits = ['Ouros', 'Espadas', 'Copas', 'Paus'];

    return suits
        .expand((rank) => ranks.map((suit) =>
            Card(rank: suit, suit: rank, value: ranks.indexOf(suit) + 1)))
        .toList();
  }

  void _shuffle() {
    cards.shuffle();
  }

  List<Card> dealCards(int count) {
    int maxCards = 3;

    if (count > cards.length) {
      throw Exception('Not enough cards in the deck');
    }

    if(count > maxCards) {
      throw Exception('Cannot deal $count cards! The maximum is $maxCards');
    }

    List<Card> dealtCards = cards.sublist(0, count);
    discardedCards.addAll(dealtCards);
    cards.removeRange(0, count);

    return dealtCards;
  }

  Card generateManilha() {
    Card manilha = cards[Random().nextInt(cards.length)];
    int nextValue = (manilha.value + 1) % 10;
    String nextSuit = manilha.suit;

    for (var card in cards) {
      if (card.value == nextValue && card.suit == nextSuit) {
        manilha = card;
        break;
      }
    }
    return manilha;
  }

  void resetDeck() {
    cards.addAll(discardedCards);
    discardedCards.clear();
    _generateCards();
    _shuffle();
  }

  int remainingCardsCount() {
    return cards.length;
  }

  Deck.fromJson(Map<String, dynamic> json) {
    cards = (json['cards'] as List).map((e) => Card.fromJson(e)).toList();
    discardedCards =
        (json['discardedCards'] as List).map((e) => Card.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'cards': cards.map((card) => card.toJson()).toList(),
      'discardedCards': discardedCards.map((card) => card.toJson()).toList(),
    };
  }
}
