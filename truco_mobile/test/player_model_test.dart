import 'package:test/test.dart';
import 'card_model_test.dart';
import 'player_model_test.dart';

void main() {
  late Player player;
  late Table table;

  setUp(() {
    player = Player(name: 'Test Player');
    table = Table();
  });

  group('Player', () {
    test('should initialize with empty hand', () {
      expect(player.hand, isEmpty);
    });

    test('should receive and remove card', () {
      final card = Card(suit: 'Hearts', rank: '2');
      player.receiveCard(card);
      expect(player.hand, contains(card));

      player.removeCard(card);
      expect(player.hand, isNot(contains(card)));
    });

    test('should play card', () {
      final card = Card(suit: 'Diamonds', rank: 'K');
      player.receiveCard(card);

      player.playCard(card, table);

      expect(player.hand, isNot(contains(card)));
      expect(table.currentRoundCards, contains(card));
    });

    test('should compare card with manilha', () {
      final manilha = Card(suit: 'Clubs', rank: '7');
      final higherCard = Card(suit: 'Hearts', rank: 'A');
      final lowerCard = Card(suit: 'Spades', rank: '2');

      expect(player.compareCardWithManilha(higherCard, manilha), equals(1));
      expect(player.compareCardWithManilha(lowerCard, manilha), equals(-1));
      expect(player.compareCardWithManilha(manilha, null), equals(0));
    });

    test('should show hand', () {
      final card1 = Card(suit: 'Diamonds', rank: 'J');
      final card2 = Card(suit: 'Spades', rank: '10');
      player.receiveCard(card1);
      player.receiveCard(card2);

      final hand = player.showHand();

      expect(hand, containsAll([card1, card2]));
    });

    test('should reset hand', () {
      final card = Card(suit: 'Hearts', rank: '6');
      player.receiveCard(card);

      player.reset();

      expect(player.hand, isEmpty);
    });

    test('should notify message', () {
      final message = 'Test message';

      expect(
        () => player.notify(message),
        prints('Test Player: $message\n'),
      );
    });

    test('should deserialize from and serialize to json', () {
      final json = {
        'name': 'Player Name',
        'hand': [
          {'suit': 'Diamonds', 'rank': 'K'},
          {'suit': 'Spades', 'rank': 'Q'},
        ]
      };

      final deserializedPlayer = Player.fromJson(json);
      expect(deserializedPlayer.name, equals('Player Name'));
      expect(deserializedPlayer.hand.length, equals(2));

      final serializedJson = deserializedPlayer.toJson();
      expect(serializedJson, equals(json));
    });
  });
}
