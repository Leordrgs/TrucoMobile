// import 'card_model.dart';
// import 'player_model.dart';

// class Team {
//   late final String name;
//   List<Player> players;
//   int points = 0;

//   Team({required this.name, required List<Player> players})
//       : this.players = players {
//     if (players.length < 1 && players.length > 2) {
//       throw Exception('A team must have 1 to 2 players');
//     }
//   }

//   bool hasCardInHand(Card card) {
//     return players.any((player) => player.getHand().contains(card));
//   }

//   List<Card> showTeamHand() {
//     List<Card> teamHand = [];

//     for (var player in players) {
//       teamHand.addAll(player.getHand());
//     }

//     return teamHand;
//   }

//   void notifyPlayers(String message) {
//     for (var player in players) {
//       player.notify(message);
//     }
//   }

//   void addPoints(int amount) {
//     points += amount;
//   }

//   int getPoints() {
//     return points;
//   }

//   void resetPoints() {
//     points = 0;
//   }

//   Team.fromJson(Map<String, dynamic> json)
//       : name = json['name'],
//         points = json['points'],
//         players = (json['players'] as List<dynamic>?)
//                 ?.map((playerJson) =>
//                     Player.fromJson(playerJson as Map<String, dynamic>))
//                 .toList() ?? [];

//   Map<String, dynamic> toJson() => {
//         'name': name,
//         'players': players.map((player) => player.toJson()).toList(),
//         'points': points,
//       };

//   void reset() {
//     for (var player in players) {
//       player.resetHand();
//     }

//     resetPoints();
//   }
// }
