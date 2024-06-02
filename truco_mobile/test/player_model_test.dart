// import 'package:test/test.dart';
// import 'package:truco_mobile/src/model/table_model.dart';
// import 'package:truco_mobile/src/model/player_model.dart';
// import 'package:truco_mobile/src/model/card_model.dart';

// void main() {
//   late Player player;
//   late Card card;
//   late Table table;

//   setUp(() {
//     player = Player(name: 'Player');
//     card = Card(rank: 'A', suit: 'Hearts', value: 14);
//     table = Table([Player(name: 'Player 1'), Player(name: 'Player 2'), Player(name: 'Player 3'), Player(name: 'Player 4')]); // Criamos uma instância simples da classe Table
//   });

//   group('Player', () {
//     test('should initialize with empty hand', () {
//       expect(player.hand, isEmpty);
//     });

//     test('should receive a card', () {
//       player.receiveCard(card);
//       expect(player.hand, contains(card));
//     });

//     test('should remove a card', () {
//       player.receiveCard(card);
//       player.removeCard(card);
//       expect(player.hand, isNot(contains(card)));
//     });

//     test('should play a card', () {
//       player.receiveCard(card);
//       player.playCard(card, table); // Agora passamos a instância de Table
//       expect(player.hand, isNot(contains(card)));
//     });

//     test('should compare card with manilha correctly', () {
//       final manilha = Card(rank: '7', suit: 'Diamonds', value: 7);

//       // Carta com mesmo naipe e valor da manilha (esperado resultado 0)
//       final sameCard = Card(rank: '7', suit: 'Diamonds', value: 7);
//       expect(player.compareCardWithManilha(sameCard, manilha), equals(0));

//       // Carta com mesmo naipe e valor diferente da manilha (esperado resultado diferente de 0)
//       final differentValueCard = Card(rank: 'A', suit: 'Diamonds', value: 14);
//       expect(player.compareCardWithManilha(differentValueCard, manilha),
//           isNot(equals(0)));

//       // Carta com naipe diferente da manilha (esperado resultado diferente de 0)
//       final differentSuitCard = Card(rank: '7', suit: 'Hearts', value: 7);
//       expect(player.compareCardWithManilha(differentSuitCard, manilha),
//           isNot(equals(0)));

//       // Carta com naipe e valor diferentes da manilha (esperado resultado diferente de 0)
//       final differentCard = Card(rank: 'A', suit: 'Hearts', value: 14);
//       expect(player.compareCardWithManilha(differentCard, manilha),
//           isNot(equals(0)));
//     });

//     // Adicione mais testes conforme necessário para cobrir outras funcionalidades da classe Player
//   });
// }
