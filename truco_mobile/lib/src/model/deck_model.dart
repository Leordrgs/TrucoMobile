// import 'dart:math';
// import 'card_model.dart';
// import 'package:truco_mobile/src/policies/deck_policies.dart';

// class Deck {
//   late List<Card> cards;
//   List<Card> discardedCards = [];
//   DeckPolicies deckPolicies = DeckPolicies();

//   Deck() {
//     cards = _generateCards();
//     _shuffle();
//   }

//   List<Card> _generateCards() {
//     List<String> ranks = ['4', '5', '6', '7', 'Q', 'J', 'K', 'A', '2', '3'];
//     List<String> suits = ['Ouros', 'Espadas', 'Copas', 'Paus'];

//     return suits
//         .expand((rank) => ranks.map((suit) =>
//             Card(rank: suit, suit: rank, value: ranks.indexOf(suit) + 1)))
//         .toList();
//   }

//   List<Card> getCards() {
//     return cards;
//   }

//   void _shuffle() {
//     cards.shuffle();
//   }

//   List<Card> dealCards(int count) {
//     int maxCards = 3;

//     if (deckPolicies.isCountGreaterThanCardsLength(count, cards)) {
//       throw Exception('Not enough cards in the deck');
//     }

//     if (deckPolicies.isCountGreaterThanMaxCards(count, maxCards)) {
//       throw Exception('Cannot deal $count cards! The maximum is $maxCards');
//     }

//     List<Card> dealtCards = cards.sublist(0, count);
//     discardedCards.addAll(dealtCards);
//     cards.removeRange(0, count);

//     return dealtCards;
//   }

//   int adjustCardValue(Card card) {
//     switch (card.suit) {
//       case 'Ouros':
//         return card.value += 11;
//       case 'Espadas':
//         return card.value += 12;
//       case 'Copas':
//         return card.value += 13;
//       case 'Paus':
//         return card.value += 14;
//       default:
//         return card.value;
//     }
//   }

//   List<Card> generateManilha(Card manilha) {
//     int nextValue = (manilha.value + 1) % 10;
//     List<Card> manilhas = [];

//     for (var card in cards) {
//       if (deckPolicies.isCardValueEqualToNextValue(card, nextValue)) {
//         card.value = adjustCardValue(card);
//         manilhas.add(card);
//       }
//     }

//     return manilhas;
//   }

//   Card getRandomCard() {
//     return cards[Random().nextInt(cards.length)];
//   }

//   void resetDeck() {
//     cards.addAll(discardedCards);
//     discardedCards.clear();
//     _generateCards();
//     _shuffle();
//   }

//   int remainingCardsCount() {
//     return cards.length;
//   }

//   Deck.fromJson(Map<String, dynamic> json) {
//     cards = (json['cards'] as List).map((e) => Card.fromJson(e)).toList();
//     discardedCards =
//         (json['discardedCards'] as List).map((e) => Card.fromJson(e)).toList();
//   }

//   Map<String, dynamic> toJson() {
//     return {
//       'cards': cards.map((card) => card.toJson()).toList(),
//       'discardedCards': discardedCards.map((card) => card.toJson()).toList(),
//     };
//   }
// }
