import 'package:test/test.dart';
import '../lib/src/model/team_model.dart';
import '../lib/src/model/player_model.dart';
import '../lib/src/model/card_model.dart';
import '../lib/src/model/deck_model.dart';

void main() {
  late Team team;
  late Deck deck;

  setUpAll(() {
    team = Team(name: 'Team 1', player1: Player(name: 'Player 1'), player2: Player(name: 'Player 2'));
    deck = Deck();
  });

  group('Team', () {
    test('should initialize with 0 points', () {
      expect(team.getPoints(), 0);
    });

    test('should add points', () {
      team.addPoints(1);
      expect(team.getPoints(), 1);
    });

    test('should reset points', () {
      team.addPoints(12);
      team.resetPoints();
      expect(team.getPoints(), 0);
    });
  });
}
