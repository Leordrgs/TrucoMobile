// import 'package:test/test.dart';
// import '../lib/src/model/deck_model.dart';
// import '../lib/src/model/card_model.dart';

// void main() {
//     late Deck deck;
//     group('Deck', () => {
    
//     setUp(() => {
//       deck = Deck()
//     }),

//     test('should initialize with 40 cards', () {
//       expect(deck.cards.length, 40);
//     }),

//     test('should initialize with 0 discarded cards', () {
//       expect(deck.discardedCards.length, 0);
//     }),
    
//     test('should shuffle the cards', () {
//       List<Card> oldOrder = List.from(deck.cards);
//       oldOrder.shuffle();
//       List<Card> newOrder = List.from(deck.cards);
//       expect(newOrder, isNot(equals(oldOrder)));
//     }),

//     test('should deal 3 cards', () {
//       List<Card> dealtCards = deck.dealCards(3);
//       expect(dealtCards.length, 3);
//       expect(deck.cards.length, 37);
//       expect(deck.discardedCards.length, 3);
//     }),

//     test('should not deal more than 3 cards', () {
//       expect(() => deck.dealCards(4), throwsA(isA<Exception>())); 
//     }),

//     test('generateManilha should return correct manilhas', () {

//     var deck = Deck(); 
//     var manilha = Card(suit: 'Ouros',  rank: '6', value: 3); 
//     var result = deck.generateManilha(manilha);

//     expect(result.length, 4); 
//     for (var card in result) {
//       expect(card.value, greaterThan(3));
//     }
//     }),

//   });
// }
