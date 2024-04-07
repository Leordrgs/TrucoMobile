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
    discardedCards.addAll(dealtCards);
    cards.removeRange(0, count);

    return dealtCards;
  }

  Card generateManilha() {
    // Virar uma carta aleatória do baralho
    Card manilha = cards[Random().nextInt(cards.length)];

    // Determinar a próxima carta na sequência como a manilha
    int nextValue = (manilha.value + 1) % 10; // 10 é o valor máximo do rank no baralho de truco
    String nextSuit = manilha.suit;

    // Encontrar a próxima carta na sequência
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
    _shuffle();
  }

  int remainingCardsCount() {
    return cards.length;
  }

  Deck.fromJson(Map<String, dynamic> json) {
    cards = (json['cards'] as List).map((e) => Card.fromJson(e)).toList();
    discardedCards = (json['discardedCards'] as List).map((e) => Card.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'cards': cards.map((card) => card.toJson()).toList(),
      'discardedCards': discardedCards.map((card) => card.toJson()).toList(),
    };
  }
}