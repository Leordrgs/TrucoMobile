// // ignore_for_file: unused_local_variable

// import 'package:test/test.dart';
// import 'package:truco_mobile/src/model/team_model.dart';
// import 'package:truco_mobile/src/model/player_model.dart';
// import 'package:truco_mobile/src/model/deck_model.dart';

// void main() {
//   late Team team;
//   late Deck deck;

//   group(
//       'Team',
//       () => {
//             setUp(() => {
//                   team = Team(
//                       name: 'Team 1', players: [Player(name: 'Player 1'),Player(name: 'Player 2')]),
//                   deck = Deck()
//                 }),
//             test('should initialize with 0 points', () {
//               expect(team.getPoints(), 0);
//             }),
//             test('should add points', () {
//               team.addPoints(1);
//               expect(team.getPoints(), 1);
//             }),
//             test('should reset points', () {
//               team.addPoints(12);
//               team.resetPoints();
//               expect(team.getPoints(), 0);
//             }),
//           });
// }
