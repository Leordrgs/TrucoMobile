import 'card_model.dart';
import 'player_model.dart';

class Team {
  late final String name;
  late final Player player1;
  late final Player player2;
  int points = 0;

  Team({required this.name, required this.player1, required this.player2});

  bool hasCardInHand(Card card) {
    return player1.hand.contains(card) || player2.hand.contains(card);
  }

  List<Card> showTeamHand() {
    List<Card> teamHand = [];

    teamHand.addAll(player1.showHand());
    teamHand.addAll(player2.showHand());

    return teamHand;
  }

  void notifyPlayers(String message) {
    player1.notify(message);
    player2.notify(message);
  }

  void addPoints(int amount) {
    points += amount;
  }

  int getPoints() {
    return points;
  }

  void resetPoints() {
    points = 0;
  }

  Team.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        player1 = Player.fromJson(json['player1']),
        player2 = Player.fromJson(json['player2']),
        points = json['points'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'player1': player1.toJson(),
        'player2': player2.toJson(),
        'points': points,
      };

  void reset() {
    player1.reset();
    player2.reset();
    resetPoints();
  }
}

