import 'card_model.dart';
import 'player_model.dart';

class Team {
  late final String name;
  late final Player player1;
  late final Player player2;
  int points = 0;  // Adicionando o campo points

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

  // Método para adicionar pontos ao time
  void addPoints(int amount) {
    points += amount;
  }

  // Método para mostrar pontos do time
  int getPoints() {
    return points;
  }

  // Método para redefinir os pontos do time para zero
  void resetPoints() {
    points = 0;
  }

  // Método para desserializar um mapa em uma instância de Team
  Team.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        player1 = Player.fromJson(json['player1']),
        player2 = Player.fromJson(json['player2']),
        points = json['points'];

  // Método para serializar uma instância de Team em um mapa
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
