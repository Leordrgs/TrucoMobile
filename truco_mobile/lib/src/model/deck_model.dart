import 'dart:math';
import 'card_model.dart';

class Deck {
  late List<CardModel> cards;
  List<CardModel> discardedCards = [];

  Deck() {
    cards = _generateCards();
    _shuffle();
  }

  List<CardModel> _generateCards() {
    List<String> ranks = ['4', '5', '6', '7', 'Q', 'J', 'K', 'A', '2', '3'];
    List<String> suits = ['Ouros', 'Espadas', 'Copas', 'Paus'];

    return suits
        .expand((rank) => ranks.map((suit) =>
            CardModel(rank: suit, suit: rank, value: ranks.indexOf(suit) + 1)))
        .toList();
  }

  void _shuffle() {
    cards.shuffle();
  }

  List<CardModel> dealCards(int count) {
    int maxCards = 3;

    if (count > cards.length) {
      throw Exception('Not enough cards in the deck');
    }

    if (count > maxCards) {
      throw Exception('Cannot deal $count cards! The maximum is $maxCards');
    }

    List<CardModel> dealtCards = cards.sublist(0, count);
    discardedCards.addAll(dealtCards);
    cards.removeRange(0, count);

    return dealtCards;
  }

  int adjustCardValue(CardModel card) {
    switch (card.suit) {
      case 'Ouros':
        return card.value += 11;
      case 'Espadas':
        return card.value += 12;
      case 'Copas':
        return card.value += 13;
      case 'Paus':
        return card.value += 14;
      default:
        return card.value;
    }
  }

  List<CardModel> generateManilha(CardModel manilha) {
    int nextValue = (manilha.value + 1) % 10;
    List<CardModel> manilhas = [];

    for (var card in cards) {
      if (card.value == nextValue) {
        card.value = adjustCardValue(card);
        manilhas.add(card);
      }
    }

    return manilhas;
  }

  CardModel getRandomCard() {
    return cards[Random().nextInt(cards.length)];
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
    cards = (json['cards'] as List).map((e) => CardModel.fromJson(e)).toList();
    discardedCards =
        (json['discardedCards'] as List).map((e) => CardModel.fromJson(e)).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      'cards': cards.map((card) => card.toJson()).toList(),
      'discardedCards': discardedCards.map((card) => card.toJson()).toList(),
    };
  }
}
