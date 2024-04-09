import 'package:flutter/material.dart' hide Table;
import 'package:truco_mobile/src/model/table_model.dart';
import 'package:truco_mobile/src/view/game_screen.dart';  // Importe o seu GameScreen aqui

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    Table table = Table();
    table.startNewRound();

    // Exibindo o placar
    table.showScore();

    // Verificando a vitória
    if (table.checkVictory()) {
      print('Jogo finalizado! Equipe vencedora: ${table.currentRoundWinner == 0 ? table.team1.name : table.team2.name}');
    }

    return MaterialApp(
      title: 'Truco Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(table: table),  // Passando a mesa para o GameScreen
    );
  }
}
