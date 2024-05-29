// import 'package:test/test.dart';
// import '../lib/src/model/card_model.dart';

// void main() {
//   group('Card', () => {
//     test('compareValue should return 1 if the value of the card is greater', () {
//       var card1 = Card(rank: 'A', suit: 'Ouros', value: 8);
//       var card2 = Card(rank: 'K', suit: 'Ouros', value: 7);
//       expect(card1.compareValue(card2), 1);
//     }),

//     test('compareValue should return -1 if the value of the card is less', () {
//       var card1 = Card(rank: 'K', suit: 'Ouros', value: 7);
//       var card2 = Card(rank: 'A', suit: 'Ouros', value: 8);
//       expect(card1.compareValue(card2), -1);
//     }),

//     test('compareValue should return 0 if the value of the card is equal', () {
//       var card1 = Card(rank: 'A', suit: 'Ouros', value: 8);
//       var card2 = Card(rank: 'A', suit: 'Ouros', value: 8);
//       expect(card1.compareValue(card2), 0);
//     }),

//     test('fromJson should create a Card from JSON', () {
//       var json = {
//         'rank': 'A',
//         'suit': 'Espadas',
//         'value': 8,
//       };
//       var card = Card.fromJson(json);
//       expect(card.rank, 'A');
//       expect(card.suit, 'Espadas');
//       expect(card.value, 8);
//     }),

//     test('toJson should create JSON from a card', () {
//       var card = Card(rank: 'A', suit: 'Espadas', value: 8);
//       var json = card.toJson();
//       expect(json['rank'], 'A');
//       expect(json['suit'], 'Espadas');
//       expect(json['value'], 8);
//     })

//   });
// }
