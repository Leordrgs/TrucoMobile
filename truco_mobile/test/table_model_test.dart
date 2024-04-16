import 'package:test/test.dart';
import 'package:truco_mobile/src/model/card_model.dart';
import 'package:truco_mobile/src/model/table_model.dart';
import 'package:truco_mobile/src/model/trucoStatus_model.dart';

void main() {
  group('Table', () {
    late Table table;

    setUp(() {
      table = Table();
    });

    test('should initialize with default values', () {
      expect(table.deck, isNotNull);
      expect(table.team1, isNotNull);
      expect(table.team2, isNotNull);
      expect(table.currentHand, isNotNull);
      expect(table.currentFoot, isNotNull);
      expect(table.currentRoundCards, isEmpty);
      expect(table.currentRoundWinner, equals(-1));
      expect(table.currentTurn, equals(0));
      expect(table.trucoStatus, equals(TrucoStatus.NOT_REQUESTED));
      expect(table.manilha, isNull);
    });

    test('should distribute cards to players', () {
      table.distributeCards();

      expect(table.team1.player1.hand.length, equals(3));
      expect(table.team1.player2.hand.length, equals(3));
      expect(table.team2.player1.hand.length, equals(3));
      expect(table.team2.player2.hand.length, equals(3));
    });

    test('should start a new round correctly', () {
      table.startNewRound();

      expect(table.currentRoundCards, isEmpty);
      expect(table.trucoStatus, equals(TrucoStatus.NOT_REQUESTED));

      // As mãos dos jogadores devem ser reiniciadas
      expect(table.team1.player1.hand, isEmpty);
      expect(table.team1.player2.hand, isEmpty);
      expect(table.team2.player1.hand, isEmpty);
      expect(table.team2.player2.hand, isEmpty);
    });

    test('should correctly determine the round winner', () {
      // Mockando cartas para as rodadas
      final card1 = Card(rank: 'A', suit: 'Hearts', value: 14);
      final card2 = Card(rank: '7', suit: 'Spades', value: 7);
      final card3 = Card(rank: '4', suit: 'Diamonds', value: 4);
      final card4 = Card(rank: 'J', suit: 'Clubs', value: 11);

      // Simulando uma rodada com algumas cartas
      table.currentRoundCards.addAll([card1, card2, card3, card4]);

      // O vencedor esperado seria o jogador 1 da team1 (índice 0)
      expect(table.determineRoundWinner(), equals(0));
    });

    // Adicione mais testes conforme necessário para cobrir outras funcionalidades da classe Table
  });
}
