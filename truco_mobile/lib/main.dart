import 'package:flutter/material.dart' hide Table;
import 'package:truco_mobile/src/model/player_model.dart';
import 'package:truco_mobile/src/model/table_model.dart';
import 'package:truco_mobile/src/view/game_screen.dart';  // Importe o seu GameScreen aqui

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Table mesa = Table([Player(name: 'Player 1'), Player(name: 'Player 2'), Player(name: 'Player 3'), Player(name: 'Player 4')]);
    mesa.startNewRound();

    // Exibindo o placar
    mesa.showScore();

    // Verificando a vitória
    if (mesa.checkVictory()) {
      print('Jogo finalizado! Equipe vencedora: ${mesa.currentRoundWinner == 0 ? mesa.teams[0].name : mesa.teams[1].name}');
    }

    return MaterialApp(
      title: 'Truco Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(table: mesa),  // Passando a mesa para o GameScreen
    );
  }
}
