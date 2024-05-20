import 'package:flutter/material.dart' hide Table;
import 'package:truco_mobile/src/model/table_model.dart';
import 'package:truco_mobile/src/view/Board/board_view.dart';
import 'package:truco_mobile/src/view/game_screen.dart';  // Importe o seu GameScreen aqui

void main() {
  runApp(BoardView());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Table mesa = Table();
    mesa.startNewRound();

    // Exibindo o placar
    mesa.showScore();

    // Verificando a vitória
    if (mesa.checkVictory()) {
      print('Jogo finalizado! Equipe vencedora: ${mesa.currentRoundWinner == 0 ? mesa.team1.name : mesa.team2.name}');
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
